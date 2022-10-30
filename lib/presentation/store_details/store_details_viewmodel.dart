// Dart imports:
import 'dart:ffi';

// Package imports:
import 'package:rxdart/rxdart.dart';

// Project imports:
import '../common/state_renderer/state_renderer_impl.dart';
import '/domain/model/model.dart';
import '/domain/usecase/store_details_usecase.dart';
import '/presentation/base/baseviewmodel.dart';
import '/presentation/common/state_renderer/state_renderer.dart';

class StoreDetailsViewModel extends BaseViewModel with StoreDetailsViewModelInput, StoreDetailsViewModelOutput {
  final _storeDetailsStreamController = BehaviorSubject<StoreDetails>();

  final StoreDetailsUseCase storeDetailsUseCase;

  StoreDetailsViewModel(this.storeDetailsUseCase);

  @override
  start() async {
    _loadData();
  }

  _loadData() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    // ignore: void_checks
    (await storeDetailsUseCase.execute(Void)).fold(
      (failure) {
        inputState.add(ErrorState(StateRendererType.fullScreenErrorState, failure.message));
      },
      (storeDetails) async {
        inputState.add(ContentState());
        inputStoreDetails.add(storeDetails);
      },
    );
  }

  @override
  void dispose() {
    _storeDetailsStreamController.close();
  }

  @override
  Sink get inputStoreDetails => _storeDetailsStreamController.sink;

  //output
  @override
  Stream<StoreDetails> get outputStoreDetails => _storeDetailsStreamController.stream.map((stores) => stores);
}

abstract class StoreDetailsViewModelInput {
  Sink get inputStoreDetails;
}

abstract class StoreDetailsViewModelOutput {
  Stream<StoreDetails> get outputStoreDetails;
}
