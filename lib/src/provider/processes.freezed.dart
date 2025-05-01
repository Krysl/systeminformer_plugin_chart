// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'processes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProcesssInfo {

 ProcessItems? get processItems; ProcessItemType? get itemsType;@protected Pointer<PH_PLUGIN_SYSTEM_STATISTICS>? get ptrStatistics; PluginSystemStatisticsInformation? get statistics; Pointer<PH_SYSTEM_BASIC_INFORMATION>? get ptrSystemBasicInformation; bool get sortBySize; DataPicker get dataSetSelect; bool get hideIdle; String? get briefInfo;
/// Create a copy of ProcesssInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProcesssInfoCopyWith<ProcesssInfo> get copyWith => _$ProcesssInfoCopyWithImpl<ProcesssInfo>(this as ProcesssInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProcesssInfo&&(identical(other.processItems, processItems) || other.processItems == processItems)&&(identical(other.itemsType, itemsType) || other.itemsType == itemsType)&&(identical(other.ptrStatistics, ptrStatistics) || other.ptrStatistics == ptrStatistics)&&(identical(other.statistics, statistics) || other.statistics == statistics)&&(identical(other.ptrSystemBasicInformation, ptrSystemBasicInformation) || other.ptrSystemBasicInformation == ptrSystemBasicInformation)&&(identical(other.sortBySize, sortBySize) || other.sortBySize == sortBySize)&&(identical(other.dataSetSelect, dataSetSelect) || other.dataSetSelect == dataSetSelect)&&(identical(other.hideIdle, hideIdle) || other.hideIdle == hideIdle)&&(identical(other.briefInfo, briefInfo) || other.briefInfo == briefInfo));
}


@override
int get hashCode => Object.hash(runtimeType,processItems,itemsType,ptrStatistics,statistics,ptrSystemBasicInformation,sortBySize,dataSetSelect,hideIdle,briefInfo);

@override
String toString() {
  return 'ProcesssInfo(processItems: $processItems, itemsType: $itemsType, ptrStatistics: $ptrStatistics, statistics: $statistics, ptrSystemBasicInformation: $ptrSystemBasicInformation, sortBySize: $sortBySize, dataSetSelect: $dataSetSelect, hideIdle: $hideIdle, briefInfo: $briefInfo)';
}


}

