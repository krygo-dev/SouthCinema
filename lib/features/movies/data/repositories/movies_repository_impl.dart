import 'package:dartz/dartz.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/core/network/network_info.dart';
import 'package:south_cinema/features/movies/data/datasources/movies_service.dart';
import 'package:south_cinema/features/movies/domain/entities/movie.dart';
import 'package:south_cinema/features/movies/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesService moviesService;
  final NetworkInfo networkInfo;

  MoviesRepositoryImpl({
    required this.moviesService,
    required this.networkInfo,
  });

  @override
  Future<Either<BaseError, List<Movie>>> getCurrentlyPlayedMovies() async {
    if (await networkInfo.isConnected) {
      try {
        final moviesList = await moviesService.getCurrentlyPlayedMovies();
        return Right(moviesList);
      } on BaseError catch (e) {
        return Left(e);
      }
    } else {
      return const Left(NetworkError());
    }
  }

  @override
  Future<Either<BaseError, List<Movie>>> getAnnouncedMovies() async {
    if (await networkInfo.isConnected) {
      try {
        final moviesList = await moviesService.getAnnouncedMovies();
        return Right(moviesList);
      } on BaseError catch (e) {
        return Left(e);
      }
    } else {
      return const Left(NetworkError());
    }
  }

  @override
  Future<Either<BaseError, Movie>> getMovieById({required String id}) async {
    if (await networkInfo.isConnected) {
      try {
        final movie = await moviesService.getMovieById(id: id);
        return Right(movie);
      } on BaseError catch (e) {
        return Left(e);
      }
    } else {
      return const Left(NetworkError());
    }
  }
}
