import 'package:dio/dio.dart';
import 'package:repo_viewer/core/infrastructure/github_headers.dart';
import 'package:repo_viewer/core/infrastructure/github_headers_cache.dart';
import 'package:repo_viewer/core/infrastructure/network_exceptions.dart';
import 'package:repo_viewer/core/infrastructure/remote_response.dart';
import 'package:repo_viewer/github/repos/core/infrastucture/github_repo_dto.dart';
import 'package:repo_viewer/github/repos/starred_repos/infrastucture/pagination_config.dart';

class StarredReposRemoteService {
  const StarredReposRemoteService(
    this._dio,
    this._headersCache,
  );

  final Dio _dio;
  final GithubHeadersCache _headersCache;

  Future<RemoteResponse<List<GithubRepoDTO>>> getStarredReposPage(
      int page) async {
    final requestUri = Uri.https(
      'api.github.com',
      '/user/starred',
      {
        'page': page,
        'per_page': PaginationConfig.itemsPerPage.toString(),
      },
    );

    final previousHeaders = await _headersCache.getHeaders(requestUri);
    final maxPage = previousHeaders?.link?.maxPage;

    try {
      final response = await _dio.getUri(
        requestUri,
        options: Options(
          headers: {
            'If-non-match': previousHeaders?.eTag ?? '',
          },
        ),
      );

      if (response.statusCode == 200) {
        await _headersCache.saveHeaders(
          requestUri,
          GithubHeaders.parse(response),
        );

        final convertedData = (response.data as Iterable)
            .map((e) => GithubRepoDTO.fromJson(e))
            .toList();

        return RemoteResponse.withNewData(convertedData, maxPage: maxPage ?? 1);
      }

      if (response.statusCode == 304) {
        return RemoteResponse.notModified(maxPage: maxPage ?? 0);
      }

      throw RestApiException(response.statusCode);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return RemoteResponse.noConnection(maxPage: maxPage ?? 0);
      } else if (e.response != null) {
        throw RestApiException(e.response?.statusCode);
      } else {
        rethrow;
      }
    }
  }
}
