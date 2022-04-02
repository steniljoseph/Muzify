import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/custommusic.dart';
import 'nowplaying.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String search = "";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            'Search',
            style: GoogleFonts.poppins(),
          ),
        ),
        // ignore: sized_box_for_whitespace
        body: Container(
          height: height,
          width: width,
          child: Column(
            children: [
              // const SizedBox(
              //   height: 5,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       'Search',
              //       style: GoogleFonts.poppins(
              //           fontSize: 30, fontWeight: FontWeight.w600),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 5,
              // ),
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // boxShadow: const [
                  //   BoxShadow(color: Color.fromARGB(66, 226, 213, 213))
                  // ],
                ),
                height: MediaQuery.of(context).size.height * .07,
                width: MediaQuery.of(context).size.width * .9,
                child: TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14, right: 10),
                    suffixIcon: Icon(FontAwesomeIcons.search),
                    hintText: ' Search a song',
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  onChanged: (value) {
                    setState(
                      () {
                        search = value;
                      },
                    );
                  },
                ),
              ),
              // Expanded(
              //     child: ListView(
              //   children: [
              //     ListViewMusic(
              //       newtitile: 'Parudeesa',
              //       newsubtitle: 'Sreenath Bhasi, Sushin Shyam',
              //       newimage: Image.asset('assets/images/parudeesa.jpg'),
              //       ontapNew: () {
              //         // Navigator.push(
              //         //   context,
              //         //   MaterialPageRoute(
              //         //     builder: (context) => MusicPlayerScreen(),
              //         //   ),
              //         // );
              //       },
              //     ),
              //   ],
              // ))
            ],
          ),
        ),
      ),
    );
  }
}
