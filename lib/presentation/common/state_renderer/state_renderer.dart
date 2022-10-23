import 'package:flutter/material.dart';
import 'package:flutter_clean_mvvm/data/mapper/mapper.dart';
import 'package:flutter_clean_mvvm/data/network/failure.dart';
import 'package:flutter_clean_mvvm/presentation/resources/strings_manager.dart';

enum StateRendererType {
  // POPUP STATES
  popupLoadingState,
  popupErrorState,

  // FULL SCREEN STATES
  fullScreenLoadingState,
  fullScreenErrorState,
  contentScreenState, // the ui of the screen
  emptyScreenState, // empty view when no data
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  Failure failure;
  String message;
  String title;
  Function retryAction;

  StateRenderer({
    Key? key,
    required this.stateRendererType,
    Failure? failure,
    String? message,
    String? title,
    required this.retryAction,
  })  : failure = failure ?? DefaultFailure(),
        message = message ?? AppStrings.loading,
        title = title ?? emptyString,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
