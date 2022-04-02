import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ListViewMusic extends StatelessWidget {
  final String newtitile;
  final String newsubtitle;
  final Widget newimage;
  final PopupMenuButton? trailingNew;
  final Function()? ontapNew;
  ListViewMusic(
      {Key? key,
      required this.newtitile,
      required this.newsubtitle,
      required this.newimage,
      this.trailingNew,
      required this.ontapNew})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        newtitile,
        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w400),
      ),
      subtitle: Text(
        newsubtitle,
        style: GoogleFonts.poppins(fontSize: 14),
      ),
      // leading: SizedBox(
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.circular(5),
      //   ),
      // ),
      leading: SizedBox(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.asset(
            '$newimage',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
      ),
      trailing: trailingNew,
      onTap: ontapNew,
    );
  }
}
