import 'package:dio/dio.dart';
import 'package:repo_viewer/core/infrastructure/github_headers.dart';
import 'package:repo_viewer/core/infrastructure/github_headers_cache.dart';
import 'package:repo_viewer/core/infrastructure/network_exceptions.dart';
import 'package:repo_viewer/core/infrastructure/remote_response.dart';
import 'package:repo_viewer/github/repos/core/infrastucture/github_repo_dto.dart';

class StarredReposRemoteService {
  const StarredReposRemoteService(
    this._dio,
    this._headersCache,
  );

  final Dio _dio;
  final GithubHeadersCache _headersCache;

  Future<RemoteResponse<List<GithubRepoDTO>>> getStarredReposPage(
      int page) async {
    const token = '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';
    const accept = 'application/vnd.github.v3.html+json';
    final requestUri = Uri.https(
      'api.github.com',
      '/user/starred',
      {'page': page},
    );

    final previousHeaders = await _headersCache.getHeaders(requestUri);
    final maxPage = previousHeaders?.link?.maxPage ?? 0;

    try {
      final response = await _dio.getUri(
        requestUri,
        options: Options(
          headers: {
            'Authorization': 'bearer $token',
            'Accept': accept,
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

        return RemoteResponse.withNewData(convertedData, maxPage: maxPage);
      }

      if (response.statusCode == 304) {
        return RemoteResponse.notModified(maxPage: maxPage);
      }

      throw RestApiExcepton(response.statusCode);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return RemoteResponse.noConnection(maxPage: maxPage);
      } else if (e.response != null) {
        throw RestApiExcepton(e.response?.statusCode);
      } else {
        rethrow;
      }
    }
  }
}
