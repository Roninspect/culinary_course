// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getFeaturedHash() => r'd596e3219c8095ad759adb423d988015ce4e4856';

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

/// See also [getFeatured].
@ProviderFor(getFeatured)
const getFeaturedProvider = GetFeaturedFamily();

/// See also [getFeatured].
class GetFeaturedFamily extends Family<AsyncValue<Course>> {
  /// See also [getFeatured].
  const GetFeaturedFamily();

  /// See also [getFeatured].
  GetFeaturedProvider call({
    required BuildContext context,
  }) {
    return GetFeaturedProvider(
      context: context,
    );
  }

  @override
  GetFeaturedProvider getProviderOverride(
    covariant GetFeaturedProvider provider,
  ) {
    return call(
      context: provider.context,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getFeaturedProvider';
}

/// See also [getFeatured].
class GetFeaturedProvider extends FutureProvider<Course> {
  /// See also [getFeatured].
  GetFeaturedProvider({
    required BuildContext context,
  }) : this._internal(
          (ref) => getFeatured(
            ref as GetFeaturedRef,
            context: context,
          ),
          from: getFeaturedProvider,
          name: r'getFeaturedProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getFeaturedHash,
          dependencies: GetFeaturedFamily._dependencies,
          allTransitiveDependencies:
              GetFeaturedFamily._allTransitiveDependencies,
          context: context,
        );

  GetFeaturedProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
  }) : super.internal();

  final BuildContext context;

  @override
  Override overrideWith(
    FutureOr<Course> Function(GetFeaturedRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetFeaturedProvider._internal(
        (ref) => create(ref as GetFeaturedRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
      ),
    );
  }

  @override
  FutureProviderElement<Course> createElement() {
    return _GetFeaturedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetFeaturedProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetFeaturedRef on FutureProviderRef<Course> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _GetFeaturedProviderElement extends FutureProviderElement<Course>
    with GetFeaturedRef {
  _GetFeaturedProviderElement(super.provider);

  @override
  BuildContext get context => (origin as GetFeaturedProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
