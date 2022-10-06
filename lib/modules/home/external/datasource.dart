import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie/app/core/api.dart';
import 'package:movie/app/common/constants.dart';
import 'package:movie/app/common/routes.dart';
import 'package:movie/modules/home/domain/errors.dart';
import 'package:movie/modules/home/infra/models/genres_model.dart';

MovieFailure getFailureError(Response? response) {
  if (response == null) return MovieUnkownError();
  switch (response.statusCode) {
    case 400:
      return MovieRequestError(message: response.statusMessage, data: response.data);
    case 401:
      return MovieUnauthorizedError(message: response.statusMessage, data: response.data);
    case 403:
      return MovieForbiddenError(message: response.statusMessage, data: response.data);
    case 404:
      return MovieRequestError(message: response.statusMessage, data: response.data);
    case 500:
      return MovieInternalError(message: response.statusMessage, data: response.data);
    default:
      return MovieUnkownError(message: response.statusMessage, code: response.statusCode.toString(), data: response.data);
  }
}

class MovieDatasource {
  final Api _api = Modular.get<Api>();

  Future<Either<MovieFailure, Genres>> getGenres() async {
    try {
      Response? response = await _api.getApi(api, ApiRoutes.genres);

      if (response == null || response.statusCode != 200 || response.data == null) {
        MovieFailure failure = getFailureError(response);
        return left(failure);
      } else {
        final genresMap = List<Map<String, dynamic>>.from(response.data["genres"]);
        return right(Genres.fromMap(genresMap));
      }
    } catch (e) {
      return left(MovieUnkownError(message: e.toString()));
    }
  }
}
