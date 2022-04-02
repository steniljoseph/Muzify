import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListTile extends StatelessWidget {
  final String? titleNew;
  final IconData leadingNew;
  // final PopupMenuButton? trailingNew;
  final Function()? ontapNew;
  const CustomListTile(
      {Key? key,
      required this.titleNew,
      required this.leadingNew,
      // this.trailingNew,
      this.ontapNew})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        titleNew!,
        style: GoogleFonts.poppins(fontSize: 25),
      ),
      leading: Icon(
        leadingNew,
        // size: 25,
        // color: Colors.black,
      ),
      // trailing: trailingNew,
      onTap: ontapNew,
    );
  }
}
