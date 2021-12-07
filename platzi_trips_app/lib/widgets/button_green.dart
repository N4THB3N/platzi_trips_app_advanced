import 'package:flutter/material.dart';

class ButtonGreen extends StatefulWidget {
  final String text;
  double width = 0.0;
  double heigth = 0.0;
  final VoidCallback onPressed;

  ButtonGreen(
      {Key key,
      @required this.text,
      @required this.onPressed,
      this.heigth,
      this.width});

  @override
  State<StatefulWidget> createState() {
    return _buttonGreen();
  }
}

class _buttonGreen extends State<ButtonGreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        margin: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
        height: widget.heigth,
        width: widget.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
                colors: [Color(0xFFa7ff84), Color(0xFF1cbb78)],
                begin: FractionalOffset(0.2, 0.0),
                end: FractionalOffset(1.0, 0.6),
                stops: [0.0, 0.6],
                tileMode: TileMode.clamp)),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
                fontSize: 18.0, fontFamily: "Lato", color: Colors.white),
          ),
        ),
      ),
    );
  }
}
