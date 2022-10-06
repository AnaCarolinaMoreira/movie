import 'package:dartz/dartz.dart';
import 'package:movie/modules/home/domain/errors.dart';
import 'package:movie/modules/home/external/datasource.dart';
import 'package:movie/modules/home/infra/models/genres_model.dart';

class MovieRepository implements MovieDatasource {
  final MovieDatasource _datasource = MovieDatasource();

  @override
  Future<Either<MovieFailure, Genres>> getGenres() async {
    try {
      final result = await _datasource.getGenres();
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
