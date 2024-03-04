import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
    const CustomButton({required this.tap,required this.colour,required this.text,required this.textColor});

    final VoidCallback tap;
    final Color colour;
    final String text;
    final Color textColor;

    @override
    State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
    @override
    Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        child: ElevatedButton(
        onPressed: widget.tap,
        style: ElevatedButton.styleFrom(
            backgroundColor: widget.colour,
            foregroundColor: widget.textColor,
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0), // Adjust the radius as needed
            ),
        ),
        child: Center(
            child: Text(
                widget.text,
                style: TextStyle(
                    fontSize:21,
                    fontWeight: FontWeight.w500
                ),
            )
        ),
        ),
    );

    }
}