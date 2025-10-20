import 'package:flutter/material.dart';
import 'package:tasks/to_do_entity.dart';

class HomeFloatingBtn extends StatefulWidget {
  final Function(ToDoEntity todo) addToDo;
  HomeFloatingBtn(this.addToDo);
  @override
  State<HomeFloatingBtn> createState() => _HomeFloatingBtnState();
}

class _HomeFloatingBtnState extends State<HomeFloatingBtn> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  bool detailBtnClicked = false; // 상세 추가 버튼 클릭여부
  bool isTitleNotEmpty = false; // 타이틀이 비어있으면 저장X
  bool isFavorite = false;

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.deepPurple,
      shape: CircleBorder(),
      child: Icon(Icons.add, color: Colors.white, size: 24),
      onPressed: () async {
        final newToDo = await showModalBottomSheet<ToDoEntity>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          context: context,
          builder: bottomSheetBuilder,
        );
        if (newToDo != null) {
          widget.addToDo(newToDo);
        }
      },
    );
  }

  ToDoEntity saveToDo() {
    return ToDoEntity(
      title: titleController.text,
      description: descController.text,
      isFavorite: isFavorite,
      createAt: DateTime.now(),
    );
  }

  StatefulBuilder bottomSheetBuilder(BuildContext context) {
    detailBtnClicked = false;
    isTitleNotEmpty = false;
    isFavorite = false;
    titleController.clear();
    descController.clear();
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Padding(
          padding: EdgeInsets.only(
            top: 12,
            right: 20,
            left: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: detailBtnClicked ? 200 : 90,
            color: Theme.of(context).primaryColor,
            child: Column(
              children: [
                Expanded(
                  child: TextField(
                    maxLines: 1,
                    maxLength: 20,
                    textInputAction: TextInputAction.done,
                    autofocus: true,
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "새 할 일",
                      counterText: "", // 글자수 카운트 없애기
                      border: InputBorder.none,
                    ),
                    onChanged: (text) {
                      // 텍스트 필드에 변화있을 때마다 확인하고 isTitleNotEmpty값 바꿔주기
                      if (text.trim().isEmpty) {
                        setState(() {
                          isTitleNotEmpty = false;
                        });
                      } else {
                        setState(() {
                          isTitleNotEmpty = true;
                        });
                      }
                    },
                    onSubmitted: (value) {
                      if (isTitleNotEmpty) {
                        ToDoEntity newToDo = saveToDo();
                        Navigator.of(context).pop(newToDo);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.deepPurple,
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              "할 일을 입력해주세요.",
                              style: TextStyle(color: Colors.grey[200]),
                            ),
                            duration: Duration(seconds: 1),
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
                detailBtnClicked
                    ? Expanded(
                      flex: 2,
                      child: TextField(
                        textInputAction: TextInputAction.newline,
                        maxLines: null,
                        controller: descController,
                        decoration: InputDecoration(
                          hintText: "세부정보 추가",
                          hintStyle: TextStyle(fontSize: 14),
                          border: InputBorder.none,
                        ),
                      ),
                    )
                    : SizedBox(),
                Expanded(
                  child: Row(
                    children: [
                      // 설명 추가 아이콘
                      Expanded(
                        child:
                            detailBtnClicked
                                ? SizedBox()
                                : GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      detailBtnClicked = true;
                                    });
                                  },
                                  child: SizedBox(
                                    height: 40,
                                    child: Icon(
                                      Icons.short_text_rounded,
                                      size: 24,
                                    ),
                                  ),
                                ),
                      ),
                      // 별 아이콘
                      Expanded(
                        child:
                            isFavorite
                                ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isFavorite = !isFavorite;
                                    });
                                  },
                                  child: Icon(Icons.star, size: 24),
                                )
                                : GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isFavorite = !isFavorite;
                                    });
                                  },
                                  child: Icon(Icons.star_border, size: 24),
                                ),
                      ),
                      Spacer(flex: 5),
                      //저장 버튼
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (isTitleNotEmpty) {
                              ToDoEntity newToDo = saveToDo();
                              Navigator.of(context).pop(newToDo);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.deepPurple,
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    "할 일을 입력해주세요.",
                                    style: TextStyle(color: Colors.grey[200]),
                                  ),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text(
                            "저장",
                            textAlign: TextAlign.right,
                            style:
                                isTitleNotEmpty
                                    ? Theme.of(context).textTheme.displayLarge
                                    : Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
