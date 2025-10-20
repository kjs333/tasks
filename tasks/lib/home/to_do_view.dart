import 'package:flutter/material.dart';
import 'package:tasks/to_do_entity.dart';

class ToDoView extends StatelessWidget {
  const ToDoView({
    super.key,
    required this.toDo,
    required this.onToggleFavorite,
    required this.onToggleDone,
    required this.onTapTitle,
  });

  final ToDoEntity toDo;
  final VoidCallback onToggleFavorite;
  final VoidCallback onToggleDone;
  final VoidCallback onTapTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: onToggleDone,
              child: SizedBox(
                width: 50,
                child:
                    toDo.isDone
                        ? Icon(Icons.check_circle)
                        : Icon(Icons.circle_outlined),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: GestureDetector(
              onTap: onTapTitle,
              child: Text(
                toDo.title,
                style:
                    toDo.isDone
                        ? TextStyle(decoration: TextDecoration.lineThrough)
                        : null,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: onToggleFavorite,
              child: SizedBox(
                width: 50,
                child:
                    toDo.isFavorite
                        ? Icon(Icons.star)
                        : Icon(Icons.star_border),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
