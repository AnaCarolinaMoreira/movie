import 'package:bloc/bloc.dart';
import 'package:movie/modules/home/domain/errors.dart';
import 'package:movie/modules/home/domain/usecase.dart';
import 'package:movie/modules/home/infra/models/genres_model.dart';
import 'package:movie/modules/home/presenter/cubit/movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieUsecase _usecase = MovieUsecase();

  MovieCubit(MovieState initialState) : super(initialState);

  Genres? genres;

  void resetState() {
    emit(MovieInitialState());
  }

  void cleanState() {
    emit(MovieInitialState());
    genres = null;
  }

  void emitSuccess() {
    emit(MovieSuccessState(
      genres: genres,
    ));
  }

  Future<void> getGenres() async {
    try {
      emit(MovieLoadingState());
      final result = await _usecase.getGenres();
      result.fold((l) {
        emit(MovieErrorState(l));
        return;
      }, (r) {
        genres = r;
        emitSuccess();
        return;
      });
    } catch (e) {
      emit(MovieErrorState(MovieUnkownError(message: e.toString())));
    }
  }
}
