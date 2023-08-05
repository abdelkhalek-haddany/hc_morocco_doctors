import 'package:flutter/material.dart';
import 'package:hc_morocco_doctors/themes/style.dart';


class DropdownButtonApp extends StatefulWidget {
  final List<String> list;
  DropdownButtonApp({super.key,  required this.list});
  @override
  _DropdownButtonAppState createState() => _DropdownButtonAppState();
}
class _DropdownButtonAppState extends State<DropdownButtonApp> {
  @override
  Widget build(BuildContext context) {
    String dropdownValue = widget.list[0];
    return Container(
      height: 60,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
       border: Border.all(width: 1, color: Colors.grey),
    borderRadius:  BorderRadius.circular(5)
    ),
        child:  DropdownButton<String>(
      value: dropdownValue,
      // icon: const Icon(Icons.arrow_downward),
      // elevation: 16,
          underline: Container(
            height: 0,
          ),
      style: const TextStyle(color: Colors.black),

      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: widget.list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ));
  }
}
