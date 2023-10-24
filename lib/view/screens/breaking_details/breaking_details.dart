import 'package:flutter/material.dart';
import 'package:newsapp/utils/color_constants/color.dart';

class BreakingNews extends StatefulWidget {
  const BreakingNews({super.key});

  @override
  State<BreakingNews> createState() => _BreakingNewsState();
}

class _BreakingNewsState extends State<BreakingNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Breaking News"),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
