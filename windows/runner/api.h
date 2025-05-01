#ifndef API_H_
#define API_H_
#include <memory>
#include "messages.g.h"

using SystemInformer::ErrorOr;
using SystemInformer::FlutterError;
using SystemInformer::MessageData;
using SystemInformer::ProcessItemsRaw;
using SystemInformer::SettingType;
using SystemInformer::SystemInformerHostApi;

class PigeonApiImplementation : public SystemInformerHostApi
{
  public:
    PigeonApiImplementation() {}
    virtual ~PigeonApiImplementation() {}

    ErrorOr<std::string> GetStringSetting(const std::string &key) override;
    ErrorOr<int64_t> GetIntegerSetting(const std::string &key) override;
    ErrorOr<ProcessItemsRaw> EnumProcessItems() override;
    std::optional<FlutterError>
    AddSetting(const SettingType &type, const std::string &name,
               const std::string &default_value) override;

    void SendMessage(const MessageData &message,
                     std::function<void(ErrorOr<bool> reply)> result);

    ErrorOr<int64_t> GetImageListIcon(int64_t index, bool is_large) override;

    ErrorOr<int64_t> GetSystemStatistics() override;

    ErrorOr<int64_t> GetSystemBasicInformation() override;
};

#endif // API_H_
