import 'package:dio/dio.dart';
import 'package:repo_viewer/core/infrastructure/remote_response.dart';
import 'package:repo_viewer/github/repos/core/infrastucture/github_repo_dto.dart';

class StarredReposRemoteService {
  const StarredReposRemoteService(this._dio);

  final Dio _dio;

  Future<RemoteResponse<List<GithubRepoDTO>>> getStarredReposPage(
      int page) async {
    throw UnimplementedError();
  }
}
