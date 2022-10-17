import 'package:flutter/material.dart';
import 'package:thamhuai/utility/tool_utility.dart';

class FutureBuilderLoading extends StatefulWidget {
  const FutureBuilderLoading({Key key}) : super(key: key);

  @override
  _FutureBuilderLoadingState createState() => _FutureBuilderLoadingState();
}

class _FutureBuilderLoadingState extends State<FutureBuilderLoading> {
  @override
  void initState() {
    super.initState();
    ToolUtility.loading(true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Center();
  }
}
