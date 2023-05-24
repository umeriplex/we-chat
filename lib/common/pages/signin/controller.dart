import 'index.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'openid'
  ]
);
class SignInController extends GetxController{
  final state = SignInState();
  SignInController();

  final db = FirebaseFirestore.instance;

  Future<void> handleSignIn() async {
    try{
      var user = await _googleSignIn.signIn();
      if(user != null){

        final _gAuth = await user.authentication;
        final credentials = GoogleAuthProvider.credential(
          idToken: _gAuth.idToken,
          accessToken: _gAuth.accessToken
        );

        await FirebaseAuth.instance.signInWithCredential(credentials);

        String displayName = user.displayName ?? user.email;
        String email = user.email;
        String id = user.id;
        String photoUrl = user.photoUrl ?? "";

        UserLoginResponseEntity userProfile = UserLoginResponseEntity();
        userProfile.email = email;
        userProfile.displayName = displayName;
        userProfile.photoUrl = photoUrl;
        userProfile.accessToken = id;
        debugPrint("DONE: ${userProfile.toJson().toString()}");
        UserStore.to.saveProfile(userProfile);

        var userBase = await db.collection("users").withConverter(
            fromFirestore: UserData.fromFirestore,
            toFirestore: (UserData userData, options) => userData.toFirestore()
        ).where("id", isEqualTo: id).get();

        if(userBase.docs.isEmpty){
          final data = UserData(
            id: id,
            name: displayName,
            addtime: Timestamp.now(),
            email: email,
            fcmtoken: "",
            location: "",
            photourl: photoUrl
          );
          await db.collection("users").withConverter(
              fromFirestore: UserData.fromFirestore,
              toFirestore: (UserData userData, options) => userData.toFirestore()
          ).add(data);
        }

        toastInfo(msg: "Login Success!");

        //Get.offAndToNamed(AppRoutes.Application);
      }
    }catch(e){
      toastInfo(msg: "Error: ${e.toString()}");
      debugPrint("Error: ${e.toString()}");
    }
  }

  @override
  void onReady() {
    super.onReady();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if(user == null){
        debugPrint("User not login");
      }else{
        debugPrint("User is login");
      }
    });

  }

}