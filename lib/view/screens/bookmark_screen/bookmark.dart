import 'package:flutter/material.dart';
import 'package:newsapp/controller/bookmark_controller/bookmark_controller.dart';
import 'package:newsapp/global_widgets/constants/color_constants/color.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({super.key});

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Bookmark",
          style: TextStyle(
            color: Color(0xff7C040D),
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
                leading: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(
                              BookmarkController.bookmarkList[index].imageURL),
                          fit: BoxFit.cover)),
                ),
                title: Text(BookmarkController.bookmarkList[index].titlebook));
          },
          separatorBuilder: (context, index) => Divider(
                thickness: 1,
              ),
          itemCount: BookmarkController.bookmarkList.length),
    );
  }
}
