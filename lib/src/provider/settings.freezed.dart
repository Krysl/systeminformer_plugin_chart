// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsData {

 bool get debugOn; Uri? get vmServiceUri; Level get logLevel;
/// Create a copy of SettingsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsDataCopyWith<SettingsData> get copyWith => _$SettingsDataCopyWithImpl<SettingsData>(this as SettingsData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsData&&(identical(other.debugOn, debugOn) || other.debugOn == debugOn)&&(identical(other.vmServiceUri, vmServiceUri) || other.vmServiceUri == vmServiceUri)&&(identical(other.logLevel, logLevel) || other.logLevel == logLevel));
}


@override
int get hashCode => Object.hash(runtimeType,debugOn,vmServiceUri,logLevel);

@override
String toString() {
  return 'SettingsData(debugOn: $debugOn, vmServiceUri: $vmServiceUri, logLevel: $logLevel)';
}


}

/// @nodoc
abstract mixin class $SettingsDataCopyWith<$Res>  {
  factory $SettingsDataCopyWith(SettingsData value, $Res Function(SettingsData) _then) = _$SettingsDataCopyWithImpl;
@useResult
$Res call({
 bool debugOn, Uri? vmServiceUri, Level logLevel
});




}
/// @nodoc
class _$SettingsDataCopyWithImpl<$Res>
    implements $SettingsDataCopyWith<$Res> {
  _$SettingsDataCopyWithImpl(this._self, this._then);

  final SettingsData _self;
  final $Res Function(SettingsData) _then;

/// Create a copy of SettingsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? debugOn = null,Object? vmServiceUri = freezed,Object? logLevel = null,}) {
  return _then(_self.copyWith(
debugOn: null == debugOn ? _self.debugOn : debugOn // ignore: cast_nullable_to_non_nullable
as bool,vmServiceUri: freezed == vmServiceUri ? _self.vmServiceUri : vmServiceUri // ignore: cast_nullable_to_non_nullable
as Uri?,logLevel: null == logLevel ? _self.logLevel : logLevel // ignore: cast_nullable_to_non_nullable
as Level,
  ));
}

}


/// @nodoc


class _SettingsData implements SettingsData {
   _SettingsData({this.debugOn = false, this.vmServiceUri, this.logLevel = Level.error});
  

@override@JsonKey() final  bool debugOn;
@override final  Uri? vmServiceUri;
@override@JsonKey() final  Level logLevel;

/// Create a copy of SettingsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsDataCopyWith<_SettingsData> get copyWith => __$SettingsDataCopyWithImpl<_SettingsData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsData&&(identical(other.debugOn, debugOn) || other.debugOn == debugOn)&&(identical(other.vmServiceUri, vmServiceUri) || other.vmServiceUri == vmServiceUri)&&(identical(other.logLevel, logLevel) || other.logLevel == logLevel));
}


@override
int get hashCode => Object.hash(runtimeType,debugOn,vmServiceUri,logLevel);

@override
String toString() {
  return 'SettingsData(debugOn: $debugOn, vmServiceUri: $vmServiceUri, logLevel: $logLevel)';
}


}

/// @nodoc
abstract mixin class _$SettingsDataCopyWith<$Res> implements $SettingsDataCopyWith<$Res> {
  factory _$SettingsDataCopyWith(_SettingsData value, $Res Function(_SettingsData) _then) = __$SettingsDataCopyWithImpl;
@override @useResult
$Res call({
 bool debugOn, Uri? vmServiceUri, Level logLevel
});




}
/// @nodoc
class __$SettingsDataCopyWithImpl<$Res>
    implements _$SettingsDataCopyWith<$Res> {
  __$SettingsDataCopyWithImpl(this._self, this._then);

  final _SettingsData _self;
  final $Res Function(_SettingsData) _then;

/// Create a copy of SettingsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? debugOn = null,Object? vmServiceUri = freezed,Object? logLevel = null,}) {
  return _then(_SettingsData(
debugOn: null == debugOn ? _self.debugOn : debugOn // ignore: cast_nullable_to_non_nullable
as bool,vmServiceUri: freezed == vmServiceUri ? _self.vmServiceUri : vmServiceUri // ignore: cast_nullable_to_non_nullable
as Uri?,logLevel: null == logLevel ? _self.logLevel : logLevel // ignore: cast_nullable_to_non_nullable
as Level,
  ));
}


}

// dart format on
