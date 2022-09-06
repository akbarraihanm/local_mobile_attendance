import 'package:flutter/material.dart';

class RefreshBuilder extends StatelessWidget {

  final Function refresh;
  final Widget? child;
  final ScrollController? controller;

  const RefreshBuilder({
    Key? key,
    required this.refresh,
    this.child,
    this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => refresh.call(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: controller,
        child: child,
      ),
    );
  }
}
