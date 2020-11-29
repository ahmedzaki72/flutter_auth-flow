import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function onPress;
  final Color textColor;

  const CustomButton({
    Key key,
    this.title,
    this.color,
    this.onPress,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
            onPressed: onPress,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            color: color,
            child: Text(
              title,
              style: TextStyle(
                color: textColor,
              ),
            )),
      ),
    );
  }
}
