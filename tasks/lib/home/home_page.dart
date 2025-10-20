import 'package:flutter/material.dart';
import 'package:tasks/detail/to_do_detail_page.dart';
import 'package:tasks/home/sort_btn.dart';
import 'package:tasks/to_do_entity.dart';
import 'package:tasks/home/home_floating_btn.dart';
import 'package:tasks/home/no_to_do.dart';
import 'package:tasks/home/to_do_view.dart';

class HomePage extends StatefulWidget {
  // AppBar의 타이틀 가져와서 빈 화면일 때 쓰기
  final String titleName;
  HomePage(this.titleName);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ToDoEntity> toDoList = [];

  final titleController = TextEditingController();
  final descController = TextEditingController();
  bool detailBtnClicked = false;
  bool isTitleEmpty = true;
  bool isFavorite = false;
  bool sortWithDate = true;
  bool sortWithDone = true;

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // 3-1번
      appBar: AppBar(
        title: Text(
          widget.titleName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      // 투두리스트 비어있으면 그림과 설명, 아니면 할 일 목록 위젯 넣기
      body: Column(
        children: [
          SizedBox(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: SortBtn(sortWithDate, "저장순", sortWithDateOnTap),
                ),
                Expanded(
                  child: SortBtn(!sortWithDate, "중요순", sortWithDateOnTap),
                ),
                Expanded(
                  child: SortBtn(sortWithDone, "완료 포함", sortWithDoneOnTap),
                ),
              ],
            ),
          ),
          toDoList.isEmpty
              ? NoToDo(widget.titleName)
              : Expanded(child: toDoWidgetList(context)),
        ],
      ),
      // 투두 추가 버튼
      floatingActionButton: HomeFloatingBtn(addToDo),
    );
  }

  // 투두리스트 정렬
  void toDoListSort() {
    if (sortWithDate) {
      toDoList.sort((a, b) => a.createAt.compareTo(b.createAt));
    } else {
      toDoList.sort((a, b) {
        if (a.isFavorite || b.isFavorite) {
          return a.isFavorite ? -1 : 1;
        } else {
          return a.createAt.compareTo(b.createAt);
        }
      });
    }
  }

  //저장순
  void sortWithDateOnTap() {
    setState(() {
      sortWithDate = !sortWithDate;
      toDoListSort();
    });
  }

  //완료 포함
  void sortWithDoneOnTap() {
    setState(() {
      sortWithDone = !sortWithDone;
    });
  }

  // 저장버튼이나 엔터 눌렀을 때 투두 저장하고 홈페이지 리빌드
  void addToDo(ToDoEntity newToDo) {
    setState(() {
      toDoList.add(
        ToDoEntity(
          title: newToDo.title,
          description: newToDo.description,
          isDone: newToDo.isDone,
          isFavorite: newToDo.isFavorite,
          createAt: newToDo.createAt,
        ),
      );
      toDoListSort();
    });
  }

  // 별아이콘 눌렀을 때 실행될 함수
  void _onToggleFavorite(ToDoEntity todo, int index) {
    setState(() {
      ToDoEntity temp = ToDoEntity(
        title: todo.title,
        description: todo.description,
        isDone: todo.isDone,
        isFavorite: !todo.isFavorite,
        createAt: todo.createAt,
      );
      toDoList.remove(todo);
      toDoList.add(temp);
      toDoListSort();
    });
  }

  // 동그라미 눌렀을 때 실행될 함수
  void _onToggleDone(ToDoEntity todo, int index) {
    setState(() {
      ToDoEntity temp = ToDoEntity(
        title: todo.title,
        description: todo.description,
        isDone: !todo.isDone,
        isFavorite: todo.isFavorite,
        createAt: todo.createAt,
      );
      toDoList.remove(todo);
      toDoList.add(temp);
      toDoListSort();
    });
  }

  // 투두 할일 부분 눌렀을 때 상세페이지로 이동하기
  void _titleTap(BuildContext context, ToDoEntity todo, int index) async {
    final result = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => ToDoDetailPage(todo)));

    setState(() {
      toDoList.remove(todo);
      toDoList.add(result);
      toDoListSort();
    });
  }

  //저장된 투두리스트를 가지고 ToDoView위젯리스트 만들기
  Widget toDoWidgetList(BuildContext context) {
    //완료한 일 포함?
    List<ToDoEntity> temp = toDoList;
    if (!sortWithDone) {
      temp = toDoList.where((todo) => !todo.isDone).toList();
    }

    return ListView.builder(
      padding: EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 100),
      itemCount: temp.length,
      itemBuilder: (context, index) {
        ToDoEntity todo = temp[index];
        return GestureDetector(
          // 길게 누르면 삭제 팝업
          onLongPress: () async {
            final result = await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("삭제 하시겠습니까?", textAlign: TextAlign.center),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text("취소"),
                    ),
                    TextButton(
                      style: ButtonStyle(iconAlignment: IconAlignment.end),
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text("삭제", style: TextStyle(color: Colors.red)),
                    ),
                  ],
                );
              },
            );
            if (result) {
              setState(() {
                toDoList.remove(todo);
              });
            }
          },
          child: ToDoView(
            toDo: todo,
            onToggleFavorite: () => _onToggleFavorite(todo, index),
            onToggleDone: () => _onToggleDone(todo, index),
            onTapTitle: () => _titleTap(context, todo, index),
          ),
        );
      },
    );
  }
}
