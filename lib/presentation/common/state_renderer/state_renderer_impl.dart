// ignore_for_file: public_member_api_docs, sort_constructors_first

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '/data/mapper/mapper.dart';
import '/presentation/common/state_renderer/state_renderer.dart';
import '/presentation/resources/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

// Loading State (Popup, Full Screen)
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState({
    required this.stateRendererType,
    String? message,
  }) : message = message ?? AppStrings.loading;

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// error state (popup, full screen)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(
    this.stateRendererType,
    this.message,
  );

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// content state
class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => emptyString;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentScreenState;
}

// empty state
class EmptyState extends FlowState {
  String message;

  EmptyState(
    this.message,
  );

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.emptyScreenState;
}

// success state
class SuccessState extends FlowState {
  String message;

  SuccessState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.popupSuccessState;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(
    BuildContext context,
    Widget contentScreenWidget,
    Function retryAction,
  ) {
    switch (runtimeType) {
      case LoadingState:
        if (getStateRendererType() == StateRendererType.popupLoadingState) {
          showPopup(context, getStateRendererType(), getMessage());
          return contentScreenWidget;
        } else {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryAction: retryAction,
          );
        }
      case ErrorState:
        dismissDialog(context);
        if (getStateRendererType() == StateRendererType.popupErrorState) {
          showPopup(context, getStateRendererType(), getMessage());
          return contentScreenWidget;
        } else {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryAction: retryAction,
          );
        }
      case ContentState:
        dismissDialog(context);
        return contentScreenWidget;
      case EmptyState:
        return StateRenderer(
          stateRendererType: getStateRendererType(),
          message: getMessage(),
          retryAction: retryAction,
        );
      case SuccessState:
        dismissDialog(context);
        showPopup(
          context,
          StateRendererType.popupSuccessState,
          getMessage(),
          title: AppStrings.success,
        );
        return contentScreenWidget;
      default:
        return contentScreenWidget;
    }
  }

  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  bool _isCurrentDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent != true;

  showPopup(BuildContext context, StateRendererType stateRendererType, String message, {String title = emptyString}) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
          context: context,
          builder: (BuildContext context) => StateRenderer(
            stateRendererType: stateRendererType,
            message: message,
            title: title,
            retryAction: () {},
          ),
        ));
  }
}
