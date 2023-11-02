import 'package:flutter/material.dart';

class AppbarWithBackButton extends StatefulWidget implements PreferredSizeWidget {
  const AppbarWithBackButton({this.title, super.key})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  final String? title;

  @override
  final Size preferredSize; // default is 56.0

  @override
  State<AppbarWithBackButton> createState() => _AppbarWithBackButton();
}

class _AppbarWithBackButton extends State<AppbarWithBackButton> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(widget.title ?? ''),
    );
  }
}

class Skeleton extends StatelessWidget {
  const Skeleton({required this.appbar, required this.body, Key? key}) : super(key: key);

  final PreferredSizeWidget appbar;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: body,
        ));
  }
}
