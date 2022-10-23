
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
    return _getStateWidget(context);
  }

  Widget _getStateWidget( BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return _getPopupDialog(context, children: [
          _getAnimatedImage(),
          
        ]);
      case StateRendererType.popupErrorState:
        return _getPopupDialog(context, children: [
          _getAnimatedImage(),
          _getMessage(message),
          _getRetryButton(AppStrings.ok, context),
        ]);
      case StateRendererType.fullScreenLoadingState:
        return _getItemsInColumn(children: [
          _getAnimatedImage(),
          _getMessage(message),
        ]);
      case StateRendererType.fullScreenErrorState:
        return _getItemsInColumn(children: [
          _getAnimatedImage(),
          _getMessage(failure.message),
          _getRetryButton(AppStrings.retryAgain, context),
        ]);
      case StateRendererType.contentScreenState:
        return Container();
      case StateRendererType.emptyScreenState:
        return _getItemsInColumn(children: [
          _getAnimatedImage(),
          _getMessage(message),
        ]);
      default:
        return Container();
    }
  }

  Widget _getPopupDialog(BuildContext context, {required List<Widget> children}) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26,
                blurRadius: AppSize.s12,
                offset: Offset(
                  AppSize.s0,
                  AppSize.s12,
                )),
          ],
        ),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage() {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: , // json image
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding:  const EdgeInsets.all(AppPadding.p18),
        child: Text(message,
            style: getMediumStyle(
              color: ColorManager.black,
              fontSize: FontSize.s16,
            )),
      ),
    );
  }
  
  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
        width: AppSize.s180,
          child: ElevatedButton(
            onPressed: (){
              if(stateRendererType == StateRendererType.fullScreenErrorState){
                retryAction.call(); // call API function again
              } else {
                Navigator.of(context).pop(); // dismiss dialog
              }
            },
            child: Text(buttonTitle),
          ),
        ),
      ),
    );
  }

  Widget _getItemsInColumn({required List<Widget> children}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
