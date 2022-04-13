import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import '../widgets/customlist.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _toggled = false;

  @override
  void initState() {
    super.initState();
    getSwitchValues();
  }

  getSwitchValues() async {
    _toggled = await getSwitchState();
    setState(() {});
  }

  Future<bool> saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("notification", value);
    return prefs.setBool("notification", value);
  }

  Future<bool> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? _toggled = prefs.getBool("notification");

    return _toggled ?? true;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Settings',
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
                    title: const Text(
                      'Notifications',
                      style: TextStyle(fontSize: 25, fontFamily: 'Poppins'),
                    ),
                    secondary: const Icon(
                      FontAwesomeIcons.solidBell,
                    ),
                    value: _toggled,
                    onChanged: (bool value) {
                      setState(() {
                        _toggled = value;
                        saveSwitchState(value);
                        if (_toggled == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'App need to Restart to see the Changes',
                                style: TextStyle(fontFamily: 'Poppins'),
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'App need to Restart to see the Changes',
                                style: TextStyle(fontFamily: 'Poppins'),
                              ),
                            ),
                          );
                        }
                      });
                    },
                  ),
                  CustomListTile(
                    titleNew: 'Share',
                    leadingNew: FontAwesomeIcons.shareAlt,
                    ontapNew: () {
                      Share.share(
                        'Hey Checkout this Cool Offline Music Player.',
                      );
                    },
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
                    ontapNew: () {
                      showAboutDialog(
                        context: context,
                        applicationName: 'Muzify',
                        applicationVersion: '1.0.1',
                        children: [
                          const Text(
                            "Muzify is a Offline Music Player Created by Stenil Joseph.",
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                        ],
                        applicationIcon: SizedBox(
                          height: 47,
                          width: 47,
                          child: Image.asset("assets/images/stop.png"),
                        ),
                      );
                    },
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
