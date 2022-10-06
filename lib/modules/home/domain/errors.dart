abstract class MovieFailure implements Exception {
  String? get message;
  String? get code;
  get data;
}

class MovieRequestError implements MovieFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  MovieRequestError({this.message, this.code, this.data});
}

class MovieUnauthorizedError implements MovieFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  MovieUnauthorizedError({this.message, this.code, this.data});
}

class MovieForbiddenError implements MovieFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  MovieForbiddenError({this.message, this.code, this.data});
}

class MovieInternalError implements MovieFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  MovieInternalError({this.message, this.code, this.data});
}

class MovieUnkownError implements MovieFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  MovieUnkownError({this.message, this.code, this.data});
}
