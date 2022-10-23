import 'package:flutter/material.dart';
import 'package:flutter_clean_mvvm/data/mapper/mapper.dart';
import 'package:flutter_clean_mvvm/data/network/failure.dart';
import 'package:flutter_clean_mvvm/presentation/resources/color_manager.dart';
import 'package:flutter_clean_mvvm/presentation/resources/font_manager.dart';
import 'package:flutter_clean_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter_clean_mvvm/presentation/resources/styles_manager.dart';
import 'package:flutter_clean_mvvm/presentation/resources/values_manager.dart';

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
  final StateRendererType stateRendererType;
  final Failure failure;
  final String message;
  final String title;
  final Function retryAction;

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

  Widget? _getStateWidget() {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        // TODO: Handle this case.
        break;
      case StateRendererType.popupErrorState:
        // TODO: Handle this case.
        break;
      case StateRendererType.fullScreenLoadingState:
        return _getItemsInColumn(children: [
          _getAnimatedImage(),
          _getMessage(message),
        ]);
      case StateRendererType.fullScreenErrorState:
        return _getItemsInColumn(children: [
          _getAnimatedImage(),
          _getMessage(failure.message),
          _getRetryButton(AppStrings.retryAgain),
        ]);
      case StateRendererType.contentScreenState:
        // TODO: Handle this case.
        break;
      case StateRendererType.emptyScreenState:
        // TODO: Handle this case.
        break;
      default:
        return Container();
    }
    return null;
  }

  Widget _getAnimatedImage() {
    return  SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: , // json image
    );
  }

  Widget _getMessage(String message) {
    return Text(message,
        style: getMediumStyle(
          color: ColorManager.black,
          fontSize: FontSize.s16,
        ));
  }
  
  Widget _getRetryButton(String buttonTitle)
  {
    return ElevatedButton(
      onPressed: (){},
      child: Text(buttonTitle),
    );
  }

  Widget _getItemsInColumn({required List<Widget> children}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [],
      ),
    );
  }
}
