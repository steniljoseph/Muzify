import 'package:flutter/material.dart';

class CustomPlayList extends StatelessWidget {
  final String? titleNew;
  final IconData leadingNew;
  final PopupMenuButton? trailingNew;
  final Function()? ontapNew;
  const CustomPlayList(
      {Key? key,
      required this.titleNew,
      required this.leadingNew,
      this.trailingNew,
      this.ontapNew})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        titleNew!,
        style: const TextStyle(fontSize: 25, fontFamily: 'Poppins'),
      ),
      leading: Icon(
        leadingNew,
        size: 25,
      ),
      trailing: trailingNew,
      onTap: ontapNew,
    );
  }
}