/// @nodoc
abstract mixin class $ProcesssInfoCopyWith<$Res>  {
  factory $ProcesssInfoCopyWith(ProcesssInfo value, $Res Function(ProcesssInfo) _then) = _$ProcesssInfoCopyWithImpl;
@useResult
$Res call({
 ProcessItems? processItems, ProcessItemType? itemsType,@protected Pointer<PH_PLUGIN_SYSTEM_STATISTICS>? ptrStatistics, PluginSystemStatisticsInformation? statistics, Pointer<PH_SYSTEM_BASIC_INFORMATION>? ptrSystemBasicInformation, bool sortBySize, DataPicker dataSetSelect, bool hideIdle, String? briefInfo
});




}
/// @nodoc
class _$ProcesssInfoCopyWithImpl<$Res>
    implements $ProcesssInfoCopyWith<$Res> {
  _$ProcesssInfoCopyWithImpl(this._self, this._then);

  final ProcesssInfo _self;
  final $Res Function(ProcesssInfo) _then;

/// Create a copy of ProcesssInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? processItems = freezed,Object? itemsType = freezed,Object? ptrStatistics = freezed,Object? statistics = freezed,Object? ptrSystemBasicInformation = freezed,Object? sortBySize = null,Object? dataSetSelect = null,Object? hideIdle = null,Object? briefInfo = freezed,}) {
  return _then(_self.copyWith(
processItems: freezed == processItems ? _self.processItems : processItems // ignore: cast_nullable_to_non_nullable
as ProcessItems?,itemsType: freezed == itemsType ? _self.itemsType : itemsType // ignore: cast_nullable_to_non_nullable
as ProcessItemType?,ptrStatistics: freezed == ptrStatistics ? _self.ptrStatistics : ptrStatistics // ignore: cast_nullable_to_non_nullable
as Pointer<PH_PLUGIN_SYSTEM_STATISTICS>?,statistics: freezed == statistics ? _self.statistics : statistics // ignore: cast_nullable_to_non_nullable
as PluginSystemStatisticsInformation?,ptrSystemBasicInformation: freezed == ptrSystemBasicInformation ? _self.ptrSystemBasicInformation : ptrSystemBasicInformation // ignore: cast_nullable_to_non_nullable
as Pointer<PH_SYSTEM_BASIC_INFORMATION>?,sortBySize: null == sortBySize ? _self.sortBySize : sortBySize // ignore: cast_nullable_to_non_nullable
as bool,dataSetSelect: null == dataSetSelect ? _self.dataSetSelect : dataSetSelect // ignore: cast_nullable_to_non_nullable
as DataPicker,hideIdle: null == hideIdle ? _self.hideIdle : hideIdle // ignore: cast_nullable_to_non_nullable
as bool,briefInfo: freezed == briefInfo ? _self.briefInfo : briefInfo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _ProcesssInfo implements ProcesssInfo {
   _ProcesssInfo({this.processItems, this.itemsType, @protected this.ptrStatistics, this.statistics, this.ptrSystemBasicInformation, this.sortBySize = true, this.dataSetSelect = DataPicker.privateBytes, this.hideIdle = false, this.briefInfo});
  

@override final  ProcessItems? processItems;
@override final  ProcessItemType? itemsType;
@override@protected final  Pointer<PH_PLUGIN_SYSTEM_STATISTICS>? ptrStatistics;
@override final  PluginSystemStatisticsInformation? statistics;
@override final  Pointer<PH_SYSTEM_BASIC_INFORMATION>? ptrSystemBasicInformation;
@override@JsonKey() final  bool sortBySize;
@override@JsonKey() final  DataPicker dataSetSelect;
@override@JsonKey() final  bool hideIdle;
@override final  String? briefInfo;

/// Create a copy of ProcesssInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProcesssInfoCopyWith<_ProcesssInfo> get copyWith => __$ProcesssInfoCopyWithImpl<_ProcesssInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProcesssInfo&&(identical(other.processItems, processItems) || other.processItems == processItems)&&(identical(other.itemsType, itemsType) || other.itemsType == itemsType)&&(identical(other.ptrStatistics, ptrStatistics) || other.ptrStatistics == ptrStatistics)&&(identical(other.statistics, statistics) || other.statistics == statistics)&&(identical(other.ptrSystemBasicInformation, ptrSystemBasicInformation) || other.ptrSystemBasicInformation == ptrSystemBasicInformation)&&(identical(other.sortBySize, sortBySize) || other.sortBySize == sortBySize)&&(identical(other.dataSetSelect, dataSetSelect) || other.dataSetSelect == dataSetSelect)&&(identical(other.hideIdle, hideIdle) || other.hideIdle == hideIdle)&&(identical(other.briefInfo, briefInfo) || other.briefInfo == briefInfo));
}


@override
int get hashCode => Object.hash(runtimeType,processItems,itemsType,ptrStatistics,statistics,ptrSystemBasicInformation,sortBySize,dataSetSelect,hideIdle,briefInfo);

@override
String toString() {
  return 'ProcesssInfo(processItems: $processItems, itemsType: $itemsType, ptrStatistics: $ptrStatistics, statistics: $statistics, ptrSystemBasicInformation: $ptrSystemBasicInformation, sortBySize: $sortBySize, dataSetSelect: $dataSetSelect, hideIdle: $hideIdle, briefInfo: $briefInfo)';
}


}

/// @nodoc
abstract mixin class _$ProcesssInfoCopyWith<$Res> implements $ProcesssInfoCopyWith<$Res> {
  factory _$ProcesssInfoCopyWith(_ProcesssInfo value, $Res Function(_ProcesssInfo) _then) = __$ProcesssInfoCopyWithImpl;
@override @useResult
$Res call({
 ProcessItems? processItems, ProcessItemType? itemsType,@protected Pointer<PH_PLUGIN_SYSTEM_STATISTICS>? ptrStatistics, PluginSystemStatisticsInformation? statistics, Pointer<PH_SYSTEM_BASIC_INFORMATION>? ptrSystemBasicInformation, bool sortBySize, DataPicker dataSetSelect, bool hideIdle, String? briefInfo
});




}
/// @nodoc
class __$ProcesssInfoCopyWithImpl<$Res>
    implements _$ProcesssInfoCopyWith<$Res> {
  __$ProcesssInfoCopyWithImpl(this._self, this._then);

  final _ProcesssInfo _self;
  final $Res Function(_ProcesssInfo) _then;

/// Create a copy of ProcesssInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? processItems = freezed,Object? itemsType = freezed,Object? ptrStatistics = freezed,Object? statistics = freezed,Object? ptrSystemBasicInformation = freezed,Object? sortBySize = null,Object? dataSetSelect = null,Object? hideIdle = null,Object? briefInfo = freezed,}) {
  return _then(_ProcesssInfo(
processItems: freezed == processItems ? _self.processItems : processItems // ignore: cast_nullable_to_non_nullable
as ProcessItems?,itemsType: freezed == itemsType ? _self.itemsType : itemsType // ignore: cast_nullable_to_non_nullable
as ProcessItemType?,ptrStatistics: freezed == ptrStatistics ? _self.ptrStatistics : ptrStatistics // ignore: cast_nullable_to_non_nullable
as Pointer<PH_PLUGIN_SYSTEM_STATISTICS>?,statistics: freezed == statistics ? _self.statistics : statistics // ignore: cast_nullable_to_non_nullable
as PluginSystemStatisticsInformation?,ptrSystemBasicInformation: freezed == ptrSystemBasicInformation ? _self.ptrSystemBasicInformation : ptrSystemBasicInformation // ignore: cast_nullable_to_non_nullable
as Pointer<PH_SYSTEM_BASIC_INFORMATION>?,sortBySize: null == sortBySize ? _self.sortBySize : sortBySize // ignore: cast_nullable_to_non_nullable
as bool,dataSetSelect: null == dataSetSelect ? _self.dataSetSelect : dataSetSelect // ignore: cast_nullable_to_non_nullable
as DataPicker,hideIdle: null == hideIdle ? _self.hideIdle : hideIdle // ignore: cast_nullable_to_non_nullable
as bool,briefInfo: freezed == briefInfo ? _self.briefInfo : briefInfo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
