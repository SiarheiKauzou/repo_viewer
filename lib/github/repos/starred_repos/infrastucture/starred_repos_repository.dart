import 'package:dartz/dartz.dart';
import 'package:repo_viewer/core/domain/fresh.dart';
import 'package:repo_viewer/core/infrastructure/network_exceptions.dart';
import 'package:repo_viewer/github/repos/core/domain/github_failure.dart';
import 'package:repo_viewer/github/repos/core/domain/github_repo.dart';
import 'package:repo_viewer/github/repos/core/infrastucture/github_repo_dto.dart';
import 'package:repo_viewer/github/repos/starred_repos/infrastucture/starred_repos_remote_service.dart';

class StarredReposRepository {
  const StarredReposRepository(this._remoteService);

  final StarredReposRemoteService _remoteService;

  Future<Either<GithubFailure, Fresh<List<GithubRepo>>>> getStarredReposPage(
      int page) async {
    try {
      final remotePageItems = await _remoteService.getStarredReposPage(page);
      return right(
        remotePageItems.when(
          noConnection: (maxPage) => Fresh.no(
            [],
            isNextPageAvailable: page < maxPage,
          ),
          notModified: (maxPage) => Fresh.no(
            [],
            isNextPageAvailable: page < maxPage,
          ),
          withNewData: (data, maxPage) => Fresh.yes(
            data.toDomain(),
            isNextPageAvailable: page < maxPage,
          ),
        ),
      );
    } on RestApiException catch (e) {
      return left(GithubFailure.api(e.errorCode));
    }
  }
}

extension GithubRepoList on List<GithubRepoDTO> {
  List<GithubRepo> toDomain() => map((e) => e.toDomain()).toList();
}
