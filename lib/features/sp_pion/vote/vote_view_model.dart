

import 'package:pion_app/features/base_view_model.dart';

class VoteViewModel extends BaseViewModel {

  @override
  Future<void> initModel() async {
    setBusy(true);
    super.initModel();
    setBusy(false);
  }

  @override
  Future<void> disposeModel() async {
    super.disposeModel();
  }
}