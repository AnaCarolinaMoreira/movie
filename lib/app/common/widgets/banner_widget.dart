import 'package:flutter/material.dart';
import 'package:movie/app/common/colors.dart';

import '../../../info_movie_screen.dart';

Widget banner({required String title, required String gender, required image, required BuildContext context, bool isSmall = false}) {
  return InkWell(
    onTap: (() => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InfoMovieScrren()),
          )
        }),
    child: Container(
      height: isSmall ? 318 : 470,
      width: isSmall ? 216 : 318,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          image: AssetImage(
            image,
          ),
          fit: BoxFit.cover,
          alignment: FractionalOffset.bottomCenter,
          colorFilter: isSmall ? null : ColorFilter.mode(Colors.grey.shade900.withAlpha(50), BlendMode.darken),
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
              : LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    gray01,
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
                    title,
                    style: TextStyle(color: white, fontFamily: 'Montserrat', fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      gender,
                      style: TextStyle(color: white, fontFamily: 'Montserrat', fontSize: 10, fontWeight: FontWeight.w400),
                    ),
                  )
                ]),
              ),
      ),
    ),
  );
}
