import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Type extends StatefulWidget {
  String type, typeDetail;
  Type({super.key, required this.type, required this.typeDetail});

  @override
  State<Type> createState() => _TypeState();
}

class _TypeState extends State<Type> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          child: Text(
            widget.type,
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.normal),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        SizedBox(
          child: Text(
            widget.typeDetail,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
