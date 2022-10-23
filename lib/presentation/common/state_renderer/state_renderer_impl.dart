// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_clean_mvvm/data/mapper/mapper.dart';
import 'package:flutter_clean_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_clean_mvvm/presentation/resources/strings_manager.dart';

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
