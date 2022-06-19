import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  const Buttons(this.color, this.textcolor, this.buttonText, this.buttonTapped,
      {Key? key})
      : super(key: key);

  final color;
  final textcolor;
  final String buttonText;
  final buttonTapped;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: buttonTapped,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: color,
                child: Center(
                  child: Text(
                    buttonText,
                    style: TextStyle(color: textcolor, fontSize: 20),
                  ),
                ),
              )),
        ),
      );
}
