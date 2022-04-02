import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/database/dbsongs.dart';

class CreatePlaylist extends StatefulWidget {
  CreatePlaylist({Key? key}) : super(key: key);

  @override
  State<CreatePlaylist> createState() => _CreatePlaylistState();
}

class _CreatePlaylistState extends State<CreatePlaylist> {
  List<LocalSongs> playlists = [];

  final _box = MusicBox.getInstance();

  String? _title;

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: Border.all(
        width: 4,
        color: Colors.white,
      ),
      backgroundColor: Colors.black,
      child: SizedBox(
        height: 200,
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 20,
                left: 20,
                top: 20,
              ),
              child: Text(
                "Add a name to playlist.",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 10,
              ),
              child: Form(
                key: formkey,
                child: TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  cursorHeight: 25,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: GoogleFonts.poppins(fontSize: 22, color: Colors.white),
                  onChanged: (value) {
                    _title = value;
                  },
                  validator: (value) {
                    List keys = _box.keys.toList();
                    if (value == "") {
                      return "Name required";
                    }
                    if (keys.where((element) => element == value).isNotEmpty) {
                      return "This name already exits";
                    }
                    return null;
                  },
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15,
                      top: 5,
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.rubik(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15,
                      top: 5,
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          _box.put(_title, playlists);
                          Navigator.pop(context);
                          setState(() {});
                        }
                      },
                      child: Center(
                        child: Text(
                          "Create",
                          style: GoogleFonts.rubik(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
