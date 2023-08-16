import 'package:fire_base/utils/enums.dart';
import 'package:flutter/material.dart';

import 'loading_widget.dart';

class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget(
      {super.key, required this.loadingState, required this.loadingSuccessWidget, required this.errorWidget, this.loadingWidget});

  final LoadingState loadingState;
  final Widget loadingSuccessWidget;
  final Widget? loadingWidget;
  final Widget errorWidget;

  @override
  Widget build(BuildContext context) {
    return switch (loadingState) {
      LoadingState.loading => loadingWidget ?? const LoadingWidget(),
      LoadingState.error => errorWidget,
      _ => loadingSuccessWidget,
    };
  }
}
