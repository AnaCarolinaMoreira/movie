import 'package:flutter/material.dart';
import 'package:movie/app/common/colors.dart';

import 'app/common/widgets/banner_widget.dart';

class InfoMovieScrren extends StatefulWidget {
  const InfoMovieScrren({super.key});

  @override
  State<InfoMovieScrren> createState() => _InfoMovieScrrenState();
}

class _InfoMovieScrrenState extends State<InfoMovieScrren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Text("data"),
        backgroundColor: gray08,
        shadowColor: Colors.transparent,
      ),
      extendBody: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.20,
            color: gray08,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  banner(isSmall: true, context: context, title: "marvel", gender: "acao", image: "assets/images/marvel.jpg"),
                  const SizedBox(height: 32),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: '7.3', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24, color: inside)),
                        TextSpan(text: '/ 10', style: TextStyle(color: gray03)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Capitã marvel',
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
                      children: const <TextSpan>[
                        TextSpan(text: 'TÍTULO ORIGINAL: '),
                        TextSpan(text: 'Captain Marvel', style: TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      movieInfoCard(title: "Ano", subtitle: '2019'),
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
                  descriptionCard(
                      title: 'Descricao',
                      subtitle:
                          'Aventura sobre Carol Danvers, uma agente da CIA que tem contato com uma raça alienígena e ganha poderes sobre-humanos. Entre os seus poderes estão uma força fora do comum e a habilidade de voar.'),
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
    return Container(
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
}
