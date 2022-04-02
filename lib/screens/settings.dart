import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/customlist.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _toggled = false;
  String test = 'ghhgjg';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Settings',
            style: GoogleFonts.poppins(),
          ),
        ),
        // ignore: sized_box_for_whitespace
        body: Container(
          height: height,
          width: width,
          child: Column(
            children: [
              Column(
                children: [
                  SwitchListTile(
                    title: Text(
                      'Notifications',
                      style: GoogleFonts.poppins(fontSize: 25),
                    ),
                    secondary: const Icon(
                      FontAwesomeIcons.solidBell,
                      // size: 30,
                      // color: Colors.black,
                    ),
                    value: _toggled,
                    onChanged: (bool value) {
                      setState(() {
                        _toggled = value;
                      });
                    },
                  ),
                  CustomListTile(
                    titleNew: 'Share',
                    leadingNew: FontAwesomeIcons.shareAlt,
                    ontapNew: () {},
                  ),
                  CustomListTile(
                    titleNew: 'Privacy Policies',
                    leadingNew: FontAwesomeIcons.lock,
                    ontapNew: () {},
                  ),
                  CustomListTile(
                    titleNew: 'Terms & Conditions',
                    leadingNew: FontAwesomeIcons.book,
                    ontapNew: () {},
                  ),
                  CustomListTile(
                    titleNew: 'About',
                    leadingNew: FontAwesomeIcons.infoCircle,
                    ontapNew: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
