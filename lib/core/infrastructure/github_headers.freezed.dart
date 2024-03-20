// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'github_headers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GithubHeaders {
  String? get eTag => throw _privateConstructorUsedError;
  PaginationLink? get link => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GithubHeadersCopyWith<GithubHeaders> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GithubHeadersCopyWith<$Res> {
  factory $GithubHeadersCopyWith(
          GithubHeaders value, $Res Function(GithubHeaders) then) =
      _$GithubHeadersCopyWithImpl<$Res, GithubHeaders>;
  @useResult
  $Res call({String? eTag, PaginationLink? link});

  $PaginationLinkCopyWith<$Res>? get link;
}

/// @nodoc
class _$GithubHeadersCopyWithImpl<$Res, $Val extends GithubHeaders>
    implements $GithubHeadersCopyWith<$Res> {
  _$GithubHeadersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eTag = freezed,
    Object? link = freezed,
  }) {
    return _then(_value.copyWith(
      eTag: freezed == eTag
          ? _value.eTag
          : eTag // ignore: cast_nullable_to_non_nullable
              as String?,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as PaginationLink?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PaginationLinkCopyWith<$Res>? get link {
    if (_value.link == null) {
      return null;
    }

    return $PaginationLinkCopyWith<$Res>(_value.link!, (value) {
      return _then(_value.copyWith(link: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GithubHeadersImplCopyWith<$Res>
    implements $GithubHeadersCopyWith<$Res> {
  factory _$$GithubHeadersImplCopyWith(
          _$GithubHeadersImpl value, $Res Function(_$GithubHeadersImpl) then) =
      __$$GithubHeadersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? eTag, PaginationLink? link});

  @override
  $PaginationLinkCopyWith<$Res>? get link;
}

/// @nodoc
class __$$GithubHeadersImplCopyWithImpl<$Res>
    extends _$GithubHeadersCopyWithImpl<$Res, _$GithubHeadersImpl>
    implements _$$GithubHeadersImplCopyWith<$Res> {
  __$$GithubHeadersImplCopyWithImpl(
      _$GithubHeadersImpl _value, $Res Function(_$GithubHeadersImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eTag = freezed,
    Object? link = freezed,
  }) {
    return _then(_$GithubHeadersImpl(
      eTag: freezed == eTag
          ? _value.eTag
          : eTag // ignore: cast_nullable_to_non_nullable
              as String?,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as PaginationLink?,
    ));
  }
}

/// @nodoc

class _$GithubHeadersImpl extends _GithubHeaders {
  const _$GithubHeadersImpl({this.eTag, this.link}) : super._();

  @override
  final String? eTag;
  @override
  final PaginationLink? link;

  @override
  String toString() {
    return 'GithubHeaders(eTag: $eTag, link: $link)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GithubHeadersImpl &&
            (identical(other.eTag, eTag) || other.eTag == eTag) &&
            (identical(other.link, link) || other.link == link));
  }

  @override
  int get hashCode => Object.hash(runtimeType, eTag, link);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GithubHeadersImplCopyWith<_$GithubHeadersImpl> get copyWith =>
      __$$GithubHeadersImplCopyWithImpl<_$GithubHeadersImpl>(this, _$identity);
}

abstract class _GithubHeaders extends GithubHeaders {
  const factory _GithubHeaders(
      {final String? eTag, final PaginationLink? link}) = _$GithubHeadersImpl;
  const _GithubHeaders._() : super._();

  @override
  String? get eTag;
  @override
  PaginationLink? get link;
  @override
  @JsonKey(ignore: true)
  _$$GithubHeadersImplCopyWith<_$GithubHeadersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PaginationLink {
  int? get maxPage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PaginationLinkCopyWith<PaginationLink> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationLinkCopyWith<$Res> {
  factory $PaginationLinkCopyWith(
          PaginationLink value, $Res Function(PaginationLink) then) =
      _$PaginationLinkCopyWithImpl<$Res, PaginationLink>;
  @useResult
  $Res call({int? maxPage});
}

/// @nodoc
class _$PaginationLinkCopyWithImpl<$Res, $Val extends PaginationLink>
    implements $PaginationLinkCopyWith<$Res> {
  _$PaginationLinkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxPage = freezed,
  }) {
    return _then(_value.copyWith(
      maxPage: freezed == maxPage
          ? _value.maxPage
          : maxPage // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaginationLinkImplCopyWith<$Res>
    implements $PaginationLinkCopyWith<$Res> {
  factory _$$PaginationLinkImplCopyWith(_$PaginationLinkImpl value,
          $Res Function(_$PaginationLinkImpl) then) =
      __$$PaginationLinkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? maxPage});
}

/// @nodoc
class __$$PaginationLinkImplCopyWithImpl<$Res>
    extends _$PaginationLinkCopyWithImpl<$Res, _$PaginationLinkImpl>
    implements _$$PaginationLinkImplCopyWith<$Res> {
  __$$PaginationLinkImplCopyWithImpl(
      _$PaginationLinkImpl _value, $Res Function(_$PaginationLinkImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxPage = freezed,
  }) {
    return _then(_$PaginationLinkImpl(
      maxPage: freezed == maxPage
          ? _value.maxPage
          : maxPage // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$PaginationLinkImpl extends _PaginationLink {
  const _$PaginationLinkImpl({this.maxPage}) : super._();

  @override
  final int? maxPage;

  @override
  String toString() {
    return 'PaginationLink(maxPage: $maxPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginationLinkImpl &&
            (identical(other.maxPage, maxPage) || other.maxPage == maxPage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, maxPage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginationLinkImplCopyWith<_$PaginationLinkImpl> get copyWith =>
      __$$PaginationLinkImplCopyWithImpl<_$PaginationLinkImpl>(
          this, _$identity);
}

abstract class _PaginationLink extends PaginationLink {
  const factory _PaginationLink({final int? maxPage}) = _$PaginationLinkImpl;
  const _PaginationLink._() : super._();

  @override
  int? get maxPage;
  @override
  @JsonKey(ignore: true)
  _$$PaginationLinkImplCopyWith<_$PaginationLinkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
