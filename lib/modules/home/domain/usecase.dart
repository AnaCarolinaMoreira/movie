import 'package:dartz/dartz.dart';
import 'package:movie/modules/home/domain/errors.dart';
import 'package:movie/modules/home/infra/models/genres_model.dart';
import 'package:movie/modules/home/infra/models/movie_model.dart';
import 'package:movie/modules/home/infra/repository.dart';

class MovieUsecase implements MovieRepository {
  final MovieRepository _repository = MovieRepository();

  @override
  Future<Either<MovieFailure, Genres>> getGenres() async {
    try {
      final result = await _repository.getGenres();
      return result.fold((l) {
        return left(l);
      }, (r) {
        return right(r);
      });
    } catch (e) {
      return left(MovieUnkownError(message: e.toString()));
    }
  }

  @override
  Future<Either<MovieFailure, Movies>> getMoviesGenre(String id) async {
    try {
      final result = await _repository.getMoviesGenre(id);
      return result.fold((l) {
        return left(l);
      }, (r) {
        return right(r);
      });
    } catch (e) {
      return left(MovieUnkownError(message: e.toString()));
    }
  }

  @override
  Future<Either<MovieFailure, Movie>> getDetailMovie(String id) async {
    try {
      final result = await _repository.getDetailMovie(id);
      return result.fold((l) {
        return left(l);
      }, (r) {
        return right(r);
      });
    } catch (e) {
      return left(MovieUnkownError(message: e.toString()));
    }
  }
}
