import 'package:flutter/material.dart';

class SortBtn extends StatelessWidget {
  final bool btnOn;
  final String text;
  final VoidCallback onTap;
  SortBtn(this.btnOn, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.2,
            color: btnOn ? Theme.of(context).cardColor : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(text, textAlign: TextAlign.center),
      ),
    );
  }
}
