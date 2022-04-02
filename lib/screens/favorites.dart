import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/customfavourites.dart';
import '../widgets/custommusic.dart';
import 'nowplaying.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favourites',
          style: GoogleFonts.poppins(
            fontSize: 30,
          ),
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        // ignore: sized_box_for_whitespace
        child: Container(
          height: height,
          width: width,
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              // Container(
              //   alignment: Alignment.topLeft,
              //   margin: const EdgeInsets.only(
              //     left: 10,
              //   ),
              //   child: Row(
              //     children: [
              //       IconButton(
              //         onPressed: () {
              //           Navigator.pop(context);
              //         },
              //         icon: const Icon(FontAwesomeIcons.arrowLeft),
              //       ),
              //       Text(
              //         '  Favourites',
              //         style: GoogleFonts.poppins(
              //             fontSize: 30, fontWeight: FontWeight.w600),
              //       )
              //     ],
              //   ),
              // ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: ListView(
                  children: [
                    CustomFavList(
                      newtitile: 'Parudeesa',
                      newsubtitle: 'Sreenath Bhasi, Sushin Shyam',
                      newimage: 'assets/images/parudeesa.jpg',
                      ontapNew: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => MusicPlayerScreen(),
                        //   ),
                        // );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
