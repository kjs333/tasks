import 'package:flutter/material.dart';

class NoToDo extends StatelessWidget {
  final String titleName;

  NoToDo(this.titleName);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          color: Theme.of(context).dividerColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          spacing: 12.0,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                width: 100,
                height: 100,
                alignment: Alignment.center,
                child: Image.asset("assets/myTodoIcon.webp"),
              ),
            ),
            Text(
              "아직 할 일이 없음",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 210,
              child: Text(
                "할 일을 추가하고 $titleName에서 할 일을 추적하세요.",
                style: TextStyle(fontSize: 14, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
