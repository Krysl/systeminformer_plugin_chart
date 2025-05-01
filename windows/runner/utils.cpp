#include <phdk.h>

#include "utils.h"

#include <flutter_windows.h>
#include <io.h>
#include <stdio.h>
#include <windows.h>
#include <shellapi.h>

#include <iostream>

void setConsoleFont()
{
    HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
    CONSOLE_FONT_INFOEX info = {sizeof(CONSOLE_FONT_INFOEX)};
    GetCurrentConsoleFontEx(hConsole, FALSE, &info);

    wcscpy(info.FaceName, L"Consolas");
    info.dwFontSize.X = 16;
    info.dwFontSize.Y = 16;

    SetCurrentConsoleFontEx(hConsole, FALSE, &info);
}

/// [How can I prevent my program from closing when a open console window is
/// closed?](https://stackoverflow.com/questions/20232685/how-can-i-prevent-my-program-from-closing-when-a-open-console-window-is-closed?noredirect=1&lq=1)
void preventConsoleClose()
{
    // Remove the close button from the console window.
    HWND hwnd = ::GetConsoleWindow();
    if (hwnd != NULL)
    {
        HMENU hMenu = ::GetSystemMenu(hwnd, FALSE);
        if (hMenu != NULL)
            DeleteMenu(hMenu, SC_CLOSE, MF_BYCOMMAND);
    }
}

void enableConsoleColors()
{
    HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
    DWORD dwMode = 0;
    GetConsoleMode(hConsole, &dwMode);
    dwMode |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
    SetConsoleMode(hConsole, dwMode);
}

void CreateAndAttachConsole()
{
    if (::AllocConsole())
    {
        SetConsoleOutputCP(CP_UTF8);
        setConsoleFont();

        enableConsoleColors();

        FILE *unused;
        if (freopen_s(&unused, "CONOUT$", "w", stdout))
        {
            _dup2(_fileno(stdout), 1);
        }
        if (freopen_s(&unused, "CONOUT$", "w", stderr))
        {
            _dup2(_fileno(stdout), 2);
        }
        std::ios::sync_with_stdio();
        FlutterDesktopResyncOutputStreams();

        preventConsoleClose();
    }
}

std::vector<std::string> GetCommandLineArguments()
{
    // Convert the UTF-16 command line arguments to UTF-8 for the Engine to use.
    int argc;
    wchar_t **argv = ::CommandLineToArgvW(::GetCommandLineW(), &argc);
    if (argv == nullptr)
    {
        return std::vector<std::string>();
    }

    std::vector<std::string> command_line_arguments;

    // Skip the first argument as it's the binary name.
    for (int i = 1; i < argc; i++)
    {
        command_line_arguments.push_back(Utf8FromUtf16(argv[i]));
    }

    ::LocalFree(argv);

    return command_line_arguments;
}

std::string Utf8FromUtf16(const wchar_t *utf16_string)
{
    if (utf16_string == nullptr)
    {
        return std::string();
    }
    unsigned int target_length =
        ::WideCharToMultiByte(CP_UTF8, WC_ERR_INVALID_CHARS, utf16_string, -1,
                              nullptr, 0, nullptr, nullptr) -
        1; // remove the trailing null character
    int input_length = (int)wcslen(utf16_string);
    std::string utf8_string;
    if (target_length == 0 || target_length > utf8_string.max_size())
    {
        return utf8_string;
    }
    utf8_string.resize(target_length);
    int converted_length = ::WideCharToMultiByte(
        CP_UTF8, WC_ERR_INVALID_CHARS, utf16_string, input_length,
        utf8_string.data(), target_length, nullptr, nullptr);
    if (converted_length == 0)
    {
        return std::string();
    }
    return utf8_string;
}

std::string toStdString(PWSTR pwch)
{
    const wchar_t *wcharPtr = pwch;
    int len = WideCharToMultiByte(CP_ACP, 0, pwch, -1, NULL, 0, NULL, NULL);
    char *charPtr = new char[len];
    WideCharToMultiByte(CP_UTF8, 0, wcharPtr, -1, charPtr, len, NULL, NULL);
    std::string str(charPtr);
    delete[] charPtr;
    return str;
}

std::string toStdString(PPH_STRING pwch)
{
    const wchar_t *wcharPtr = pwch->Buffer;
    int len = (int)pwch->Length;
    char *charPtr = new char[len];
    WideCharToMultiByte(CP_UTF8, 0, wcharPtr, -1, charPtr, len, NULL, NULL);
    std::string str(charPtr);
    delete[] charPtr;
    return str;
}

std::unique_ptr<PWSTR> toPWSTR(std::string str)
{
    int len = MultiByteToWideChar(CP_UTF8, 0, str.c_str(), -1, NULL, 0);
    wchar_t *wcharPtr = new wchar_t[len];
    MultiByteToWideChar(CP_UTF8, 0, str.c_str(), -1, wcharPtr, len);
    return std::make_unique<PWSTR>(wcharPtr);
}

PCPH_STRINGREF toPCPH_STRINGREF(std::string str, PH_STRINGREF &sr)
{
    int len = MultiByteToWideChar(CP_UTF8, 0, str.c_str(), -1, NULL, 0);
    wchar_t *wcharPtr = new wchar_t[len];
    MultiByteToWideChar(CP_UTF8, 0, str.c_str(), -1, wcharPtr, len);
    auto a = PhCreateStringEx(wcharPtr, len * sizeof(wchar_t) * 2);

    if (a)
        sr = a->sr;
    else
        PhInitializeEmptyStringRef(&sr);

    // PH_STRINGREF *ret = &PhGetStringRef(a);
    return const_cast<PCPH_STRINGREF>(&sr);
}
