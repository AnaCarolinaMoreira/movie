import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie/app/common/colors.dart';
import 'package:movie/app/common/widgets/banner_widget.dart';
import 'package:movie/modules/home/domain/errors.dart';
import 'package:movie/modules/home/infra/models/genres_model.dart';
import 'package:movie/modules/home/infra/models/movie_model.dart';
import 'package:movie/modules/home/presenter/cubit/movie_cubit.dart';
import 'package:movie/modules/home/presenter/cubit/movie_state.dart';

class DetailMovieScreen extends StatefulWidget {
  final Movie? movie;
  const DetailMovieScreen({super.key, this.movie});

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  MovieCubit movieCubit = Modular.get<MovieCubit>();
  List<Genre> genres = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: gray08,
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
                  movieCubit.cleanState();
                });
              }
            },
            builder: ((context, state) {
              if (state is MovieLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              return Container(
                color: white,
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.38,
                      color: gray08,
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            SafeArea(child: Align(alignment: Alignment.topLeft, child: bottom())),
                            banner(isSmall: true, context: context, movie: widget.movie!),
                            const SizedBox(height: 32),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(fontFamily: 'Montserrat'),
                                children: <TextSpan>[
                                  TextSpan(text: '7.3', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24, color: inside)),
                                  TextSpan(text: '/ 10', style: TextStyle(color: gray03)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),
                            Text(
                              widget.movie?.title ?? '',
                              style: TextStyle(color: gray01, fontFamily: 'Montserrat', fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 12),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: gray02,
                                  fontFamily: 'Montserrat',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                                children: <TextSpan>[
                                  const TextSpan(text: 'TÍTULO ORIGINAL: '),
                                  TextSpan(text: widget.movie?.originalTitle ?? '', style: const TextStyle(fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                movieInfoCard(title: "Ano", subtitle: widget.movie?.releaseDate ?? ''),
                                movieInfoCard(title: "Duração", subtitle: '1h 20 min'),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                movieGenreCard(title: "Ação"),
                                movieGenreCard(title: "Aventura"),
                                movieGenreCard(title: "Sci-fi"),
                              ],
                            ),
                            const SizedBox(height: 56),
                            descriptionCard(title: 'Descricao', subtitle: widget.movie?.overview ?? ''),
                            const SizedBox(height: 40),
                            movieInfoCard(title: "ORÇAMENTO:", subtitle: '\$ 152,000,000'),
                            movieInfoCard(title: "PRODUTORAS: ", subtitle: 'MARVEL STUDIOS'),
                            const SizedBox(height: 40),
                            descriptionCard(title: 'Diretor', subtitle: "Ryan Fleck, Anna Boden"),
                            const SizedBox(height: 32),
                            descriptionCard(title: 'Elenco', subtitle: "Brie Larson, Samuel L. Jackson, Ben Mendelsohn, Djimon Hounsou, Lee Pace"),
                            const SizedBox(height: 56),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            })));
  }

  Widget movieGenreCard({required String title}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.fromLTRB(10, 6, 10, 7),
      decoration: ShapeDecoration(color: white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5), side: BorderSide(width: 1, color: gray07))),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(color: gray02, fontFamily: 'Montserrat', fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget movieInfoCard({required String title, required String subtitle}) {
    return Container(
      margin: const EdgeInsets.only(right: 12, bottom: 4),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
      decoration: ShapeDecoration(color: gray08, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      child: Row(
        children: [
          Text(
            "$title: ",
            textAlign: TextAlign.center,
            style: TextStyle(color: gray02, fontFamily: 'Montserrat', fontSize: 12, fontWeight: FontWeight.w600),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(color: gray02, fontFamily: 'Montserrat', fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget descriptionCard({required String title, required String subtitle}) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(color: gray02, fontFamily: 'Montserrat', fontSize: 14, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.start,
            style: TextStyle(color: gray01, fontFamily: 'Montserrat', fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget bottom() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
        decoration: ShapeDecoration(
          color: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(width: 1, color: gray08),
          ),
          shadows: [
            BoxShadow(
              color: gray07,
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.arrow_back_ios,
              color: gray01,
              size: 12,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Voltar',
              style: TextStyle(color: gray02, fontFamily: 'Montserrat', fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
