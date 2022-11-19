import 'package:equatable/equatable.dart';
import 'package:movie/modules/home/domain/errors.dart';
import 'package:movie/modules/home/infra/models/genres_model.dart';
import 'package:movie/modules/home/infra/models/movie_model.dart';

abstract class MovieState extends Equatable {}

class MovieInitialState extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieLoadingState extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieSuccessState extends MovieState {
  final Genres? genres;
  final Movies? movies;
  final List<String>? selectedIdGenrer;

  MovieSuccessState({
    required this.genres,
    required this.movies,
    required this.selectedIdGenrer,
  });
  @override
  List<Object> get props => [];
}

class MovieErrorState extends MovieState {
  final MovieFailure failure;
  MovieErrorState(this.failure);

  @override
  List<Object> get props => [failure];
}
