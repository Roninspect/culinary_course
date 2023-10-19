// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$courseControllerHash() => r'923f441045dafcc7f7f83ecbcd948d63f150ca41';

/// See also [courseController].
@ProviderFor(courseController)
final courseControllerProvider = Provider<dynamic>.internal(
  courseController,
  name: r'courseControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$courseControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CourseControllerRef = ProviderRef<dynamic>;
String _$getAllCategoriesHash() => r'db97a00e1cf044a49e3f042d016748c205ab76ab';

/// See also [getAllCategories].
@ProviderFor(getAllCategories)
final getAllCategoriesProvider = FutureProvider<List<Category>>.internal(
  getAllCategories,
  name: r'getAllCategoriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getAllCategoriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetAllCategoriesRef = FutureProviderRef<List<Category>>;
String _$getCoursesByCategoriesHash() =>
    r'7614afa2f8cdc75753dc12519cf3c20ee22683d4';

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

/// See also [getCoursesByCategories].
@ProviderFor(getCoursesByCategories)
const getCoursesByCategoriesProvider = GetCoursesByCategoriesFamily();

/// See also [getCoursesByCategories].
class GetCoursesByCategoriesFamily extends Family<AsyncValue<List<Course>>> {
  /// See also [getCoursesByCategories].
  const GetCoursesByCategoriesFamily();

  /// See also [getCoursesByCategories].
  GetCoursesByCategoriesProvider call({
    required String category,
    required BuildContext context,
  }) {
    return GetCoursesByCategoriesProvider(
      category: category,
      context: context,
    );
  }

  @override
  GetCoursesByCategoriesProvider getProviderOverride(
    covariant GetCoursesByCategoriesProvider provider,
  ) {
    return call(
      category: provider.category,
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
  String? get name => r'getCoursesByCategoriesProvider';
}

/// See also [getCoursesByCategories].
class GetCoursesByCategoriesProvider extends FutureProvider<List<Course>> {
  /// See also [getCoursesByCategories].
  GetCoursesByCategoriesProvider({
    required String category,
    required BuildContext context,
  }) : this._internal(
          (ref) => getCoursesByCategories(
            ref as GetCoursesByCategoriesRef,
            category: category,
            context: context,
          ),
          from: getCoursesByCategoriesProvider,
          name: r'getCoursesByCategoriesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getCoursesByCategoriesHash,
          dependencies: GetCoursesByCategoriesFamily._dependencies,
          allTransitiveDependencies:
              GetCoursesByCategoriesFamily._allTransitiveDependencies,
          category: category,
          context: context,
        );

  GetCoursesByCategoriesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.category,
    required this.context,
  }) : super.internal();

  final String category;
  final BuildContext context;

  @override
  Override overrideWith(
    FutureOr<List<Course>> Function(GetCoursesByCategoriesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetCoursesByCategoriesProvider._internal(
        (ref) => create(ref as GetCoursesByCategoriesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        category: category,
        context: context,
      ),
    );
  }

  @override
  FutureProviderElement<List<Course>> createElement() {
    return _GetCoursesByCategoriesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetCoursesByCategoriesProvider &&
        other.category == category &&
        other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetCoursesByCategoriesRef on FutureProviderRef<List<Course>> {
  /// The parameter `category` of this provider.
  String get category;

  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _GetCoursesByCategoriesProviderElement
    extends FutureProviderElement<List<Course>> with GetCoursesByCategoriesRef {
  _GetCoursesByCategoriesProviderElement(super.provider);

  @override
  String get category => (origin as GetCoursesByCategoriesProvider).category;
  @override
  BuildContext get context =>
      (origin as GetCoursesByCategoriesProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
