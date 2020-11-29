import 'package:flutter/material.dart';
import 'package:flutter_auth_flow/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controlles;
  final String text;
  final IconData icon;
  final Function(String) onPress;
  final Function(String) saved;
  final bool security;
  final TextInputType type;
  final IconData iconShow;
  final Function tap;

  const CustomTextField({
    Key key,
    this.controlles,
    this.text,
    this.icon,
    this.onPress,
    this.saved,
    this.security,
    this.type,
    this.iconShow,
    this.tap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        validator: onPress,
        controller: controlles,
        onSaved: saved,
        obscureText: security,
        keyboardType: type,
        decoration: InputDecoration(
            hintText: text,
            suffixIcon: GestureDetector(
              onTap: tap,
              child: Icon(
                iconShow,
                color : kPrimaryColor,
              ),
            ),
            prefixIcon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            filled: true,
            fillColor: kPrimaryLightColor,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                width: 0.8,
                color: Colors.white,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                color: Colors.white,
                width: 0.8,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(width: 0.8),
            )),
      ),
    );
  }
}
