#include <phdk.h>
#include <settings.h>

#include "utils.h"
#include "api.h"

using SystemInformer::Code;
using SystemInformer::ErrorOr;
using SystemInformer::FlutterError;
using SystemInformer::MessageData;
using SystemInformer::ProcessItemsRaw;
using SystemInformer::SystemInformerHostApi;

PPH_STRING _PhGetStringSetting(_In_ PWSTR Name)
{
    PPH_STRING ret = NULL;
    __try
    {
        ret = PhGetStringSetting(Name);
    }
    __except (EXCEPTION_EXECUTE_HANDLER)
    {
        DWORD exceptionCode = GetExceptionCode();
        switch (exceptionCode)
        {
        case STATUS_NOT_FOUND:
            return NULL;
        }
    }

    return ret;
}
ULONG _PhGetIntegerSetting(_In_ PWSTR Name, _Out_ NTSTATUS *stat)
{
    int ret = 0;
    __try
    {
        ret = PhGetIntegerSetting(Name);
    }
    __except (EXCEPTION_EXECUTE_HANDLER)
    {
        DWORD exceptionCode = GetExceptionCode();
        *stat = exceptionCode;
    }
    *stat = STATUS_SUCCESS;
    return ret;
}

ErrorOr<std::string>
PigeonApiImplementation::GetStringSetting(const std::string &key)
{
    std::unique_ptr<PWCHAR> settingKey = toPWSTR(key);
    PPH_STRING ret;
    auto _key = *settingKey.get();

    ret = _PhGetStringSetting(_key);
    if (ret == NULL)
    {
        return FlutterError("code", "GetStringSetting failed",
                            toStdString(_key));
    }

    return toStdString(ret);
}
ErrorOr<int64_t>
PigeonApiImplementation::GetIntegerSetting(const std::string &key)
{
    std::unique_ptr<PWCHAR> settingKey = toPWSTR(key);
    int64_t ret;
    NTSTATUS stat;
    auto _key = *settingKey.get();
    ret = _PhGetIntegerSetting(_key, &stat);
    if (stat != STATUS_SUCCESS)
    {
        return FlutterError("code", "GetStringSetting failed",
                            toStdString(_key));
    }

    return ret;
}

ErrorOr<ProcessItemsRaw> PigeonApiImplementation::EnumProcessItems()
{
    PPH_PROCESS_ITEM *processItems;
    ULONG numberOfProcessItems;
    PhEnumProcessItems(&processItems, &numberOfProcessItems);
    flutter::EncodableList list = {};
    for (ULONG i = 0; i < numberOfProcessItems; i++)
    {
        PH_PROCESS_ITEM *addr = processItems[i];
        list.push_back((int64_t)addr);
    }

    return ProcessItemsRaw(list);
}

std::optional<FlutterError>
PigeonApiImplementation::AddSetting(const SettingType &type,
                                    const std::string &name,
                                    const std::string &default_value)
{
    PH_STRINGREF ref1, ref2;
    PhAddSetting(static_cast<PH_SETTING_TYPE>(type),
                 toPCPH_STRINGREF(name, ref1),
                 toPCPH_STRINGREF(default_value, ref2));
    return std::nullopt;
}

void PigeonApiImplementation::SendMessage(
    const MessageData &message, std::function<void(ErrorOr<bool> reply)> result)
{
    if (message.code() == Code::kOne)
    {
        result(FlutterError("code", "message", "details"));
        return;
    }
    result(true);
}

ErrorOr<int64_t> PigeonApiImplementation::GetImageListIcon(int64_t index,
                                                           bool is_large)
{
    HBITMAP iconBitmap = NULL;
    HICON icon = PhGetImageListIcon(index, is_large);
    if (icon == NULL)
    {
        return FlutterError("code", "GetImageListIcon failed", "details");
    }

    ICONINFO iconInfo;
    if (!GetIconInfo(icon, &iconInfo))
    {
        return FlutterError("code", "GetIconInfo failed", "details");
    }

    BITMAP bmp;
    if (!GetObject(iconInfo.hbmColor, sizeof(BITMAP), &bmp))
    {
        DeleteObject(iconInfo.hbmMask);
        DeleteObject(iconInfo.hbmColor);
        return FlutterError("code", "GetObject failed", "details");
    }

    int width = bmp.bmWidth;
    int height = bmp.bmHeight;

    iconBitmap = PhIconToBitmap(icon, width, height);
    DeleteObject(iconInfo.hbmMask);
    DeleteObject(iconInfo.hbmColor);
    DestroyIcon(icon);
    return (int64_t)iconBitmap;
}

PH_PLUGIN_SYSTEM_STATISTICS PluginStatistics = {0};

ErrorOr<int64_t> PigeonApiImplementation::GetSystemStatistics()
{
    PhPluginGetSystemStatistics(&PluginStatistics);
    return (int64_t)&PluginStatistics;
}

ErrorOr<int64_t> PigeonApiImplementation::GetSystemBasicInformation()
{
    return (int64_t)&PhSystemBasicInformation;
}
