// LGPLv3 https://www.gnu.org/licenses/lgpl-3.0.en.html#license-text
// Autogenerated from Pigeon (v25.3.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#undef _HAS_EXCEPTIONS

#include "messages.g.h"

#include <flutter/basic_message_channel.h>
#include <flutter/binary_messenger.h>
#include <flutter/encodable_value.h>
#include <flutter/standard_message_codec.h>

#include <map>
#include <optional>
#include <string>

namespace SystemInformer {
using flutter::BasicMessageChannel;
using flutter::CustomEncodableValue;
using flutter::EncodableList;
using flutter::EncodableMap;
using flutter::EncodableValue;

FlutterError CreateConnectionError(const std::string channel_name) {
  return FlutterError(
      "channel-error",
      "Unable to establish connection on channel: '" + channel_name + "'.",
      EncodableValue(""));
}

// MessageData

MessageData::MessageData(
  const Code& code,
  const EncodableMap& data)
 : code_(code),
    data_(data) {}

MessageData::MessageData(
  const std::string* name,
  const std::string* description,
  const Code& code,
  const EncodableMap& data)
 : name_(name ? std::optional<std::string>(*name) : std::nullopt),
    description_(description ? std::optional<std::string>(*description) : std::nullopt),
    code_(code),
    data_(data) {}

const std::string* MessageData::name() const {
  return name_ ? &(*name_) : nullptr;
}

void MessageData::set_name(const std::string_view* value_arg) {
  name_ = value_arg ? std::optional<std::string>(*value_arg) : std::nullopt;
}

void MessageData::set_name(std::string_view value_arg) {
  name_ = value_arg;
}


const std::string* MessageData::description() const {
  return description_ ? &(*description_) : nullptr;
}

void MessageData::set_description(const std::string_view* value_arg) {
  description_ = value_arg ? std::optional<std::string>(*value_arg) : std::nullopt;
}

void MessageData::set_description(std::string_view value_arg) {
  description_ = value_arg;
}


const Code& MessageData::code() const {
  return code_;
}

void MessageData::set_code(const Code& value_arg) {
  code_ = value_arg;
}


const EncodableMap& MessageData::data() const {
  return data_;
}

void MessageData::set_data(const EncodableMap& value_arg) {
  data_ = value_arg;
}


EncodableList MessageData::ToEncodableList() const {
  EncodableList list;
  list.reserve(4);
  list.push_back(name_ ? EncodableValue(*name_) : EncodableValue());
  list.push_back(description_ ? EncodableValue(*description_) : EncodableValue());
  list.push_back(CustomEncodableValue(code_));
  list.push_back(EncodableValue(data_));
  return list;
}

MessageData MessageData::FromEncodableList(const EncodableList& list) {
  MessageData decoded(
    std::any_cast<const Code&>(std::get<CustomEncodableValue>(list[2])),
    std::get<EncodableMap>(list[3]));
  auto& encodable_name = list[0];
  if (!encodable_name.IsNull()) {
    decoded.set_name(std::get<std::string>(encodable_name));
  }
  auto& encodable_description = list[1];
  if (!encodable_description.IsNull()) {
    decoded.set_description(std::get<std::string>(encodable_description));
  }
  return decoded;
}

// ProcessItemsRaw

ProcessItemsRaw::ProcessItemsRaw(const EncodableList& items)
 : items_(items) {}

const EncodableList& ProcessItemsRaw::items() const {
  return items_;
}

void ProcessItemsRaw::set_items(const EncodableList& value_arg) {
  items_ = value_arg;
}


EncodableList ProcessItemsRaw::ToEncodableList() const {
  EncodableList list;
  list.reserve(1);
  list.push_back(EncodableValue(items_));
  return list;
}

ProcessItemsRaw ProcessItemsRaw::FromEncodableList(const EncodableList& list) {
  ProcessItemsRaw decoded(
    std::get<EncodableList>(list[0]));
  return decoded;
}


PigeonInternalCodecSerializer::PigeonInternalCodecSerializer() {}

EncodableValue PigeonInternalCodecSerializer::ReadValueOfType(
  uint8_t type,
  flutter::ByteStreamReader* stream) const {
  switch (type) {
    case 129: {
        const auto& encodable_enum_arg = ReadValue(stream);
        const int64_t enum_arg_value = encodable_enum_arg.IsNull() ? 0 : encodable_enum_arg.LongValue();
        return encodable_enum_arg.IsNull() ? EncodableValue() : CustomEncodableValue(static_cast<Code>(enum_arg_value));
      }
    case 130: {
        const auto& encodable_enum_arg = ReadValue(stream);
        const int64_t enum_arg_value = encodable_enum_arg.IsNull() ? 0 : encodable_enum_arg.LongValue();
        return encodable_enum_arg.IsNull() ? EncodableValue() : CustomEncodableValue(static_cast<SettingType>(enum_arg_value));
      }
    case 131: {
        return CustomEncodableValue(MessageData::FromEncodableList(std::get<EncodableList>(ReadValue(stream))));
      }
    case 132: {
        return CustomEncodableValue(ProcessItemsRaw::FromEncodableList(std::get<EncodableList>(ReadValue(stream))));
      }
    default:
      return flutter::StandardCodecSerializer::ReadValueOfType(type, stream);
    }
}

void PigeonInternalCodecSerializer::WriteValue(
  const EncodableValue& value,
  flutter::ByteStreamWriter* stream) const {
  if (const CustomEncodableValue* custom_value = std::get_if<CustomEncodableValue>(&value)) {
    if (custom_value->type() == typeid(Code)) {
      stream->WriteByte(129);
      WriteValue(EncodableValue(static_cast<int>(std::any_cast<Code>(*custom_value))), stream);
      return;
    }
    if (custom_value->type() == typeid(SettingType)) {
      stream->WriteByte(130);
      WriteValue(EncodableValue(static_cast<int>(std::any_cast<SettingType>(*custom_value))), stream);
      return;
    }
    if (custom_value->type() == typeid(MessageData)) {
      stream->WriteByte(131);
      WriteValue(EncodableValue(std::any_cast<MessageData>(*custom_value).ToEncodableList()), stream);
      return;
    }
    if (custom_value->type() == typeid(ProcessItemsRaw)) {
      stream->WriteByte(132);
      WriteValue(EncodableValue(std::any_cast<ProcessItemsRaw>(*custom_value).ToEncodableList()), stream);
      return;
    }
  }
  flutter::StandardCodecSerializer::WriteValue(value, stream);
}

/// The codec used by SystemInformerHostApi.
const flutter::StandardMessageCodec& SystemInformerHostApi::GetCodec() {
  return flutter::StandardMessageCodec::GetInstance(&PigeonInternalCodecSerializer::GetInstance());
}

// Sets up an instance of `SystemInformerHostApi` to handle messages through the `binary_messenger`.
void SystemInformerHostApi::SetUp(
  flutter::BinaryMessenger* binary_messenger,
  SystemInformerHostApi* api) {
  SystemInformerHostApi::SetUp(binary_messenger, api, "");
}

void SystemInformerHostApi::SetUp(
  flutter::BinaryMessenger* binary_messenger,
  SystemInformerHostApi* api,
  const std::string& message_channel_suffix) {
  const std::string prepended_suffix = message_channel_suffix.length() > 0 ? std::string(".") + message_channel_suffix : "";
  {
    BasicMessageChannel<> channel(binary_messenger, "dev.flutter.pigeon.system_informer_charts.SystemInformerHostApi.getStringSetting" + prepended_suffix, &GetCodec());
    if (api != nullptr) {
      channel.SetMessageHandler([api](const EncodableValue& message, const flutter::MessageReply<EncodableValue>& reply) {
        try {
          const auto& args = std::get<EncodableList>(message);
          const auto& encodable_key_arg = args.at(0);
          if (encodable_key_arg.IsNull()) {
            reply(WrapError("key_arg unexpectedly null."));
            return;
          }
          const auto& key_arg = std::get<std::string>(encodable_key_arg);
          ErrorOr<std::string> output = api->GetStringSetting(key_arg);
          if (output.has_error()) {
            reply(WrapError(output.error()));
            return;
          }
          EncodableList wrapped;
          wrapped.push_back(EncodableValue(std::move(output).TakeValue()));
          reply(EncodableValue(std::move(wrapped)));
        } catch (const std::exception& exception) {
          reply(WrapError(exception.what()));
        }
      });
    } else {
      channel.SetMessageHandler(nullptr);
    }
  }
  {
    BasicMessageChannel<> channel(binary_messenger, "dev.flutter.pigeon.system_informer_charts.SystemInformerHostApi.getIntegerSetting" + prepended_suffix, &GetCodec());
    if (api != nullptr) {
      channel.SetMessageHandler([api](const EncodableValue& message, const flutter::MessageReply<EncodableValue>& reply) {
        try {
          const auto& args = std::get<EncodableList>(message);
          const auto& encodable_key_arg = args.at(0);
          if (encodable_key_arg.IsNull()) {
            reply(WrapError("key_arg unexpectedly null."));
            return;
          }
          const auto& key_arg = std::get<std::string>(encodable_key_arg);
          ErrorOr<int64_t> output = api->GetIntegerSetting(key_arg);
          if (output.has_error()) {
            reply(WrapError(output.error()));
            return;
          }
          EncodableList wrapped;
          wrapped.push_back(EncodableValue(std::move(output).TakeValue()));
          reply(EncodableValue(std::move(wrapped)));
        } catch (const std::exception& exception) {
          reply(WrapError(exception.what()));
        }
      });
    } else {
      channel.SetMessageHandler(nullptr);
    }
  }
  {
    BasicMessageChannel<> channel(binary_messenger, "dev.flutter.pigeon.system_informer_charts.SystemInformerHostApi.enumProcessItems" + prepended_suffix, &GetCodec());
    if (api != nullptr) {
      channel.SetMessageHandler([api](const EncodableValue& message, const flutter::MessageReply<EncodableValue>& reply) {
        try {
          ErrorOr<ProcessItemsRaw> output = api->EnumProcessItems();
          if (output.has_error()) {
            reply(WrapError(output.error()));
            return;
          }
          EncodableList wrapped;
          wrapped.push_back(CustomEncodableValue(std::move(output).TakeValue()));
          reply(EncodableValue(std::move(wrapped)));
        } catch (const std::exception& exception) {
          reply(WrapError(exception.what()));
        }
      });
    } else {
      channel.SetMessageHandler(nullptr);
    }
  }
  {
    BasicMessageChannel<> channel(binary_messenger, "dev.flutter.pigeon.system_informer_charts.SystemInformerHostApi.addSetting" + prepended_suffix, &GetCodec());
    if (api != nullptr) {
      channel.SetMessageHandler([api](const EncodableValue& message, const flutter::MessageReply<EncodableValue>& reply) {
        try {
          const auto& args = std::get<EncodableList>(message);
          const auto& encodable_type_arg = args.at(0);
          if (encodable_type_arg.IsNull()) {
            reply(WrapError("type_arg unexpectedly null."));
            return;
          }
          const auto& type_arg = std::any_cast<const SettingType&>(std::get<CustomEncodableValue>(encodable_type_arg));
          const auto& encodable_name_arg = args.at(1);
          if (encodable_name_arg.IsNull()) {
            reply(WrapError("name_arg unexpectedly null."));
            return;
          }
          const auto& name_arg = std::get<std::string>(encodable_name_arg);
          const auto& encodable_default_value_arg = args.at(2);
          if (encodable_default_value_arg.IsNull()) {
            reply(WrapError("default_value_arg unexpectedly null."));
            return;
          }
          const auto& default_value_arg = std::get<std::string>(encodable_default_value_arg);
          std::optional<FlutterError> output = api->AddSetting(type_arg, name_arg, default_value_arg);
          if (output.has_value()) {
            reply(WrapError(output.value()));
            return;
          }
          EncodableList wrapped;
          wrapped.push_back(EncodableValue());
          reply(EncodableValue(std::move(wrapped)));
        } catch (const std::exception& exception) {
          reply(WrapError(exception.what()));
        }
      });
    } else {
      channel.SetMessageHandler(nullptr);
    }
  }
  {
    BasicMessageChannel<> channel(binary_messenger, "dev.flutter.pigeon.system_informer_charts.SystemInformerHostApi.getImageListIcon" + prepended_suffix, &GetCodec());
    if (api != nullptr) {
      channel.SetMessageHandler([api](const EncodableValue& message, const flutter::MessageReply<EncodableValue>& reply) {
        try {
          const auto& args = std::get<EncodableList>(message);
          const auto& encodable_index_arg = args.at(0);
          if (encodable_index_arg.IsNull()) {
            reply(WrapError("index_arg unexpectedly null."));
            return;
          }
          const int64_t index_arg = encodable_index_arg.LongValue();
          const auto& encodable_is_large_arg = args.at(1);
          if (encodable_is_large_arg.IsNull()) {
            reply(WrapError("is_large_arg unexpectedly null."));
            return;
          }
          const auto& is_large_arg = std::get<bool>(encodable_is_large_arg);
          ErrorOr<int64_t> output = api->GetImageListIcon(index_arg, is_large_arg);
          if (output.has_error()) {
            reply(WrapError(output.error()));
            return;
          }
          EncodableList wrapped;
          wrapped.push_back(EncodableValue(std::move(output).TakeValue()));
          reply(EncodableValue(std::move(wrapped)));
        } catch (const std::exception& exception) {
          reply(WrapError(exception.what()));
        }
      });
    } else {
      channel.SetMessageHandler(nullptr);
    }
  }
  {
    BasicMessageChannel<> channel(binary_messenger, "dev.flutter.pigeon.system_informer_charts.SystemInformerHostApi.getSystemStatistics" + prepended_suffix, &GetCodec());
    if (api != nullptr) {
      channel.SetMessageHandler([api](const EncodableValue& message, const flutter::MessageReply<EncodableValue>& reply) {
        try {
          ErrorOr<int64_t> output = api->GetSystemStatistics();
          if (output.has_error()) {
            reply(WrapError(output.error()));
            return;
          }
          EncodableList wrapped;
          wrapped.push_back(EncodableValue(std::move(output).TakeValue()));
          reply(EncodableValue(std::move(wrapped)));
        } catch (const std::exception& exception) {
          reply(WrapError(exception.what()));
        }
      });
    } else {
      channel.SetMessageHandler(nullptr);
    }
  }
  {
    BasicMessageChannel<> channel(binary_messenger, "dev.flutter.pigeon.system_informer_charts.SystemInformerHostApi.getSystemBasicInformation" + prepended_suffix, &GetCodec());
    if (api != nullptr) {
      channel.SetMessageHandler([api](const EncodableValue& message, const flutter::MessageReply<EncodableValue>& reply) {
        try {
          ErrorOr<int64_t> output = api->GetSystemBasicInformation();
          if (output.has_error()) {
            reply(WrapError(output.error()));
            return;
          }
          EncodableList wrapped;
          wrapped.push_back(EncodableValue(std::move(output).TakeValue()));
          reply(EncodableValue(std::move(wrapped)));
        } catch (const std::exception& exception) {
          reply(WrapError(exception.what()));
        }
      });
    } else {
      channel.SetMessageHandler(nullptr);
    }
  }
  {
    BasicMessageChannel<> channel(binary_messenger, "dev.flutter.pigeon.system_informer_charts.SystemInformerHostApi.sendMessage" + prepended_suffix, &GetCodec());
    if (api != nullptr) {
      channel.SetMessageHandler([api](const EncodableValue& message, const flutter::MessageReply<EncodableValue>& reply) {
        try {
          const auto& args = std::get<EncodableList>(message);
          const auto& encodable_message_arg = args.at(0);
          if (encodable_message_arg.IsNull()) {
            reply(WrapError("message_arg unexpectedly null."));
            return;
          }
          const auto& message_arg = std::any_cast<const MessageData&>(std::get<CustomEncodableValue>(encodable_message_arg));
          api->SendMessage(message_arg, [reply](ErrorOr<bool>&& output) {
            if (output.has_error()) {
              reply(WrapError(output.error()));
              return;
            }
            EncodableList wrapped;
            wrapped.push_back(EncodableValue(std::move(output).TakeValue()));
            reply(EncodableValue(std::move(wrapped)));
          });
        } catch (const std::exception& exception) {
          reply(WrapError(exception.what()));
        }
      });
    } else {
      channel.SetMessageHandler(nullptr);
    }
  }
}

EncodableValue SystemInformerHostApi::WrapError(std::string_view error_message) {
  return EncodableValue(EncodableList{
    EncodableValue(std::string(error_message)),
    EncodableValue("Error"),
    EncodableValue()
  });
}

EncodableValue SystemInformerHostApi::WrapError(const FlutterError& error) {
  return EncodableValue(EncodableList{
    EncodableValue(error.code()),
    EncodableValue(error.message()),
    error.details()
  });
}

// Generated class from Pigeon that represents Flutter messages that can be called from C++.
MessageFlutterApi::MessageFlutterApi(flutter::BinaryMessenger* binary_messenger)
 : binary_messenger_(binary_messenger),
    message_channel_suffix_("") {}

MessageFlutterApi::MessageFlutterApi(
  flutter::BinaryMessenger* binary_messenger,
  const std::string& message_channel_suffix)
 : binary_messenger_(binary_messenger),
    message_channel_suffix_(message_channel_suffix.length() > 0 ? std::string(".") + message_channel_suffix : "") {}

const flutter::StandardMessageCodec& MessageFlutterApi::GetCodec() {
  return flutter::StandardMessageCodec::GetInstance(&PigeonInternalCodecSerializer::GetInstance());
}

void MessageFlutterApi::FlutterMethod(
  const std::string* a_string_arg,
  std::function<void(const std::string&)>&& on_success,
  std::function<void(const FlutterError&)>&& on_error) {
  const std::string channel_name = "dev.flutter.pigeon.system_informer_charts.MessageFlutterApi.flutterMethod" + message_channel_suffix_;
  BasicMessageChannel<> channel(binary_messenger_, channel_name, &GetCodec());
  EncodableValue encoded_api_arguments = EncodableValue(EncodableList{
    a_string_arg ? EncodableValue(*a_string_arg) : EncodableValue(),
  });
  channel.Send(encoded_api_arguments, [channel_name, on_success = std::move(on_success), on_error = std::move(on_error)](const uint8_t* reply, size_t reply_size) {
    std::unique_ptr<EncodableValue> response = GetCodec().DecodeMessage(reply, reply_size);
    const auto& encodable_return_value = *response;
    const auto* list_return_value = std::get_if<EncodableList>(&encodable_return_value);
    if (list_return_value) {
      if (list_return_value->size() > 1) {
        on_error(FlutterError(std::get<std::string>(list_return_value->at(0)), std::get<std::string>(list_return_value->at(1)), list_return_value->at(2)));
      } else {
        const auto& return_value = std::get<std::string>(list_return_value->at(0));
        on_success(return_value);
      }
    } else {
      on_error(CreateConnectionError(channel_name));
    } 
  });
}

}  // namespace SystemInformer
