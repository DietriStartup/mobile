import 'package:dietri/components/bottom_sheet.dart';
import 'package:dietri/components/button.dart';
import 'package:dietri/components/input_field.dart';
import 'package:dietri/components/show_exception_dialog.dart';
import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/helper/routes.dart';
import 'package:dietri/helper/sizer.dart';
import 'package:dietri/services/auth.dart';
import 'package:dietri/services/database.dart';
import 'package:dietri/view_models/sign_in_page_vm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({
    Key? key,
    // required this.model
  }) : super(key: key);
  // final SignInPageViewModel model;

  // static Widget create(BuildContext context) {
  //   final auth = Provider.of<AuthBase>(context);
  //   final db = Provider.of<Database>(context);
  //   return ChangeNotifierProvider<SignInPageViewModel>(
  //     create: (_) => SignInPageViewModel(auth: auth, db: db),
  //     child: Consumer<SignInPageViewModel>(
  //       builder: (_, model, __) => ForgotPasswordPage(
  //         // model: model,
  //       ),
  //     ),
  //   );
  // }

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  static final _formKey = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController newPasswordEditingController = TextEditingController();
  TextEditingController confrimPasswordEditingController =
      TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _cPasswordFocusNode = FocusNode();
  bool hasConfirmedPassword = true;
  // SignInPageViewModel get model => widget.model;

  void _submit() async {
    try {
      // await model.submit();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(context, title: 'Sign In Failed', exception: e);
    }
  }

  void _signInWithGoogle() async {
    try {
      // await model.signInWithGoogle();
      //Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(context, title: 'Sign In Failed', exception: e);
    }
  }

  GeneralTextField _buildEmailTextField() {
    return GeneralTextField(
      hintText: 'Email',

      focusNode: _emailFocusNode,
      textController: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      //autoValidateMode: AutovalidateMode.onUserInteraction,
      // hintText: "email",
      // errorText: emailErrorText,
      textInputAction: TextInputAction.next,
      // onChanged: model.updateEmail,
      onEditingComplete: () {
        // Move the focus to the next node explicitly.
        FocusScope.of(context).nextFocus();
      },
    );
  }

  //USED ONE WIDGET FOR BOTH SIGN-IN AND SIGN-UP
  @override
  Widget build(BuildContext context) {
    return _signIn(context);
  }

  SafeArea _signIn(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/dietriBack.png',
              ),
              fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Column(
                children: [
                  const SizedBox(
                    height: 40.0,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Image.asset('assets/images/dietriLogo.png')])
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Form(
                  key: _formKey,
                  child: MyBottomSheet(
                      paddingTop: sizer(true, 54.0, context),
                      offset: hasConfirmedPassword  == false
                          ? sizer(true, 280.0, context): sizer(true, 300, context),
                      color: kWhiteColor,
                      content: [
                        Column(
                          children: [
                            Text(
                             hasConfirmedPassword   == false
                                  ? 'Password Hassle?' : 'Reset Confirmation',
                              style: TextStyle(
                                color: kBlack,
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                                fontSize: sizer(true, 20.0, context),
                              ),
                            ),
                            SizedBox(
                              height: sizer(false, 10.0, context),
                            ),
                            Text(
                              hasConfirmedPassword  == false? 
                              'Enter your username or email adress and a link will be sent to your registered email address to help you get back into your account.'
                              : 'Please check your email for a reset link to create a new password.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kDefaultGrey,
                                fontWeight: FontWeight.w400,
                                height: 1.3,
                                fontSize: sizer(true, 15.0, context),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: sizer(false, 23.0, context),
                        ),
                        hasConfirmedPassword  == false  ?
                        _buildEmailTextField()
                        : Image.asset(
                          'assets/images/yellow_tick.png'
                        ),

                        SizedBox(
                          height: sizer(false, 15.0, context),
                        ),

                        // _buildPasswordTextField(),
                        // model.isSignInPage

                           hasConfirmedPassword  == false  ?
                        const Text(
                          'Sign In?',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: kBlack,
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5,
                            decorationColor: kBlack,
                          ),
                        ): Container(height: 0,)
                        ,

                        //     : Row(
                        //         mainAxisAlignment: MainAxisAlignment.start,
                        //         children: [
                        //             RichText(
                        //                 text: TextSpan(
                        //                     text:
                        //                         'By Signing up, you are agreeing to\nour ',
                        //                     style: Fonts.robotoFont(
                        //                         color: kBlack,
                        //                         size:
                        //                             sizer(true, 15.0, context),
                        //                         fontWeight: FontWeight.w400),
                        //                     children: const [
                        //                   TextSpan(
                        //                       text: 'Terms and Policy',
                        //                       style: TextStyle(
                        //                         fontSize: 15.0,
                        //                         decoration:
                        //                             TextDecoration.underline,
                        //                         decorationThickness: 1.5,
                        //                         decorationColor: kBlack,
                        //                       ))
                        //                 ])),
                        //           ]),

                        SizedBox(
                          height: sizer(false, 30, context),
                        ),
                        FullButton(
                          height: sizer(true, 50, context),
                          width: MediaQuery.of(context).size.width,
                          buttonText: hasConfirmedPassword == false ? 'Recover Password': 'Sign In',
                          buttonFunction: (){
                             Navigator.of(context).pushNamed(Routes.resetPasswordPageRoute);
                          //  hasConfirmedPassword  == false
                                // ?  _submit : 
                                // (){
                                // Navigator.of(context).pushNamed(Routes.resetPasswordPageRoute);
                                // };
                            setState(() {
                              hasConfirmedPassword= true;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 14.5,
                        ),

                        const SizedBox(
                          height: 13.0,
                        ),
                        Center(
                          child: Text(
                            'Sign In with Social',
                            style: TextStyle(
                                color: kBlack,
                                fontSize: sizer(true, 15.0, context)),
                          ),
                        ),
                        SizedBox(
                          height: sizer(false, 22, context),
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: _signInWithGoogle,
                            child: Image.asset(
                              'assets/images/ImageGoogle.jpg',
                              scale: 0.5,
                              width: sizer(true, 58, context),
                              height: sizer(false, 58, context),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sizer(false, 23, context),
                        ),
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(color: kBlack),
                                children: [
                              const TextSpan(
                                  text: "New to Dietri? ",
                                  style: TextStyle(fontSize: 15.0)),
                              TextSpan(
                                  text: 'Sign Up',
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2,
                                    decorationColor: Colors.black,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      debugPrint('tap');
                                      // updateIsSignInPage(false);
                                      Navigator.of(context).pushNamed(Routes.signUpRoute);
                                      emailEditingController.clear();
                                      newPasswordEditingController.clear();
                                      confrimPasswordEditingController.clear();
                                    })
                            ]))
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
