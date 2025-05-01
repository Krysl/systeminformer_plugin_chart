// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'treemap.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TreeMapLayout {

@PidMapConverter() Map<Pid, bool> get disableMap;
/// Create a copy of TreeMapLayout
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TreeMapLayoutCopyWith<TreeMapLayout> get copyWith => _$TreeMapLayoutCopyWithImpl<TreeMapLayout>(this as TreeMapLayout, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TreeMapLayout&&const DeepCollectionEquality().equals(other.disableMap, disableMap));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(disableMap));

@override
String toString() {
  return 'TreeMapLayout(disableMap: $disableMap)';
}


}

/// @nodoc
abstract mixin class $TreeMapLayoutCopyWith<$Res>  {
  factory $TreeMapLayoutCopyWith(TreeMapLayout value, $Res Function(TreeMapLayout) _then) = _$TreeMapLayoutCopyWithImpl;
@useResult
$Res call({
@PidMapConverter() Map<Pid, bool> disableMap
});




}
/// @nodoc
class _$TreeMapLayoutCopyWithImpl<$Res>
    implements $TreeMapLayoutCopyWith<$Res> {
  _$TreeMapLayoutCopyWithImpl(this._self, this._then);

  final TreeMapLayout _self;
  final $Res Function(TreeMapLayout) _then;

/// Create a copy of TreeMapLayout
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? disableMap = null,}) {
  return _then(_self.copyWith(
disableMap: null == disableMap ? _self.disableMap : disableMap // ignore: cast_nullable_to_non_nullable
as Map<Pid, bool>,
  ));
}

}


/// @nodoc


class _TreeMapLayout implements TreeMapLayout {
   _TreeMapLayout({@PidMapConverter() final  Map<Pid, bool> disableMap = const {}}): _disableMap = disableMap;
  

 final  Map<Pid, bool> _disableMap;
@override@JsonKey()@PidMapConverter() Map<Pid, bool> get disableMap {
  if (_disableMap is EqualUnmodifiableMapView) return _disableMap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_disableMap);
}


/// Create a copy of TreeMapLayout
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TreeMapLayoutCopyWith<_TreeMapLayout> get copyWith => __$TreeMapLayoutCopyWithImpl<_TreeMapLayout>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TreeMapLayout&&const DeepCollectionEquality().equals(other._disableMap, _disableMap));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_disableMap));

@override
String toString() {
  return 'TreeMapLayout(disableMap: $disableMap)';
}


}

/// @nodoc
abstract mixin class _$TreeMapLayoutCopyWith<$Res> implements $TreeMapLayoutCopyWith<$Res> {
  factory _$TreeMapLayoutCopyWith(_TreeMapLayout value, $Res Function(_TreeMapLayout) _then) = __$TreeMapLayoutCopyWithImpl;
@override @useResult
$Res call({
@PidMapConverter() Map<Pid, bool> disableMap
});




}
/// @nodoc
class __$TreeMapLayoutCopyWithImpl<$Res>
    implements _$TreeMapLayoutCopyWith<$Res> {
  __$TreeMapLayoutCopyWithImpl(this._self, this._then);

  final _TreeMapLayout _self;
  final $Res Function(_TreeMapLayout) _then;

/// Create a copy of TreeMapLayout
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? disableMap = null,}) {
  return _then(_TreeMapLayout(
disableMap: null == disableMap ? _self._disableMap : disableMap // ignore: cast_nullable_to_non_nullable
as Map<Pid, bool>,
  ));
}


}

// dart format on
