#include <phdk.h>
#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>
#include <filesystem>

#include "flutter_window.h"
#include "utils.h"

#include <mapldr.h>
#include <phapppub.h>
#include <phappresource.h>
#include <settings.h>

namespace fs = std::filesystem;

#define PLUGIN_NAME L"ProcessHacker.ProcessChart"
#define SETTING_NAME_SHOW_DEBUG_WINDOWS (PLUGIN_NAME L".ShowDebugWindows")
#define SETTING_NAME_TEST (PLUGIN_NAME L".TEST")
#define SETTING_NAME_VSCODE_LAUNCH_JSON (PLUGIN_NAME L".VSCode.launch.json")

HWND FlutterWindowHandle = NULL;
HANDLE ChartWindowThreadHandle = NULL;
PH_EVENT ChartWindowInitializedEvent = PH_EVENT_INIT;
NTSTATUS flutterWindowThread(_In_ PVOID Parameter)
{
    BOOL result;
    MSG message;
    PH_AUTO_POOL autoPool;

    PhInitializeAutoPool(&autoPool);
    ULONG _ShowDebugWindows =
        PhGetIntegerSetting(_PWSTR(SETTING_NAME_SHOW_DEBUG_WINDOWS));
    BOOL ShowDebugWindows = _ShowDebugWindows == 1;

    if (!::AttachConsole(ATTACH_PARENT_PROCESS) &&
        (::IsDebuggerPresent() || ShowDebugWindows))
    {
        CreateAndAttachConsole();
    }

    // Initialize COM, so that it is available for use in the library and/or
    // plugins.
    ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

    flutter::DartProject project(L"plugins/data");

    std::vector<std::string> command_line_arguments = GetCommandLineArguments();

    project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

    FlutterWindow window(project);
    Win32Window::Point origin(10, 10);
    Win32Window::Size size(1280, 720);
    if (!window.Create(L"systeminformer_plugin_chart", origin, size))
    {
        return EXIT_FAILURE;
    }
    window.SetQuitOnClose(true);
    FlutterWindowHandle = window.GetHandle();

    PhSetEvent(&ChartWindowInitializedEvent);

    while ((result = GetMessage(&message, NULL, 0, 0)))
    {
        if (result == -1)
            break;

        TranslateMessage(&message);
        DispatchMessage(&message);

        PhDrainAutoPool(&autoPool);
    }

    PhDeleteAutoPool(&autoPool);
    PhResetEvent(&ChartWindowInitializedEvent);

    NtClose(ChartWindowThreadHandle);
    ChartWindowThreadHandle = NULL;
    FlutterWindowHandle = NULL;

    return STATUS_SUCCESS;
}

void startFlutterWindow(_In_ HWND ParentWindowHandle)
{
    if (!ChartWindowThreadHandle)
    {
        if (!NT_SUCCESS(PhCreateThreadEx(&ChartWindowThreadHandle,
                                         flutterWindowThread, NULL)))
        {
            PhShowError(ParentWindowHandle, _PWSTR(L"%s"),
                        _PWSTR(L"Unable to create the window."));
            return;
        }

        PhWaitForEvent(&ChartWindowInitializedEvent, NULL);
    }

    PostMessage((HWND)ChartWindowThreadHandle, WM_PH_SHOW_DIALOG, 0, 0);
}

PPH_PLUGIN PluginInstance;
PH_CALLBACK_REGISTRATION PluginMenuItemCallbackRegistration;
PH_CALLBACK_REGISTRATION MainMenuInitializingCallbackRegistration;

#define ID_VIEW_WINDOWS 101

VOID NTAPI MenuItemCallback(_In_ PVOID Parameter, _In_ PVOID Context)
{
    PPH_PLUGIN_MENU_ITEM menuItem = (PPH_PLUGIN_MENU_ITEM)Parameter;

    switch (menuItem->Id)
    {
    case ID_VIEW_WINDOWS:
    {
        startFlutterWindow(menuItem->OwnerWindow);
    }
    break;
    }
}

VOID NTAPI MainMenuInitializingCallback(_In_ PVOID Parameter,
                                        _In_ PVOID Context)
{
    PPH_PLUGIN_MENU_INFORMATION menuInfo =
        (PPH_PLUGIN_MENU_INFORMATION)Parameter;
    ULONG insertIndex;
    PPH_EMENU_ITEM menuItem;

    if (menuInfo->u.MainMenu.SubMenuIndex != PH_MENU_ITEM_LOCATION_VIEW)
        return;

    if ((menuItem = PhFindEMenuItem(menuInfo->Menu, 0, NULL,
                                    PHAPP_ID_VIEW_SYSTEMINFORMATION)))
        insertIndex = PhIndexOfEMenuItem(menuInfo->Menu, menuItem) + 1;
    else
        insertIndex = ULONG_MAX;

    PhInsertEMenuItem(
        menuInfo->Menu,
        menuItem = PhPluginCreateEMenuItem(PluginInstance, 0, ID_VIEW_WINDOWS,
                                           _PWSTR(L"&Chart"), NULL),
        insertIndex);
}

LOGICAL __declspec(dllexport)
DllMain(_In_ HINSTANCE Instance, _In_ ULONG Reason, _Reserved_ PVOID Reserved)
{
    switch (Reason)
    {
    case DLL_PROCESS_ATTACH:
    {
        PPH_PLUGIN_INFORMATION info;
        PH_SETTING_CREATE settings[] = {
            {IntegerSettingType, _PWSTR(SETTING_NAME_SHOW_DEBUG_WINDOWS),
             _PWSTR(L"0")},
            {StringSettingType, _PWSTR(SETTING_NAME_TEST), _PWSTR(L"test")},
            {StringSettingType, _PWSTR(SETTING_NAME_VSCODE_LAUNCH_JSON),
             _PWSTR(L"path/to/.vscode/launch.json")},
        };

        PluginInstance = PhRegisterPlugin(_PWSTR(PLUGIN_NAME), Instance, &info);

        if (!PluginInstance)
            return FALSE;

        info->DisplayName = _PWSTR(L"Process Chart");
        info->Description = _PWSTR(L"show charts for processes");

        PhRegisterCallback(
            PhGetPluginCallback(PluginInstance, PluginCallbackMenuItem),
            MenuItemCallback, NULL, &PluginMenuItemCallbackRegistration);

        PhRegisterCallback(
            PhGetGeneralCallback(GeneralCallbackMainMenuInitializing),
            MainMenuInitializingCallback, NULL,
            &MainMenuInitializingCallbackRegistration);

        PhAddSettings(settings, RTL_NUMBER_OF(settings));
    }
    break;
    }

    return TRUE;
}
