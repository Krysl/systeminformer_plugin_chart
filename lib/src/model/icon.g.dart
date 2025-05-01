// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getIconPngHash() => r'86cd8b7d6879ae7bba2d828a10cd0e2f6fc5f996';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getIconPng].
@ProviderFor(getIconPng)
const getIconPngProvider = GetIconPngFamily();

/// See also [getIconPng].
class GetIconPngFamily extends Family<AsyncValue<Uint8List?>> {
  /// See also [getIconPng].
  const GetIconPngFamily();

  /// See also [getIconPng].
  GetIconPngProvider call(int index, {bool isLarge = true}) {
    return GetIconPngProvider(index, isLarge: isLarge);
  }

  @override
  GetIconPngProvider getProviderOverride(
    covariant GetIconPngProvider provider,
  ) {
    return call(provider.index, isLarge: provider.isLarge);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getIconPngProvider';
}

/// See also [getIconPng].
class GetIconPngProvider extends FutureProvider<Uint8List?> {
  /// See also [getIconPng].
  GetIconPngProvider(int index, {bool isLarge = true})
    : this._internal(
        (ref) => getIconPng(ref as GetIconPngRef, index, isLarge: isLarge),
        from: getIconPngProvider,
        name: r'getIconPngProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$getIconPngHash,
        dependencies: GetIconPngFamily._dependencies,
        allTransitiveDependencies: GetIconPngFamily._allTransitiveDependencies,
        index: index,
        isLarge: isLarge,
      );

  GetIconPngProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.index,
    required this.isLarge,
  }) : super.internal();

  final int index;
  final bool isLarge;

  @override
  Override overrideWith(
    FutureOr<Uint8List?> Function(GetIconPngRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetIconPngProvider._internal(
        (ref) => create(ref as GetIconPngRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        index: index,
        isLarge: isLarge,
      ),
    );
  }

  @override
  FutureProviderElement<Uint8List?> createElement() {
    return _GetIconPngProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetIconPngProvider &&
        other.index == index &&
        other.isLarge == isLarge;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, index.hashCode);
    hash = _SystemHash.combine(hash, isLarge.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetIconPngRef on FutureProviderRef<Uint8List?> {
  /// The parameter `index` of this provider.
  int get index;

  /// The parameter `isLarge` of this provider.
  bool get isLarge;
}

class _GetIconPngProviderElement extends FutureProviderElement<Uint8List?>
    with GetIconPngRef {
  _GetIconPngProviderElement(super.provider);

  @override
  int get index => (origin as GetIconPngProvider).index;
  @override
  bool get isLarge => (origin as GetIconPngProvider).isLarge;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
