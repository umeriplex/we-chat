import 'index.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget _buildLogo(){
      return Container(
        width: 110.w,
        margin: EdgeInsets.only(top: 85.h),
        child: Column(
          children: [
            Container(
              width: 75.w,
              height: 75.w,
              child: Stack(
                children: [
                    Positioned(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15.w),
                        width: 75.w,
                        height: 75.w,
                        decoration: BoxDecoration(
                            color: AppColors.primaryBackground,
                            borderRadius: BorderRadius.all(Radius.circular(37.5.w)),
                            boxShadow: const [
                              Shadows.primaryShadow,
                            ]
                        ),
                      )
                  ),
                  Positioned(
                      child: Image.asset(ImageAddress.icLauncher, width: 75.w, height: 75.w,fit: BoxFit.cover,)
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.h),
              child: Text(
                'Let\'s Chat',
                style: TextStyle(
                  color: AppColors.thirdElement,
                  fontFamily: FontAddress.avenir,
                  height: 1,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }
    Widget _buildThirdPartyLogin(){
      return Container(
        width: 300.w,
        margin: EdgeInsets.only(bottom: 270.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sign in with social networks",style: TextStyle(
              color: AppColors.thirdElement,
              fontFamily: FontAddress.iconFont,
              height: 1,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),),
            SizedBox(height: 20.h,),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.secondaryElementText),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
                onPressed: (){
                  controller.handleSignIn();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                  child: Text("Google Login",style: TextStyle(
                    color: AppColors.primaryBackground,
                    fontFamily: FontAddress.iconFont,
                    height: 1,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),),
                ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
        body: Center(
          child: Column(
            children: [
              _buildLogo(),
              const Spacer(),
              _buildThirdPartyLogin(),
            ],
          ),
        )
    );
  }
}
