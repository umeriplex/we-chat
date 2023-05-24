import 'index.dart';


class WelcomeController extends GetxController{
  final state = WelcomeState();
  WelcomeController();

  changePage(int index) async {
    state.index.value = index;
  }

  handleSignIn() async {
    await ConfigStore.to.saveAlreadyOpen();
    Get.toNamed(AppRoutes.SIGN_IN);
  }

}