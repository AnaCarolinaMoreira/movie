import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie/app/core/api.dart';
import 'package:movie/modules/home/presenter/cubit/movie_cubit.dart';
import 'package:movie/modules/home/presenter/cubit/movie_state.dart';
import 'package:movie/modules/home/presenter/home_screen.dart';
import 'package:movie/modules/home/presenter/info_movie_screen.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        //cubit
        Bind((i) => MovieCubit(MovieInitialState())),

        //config
        Bind((i) => Api()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomeScreen()),
        ChildRoute('/detail', child: (context, args) => const DetailMovieScreen()),
      ];
}
