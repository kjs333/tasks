import 'package:flutter/material.dart';
import 'package:tasks/to_do_entity.dart';

class ToDoDetailPage extends StatefulWidget {
  final ToDoEntity todo;
  ToDoDetailPage(this.todo);
  @override
  State<ToDoDetailPage> createState() => _ToDoDetailPageState();
}

class _ToDoDetailPageState extends State<ToDoDetailPage> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  late bool isFavorite;

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    titleController.text = widget.todo.title;
    if (widget.todo.description != null) {
      descController.text = widget.todo.description!;
    }

    isFavorite = widget.todo.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          //뒤로가기
          leading: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () {
              if (titleController.text.isNotEmpty) {
                ToDoEntity updatedToDo = ToDoEntity(
                  title: titleController.text,
                  description: descController.text,
                  isFavorite: isFavorite,
                  isDone: widget.todo.isDone,
                  createAt: widget.todo.createAt,
                );
                Navigator.of(context).pop(updatedToDo);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.deepPurple,
                    content: Text(
                      "할 일을 입력해주세요.",
                      style: TextStyle(color: Colors.grey[200]),
                    ),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
          actions: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              child:
                  isFavorite
                      ? Icon(
                        Icons.star,
                        size: 24,
                        color: Theme.of(context).cardColor,
                      )
                      : Icon(
                        Icons.star_border,
                        color: Theme.of(context).cardColor,
                      ),
            ),
            SizedBox(width: 18),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //타이틀
              SizedBox(
                width: double.infinity,
                height: 50,
                child: TextField(
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLength: 20,
                  maxLines: 1,
                  controller: titleController,
                  decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    counterText: "", // 글자수 카운트 없애기
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                child: Row(
                  children: [
                    SizedBox(width: 50, child: Icon(Icons.short_text_rounded)),
                    Expanded(child: Text("세부 내용은 다음과 같습니다.")),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    right: 25,
                    left: 25,
                    bottom: 25,
                  ),
                  child: TextField(
                    maxLines: null,
                    controller: descController,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      counterText: "", // 글자수 카운트 없애기
                      hintText: "세부 내용은 여기에 작성합니다.",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(decorationThickness: 0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
