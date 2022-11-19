import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie/app/common/colors.dart';
import 'package:movie/app/common/widgets/banner_widget.dart';
import 'package:movie/modules/home/domain/errors.dart';
import 'package:movie/modules/home/infra/models/genres_model.dart';
import 'package:movie/modules/home/infra/models/movie_model.dart';
import 'package:movie/modules/home/presenter/cubit/movie_cubit.dart';
import 'package:movie/modules/home/presenter/cubit/movie_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bool action = false;
  // bool adventure = false;
  // bool fantasy = false;
  // bool comedy = false;

  MovieCubit movieCubit = Modular.get<MovieCubit>();
  List<String> selectedIdGenrer = [];
  List<Genre> genres = [];
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    movieCubit.getGenres();
    movieCubit.getMoviesGenre(selectedIdGenrer.toString().replaceAll('[', '').replaceAll(']', ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            "Filmes",
            textAlign: TextAlign.start,
            style: TextStyle(color: gray01, fontFamily: 'Montserrat', fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      extendBody: true,
      body: BlocConsumer<MovieCubit, MovieState>(
        bloc: movieCubit,
        listener: (context, state) async {
          if (state is MovieErrorState) {
            if (state.failure is MovieUnauthorizedError) {
              // showSessionExpiredAlert(context);
            } else {
              log(state.failure.message.toString());
              // showErrorModal(context, state.failure.message ?? "Ops, ocorreu um erro");
            }
          } else if (state is MovieSuccessState && state.genres != null) {
            setState(() {
              genres = state.genres!.genres ?? [];
              selectedIdGenrer = state.selectedIdGenrer ?? [];
              movieCubit.cleanState();
            });
          } else if (state is MovieSuccessState && state.movies != null) {
            movies = state.movies!.movie ?? [];
            movieCubit.cleanState();
          }
        },
        builder: ((context, state) {
          if (state is MovieLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              search(),
              Container(
                margin: const EdgeInsets.only(bottom: 40),
                padding: const EdgeInsets.only(left: 22),
                height: MediaQuery.of(context).size.height * 0.035,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: genres.length,
                    itemBuilder: (context, index) {
                      return movieGenreCard(
                          genre: genres[index],
                          onTap: () {
                            setState(() {
                              genres[index].value = !genres[index].value;
                              if (genres[index].value == true && genres[index].id > 0) {
                                selectedIdGenrer.add(genres[index].id.toString());
                                movieCubit.getMoviesGenre(selectedIdGenrer.toString().replaceAll('[', '').replaceAll(']', ''));
                              } else {
                                selectedIdGenrer.remove(genres[index].id.toString());
                                movieCubit.getMoviesGenre(selectedIdGenrer.toString().replaceAll('[', '').replaceAll(']', ''));
                              }
                            });
                          });
                    }),
              ),
              movies.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: movies.length,
                          itemBuilder: ((context, index) {
                            log('id: ${movies[index].id}');
                            return banner(movie: movies[index], context: context);
                          })))
                  : const Center(child: Text('Nada por aqui :(')),
            ],
          );
        }),
      ),
    );
  }

  Widget search() {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(20, 0, 16, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: gray08,
        ),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: "Pesquise filmes",
            hintStyle: TextStyle(color: gray02, fontFamily: 'Montserrat', fontSize: 14, fontWeight: FontWeight.w400),
            prefixIcon: SvgPicture.asset(
              "assets/images/search_icon.svg",
              fit: BoxFit.scaleDown,
              color: gray02,
            ),
            border: InputBorder.none,
          ),
        ));
  }

  // Widget listMovieGenre() {
  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 40),
  //     padding: const EdgeInsets.only(left: 22),
  //     height: MediaQuery.of(context).size.height * 0.035,
  //     child: ListView(
  //       shrinkWrap: false,
  //       scrollDirection: Axis.horizontal,
  //       children: [
  //         movieGenreCard(
  //           title: 'Ação',
  //           value: action,
  //           onTap: () {
  //             setState(() {
  //               action = !action;
  //             });
  //           },
  //         ),
  //         movieGenreCard(
  //           title: 'Aventura',
  //           value: adventure,
  //           onTap: () {
  //             setState(() {
  //               adventure = !adventure;
  //             });
  //           },
  //         ),
  //         movieGenreCard(
  //           title: 'Fantasia',
  //           value: fantasy,
  //           onTap: () {
  //             setState(() {
  //               fantasy = !fantasy;
  //             });
  //           },
  //         ),
  //         movieGenreCard(
  //           title: 'Comédia',
  //           value: comedy,
  //           onTap: () {
  //             setState(() {
  //               comedy = !comedy;
  //             });
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget movieGenreCard({required String title, void Function()? onTap, required bool value}) {
  //   return InkWell(
  //     onTap: onTap,
  //     child: Container(
  //       margin: const EdgeInsets.only(right: 12),
  //       padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
  //       decoration: ShapeDecoration(
  //           color: value ? inside : white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25), side: BorderSide(width: 1, color: value ? inside : gray08))),
  //       child: Text(
  //         title,
  //         textAlign: TextAlign.center,
  //         style: TextStyle(color: value ? white : gray02, fontFamily: 'Montserrat', fontSize: 14, fontWeight: FontWeight.w400),
  //       ),
  //     ),
  //   );
  // }

  Widget movieGenreCard({required Genre genre, void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
        decoration: ShapeDecoration(
            color: genre.value ? inside : white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25), side: BorderSide(width: 1, color: genre.value ? inside : gray08))),
        child: Text(
          genre.name ?? "",
          textAlign: TextAlign.center,
          style: TextStyle(color: genre.value ? white : gray02, fontFamily: 'Montserrat', fontSize: 14, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
