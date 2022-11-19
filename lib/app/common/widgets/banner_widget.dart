import 'package:flutter/material.dart';
import 'package:movie/app/common/colors.dart';
import 'package:movie/modules/home/infra/models/movie_model.dart';
import 'package:movie/modules/home/presenter/info_movie_screen.dart';

Widget banner({required Movie movie, required BuildContext context, bool isSmall = false}) {
  return InkWell(
    onTap: (() => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailMovieScreen(movie: movie)),
          )
        }),
    child: Container(
      height: isSmall ? 318 : 470,
      width: isSmall ? 216 : 318,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          image: NetworkImage('https://image.tmdb.org/t/p/original/${movie.posterPath}'),
          fit: BoxFit.cover,
          alignment: FractionalOffset.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.only(
        bottom: 16,
        left: 20,
        right: 20,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: isSmall
              ? null
              : const LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black87,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
        ),
        child: isSmall
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(left: 24, bottom: 32),
                child: Column(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    movie.title ?? '',
                    style: TextStyle(color: white, fontFamily: 'Montserrat', fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      movie.genres?.genres?.first.name ?? '',
                      style: TextStyle(color: white, fontFamily: 'Montserrat', fontSize: 10, fontWeight: FontWeight.w400),
                    ),
                  )
                ]),
              ),
      ),
    ),
  );
}
