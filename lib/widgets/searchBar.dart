import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const SearchBar({@required this.controller, @required this.focusNode});
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        child: Row(
          children: <Widget>[
            const Icon(CupertinoIcons.search),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: CupertinoTextField(
                controller: controller,
                focusNode: focusNode,
                cursorColor: Colors.blueAccent,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            GestureDetector(
              onTap: controller.clear,
              child: const Icon(CupertinoIcons.clear_thick_circled),
            )
          ],
        ),
      ),
    );
  }
}
