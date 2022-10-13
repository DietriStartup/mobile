import 'package:dietri/components/bottom_sheet.dart';
import 'package:dietri/components/button.dart';
import 'package:dietri/components/input_field.dart';
import 'package:dietri/components/show_exception_dialog.dart';
import 'package:dietri/constants/colors.dart';
import 'package:dietri/helper/routes.dart';
import 'package:dietri/helper/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({
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
  //       builder: (_, model, __) => ResetPasswordPage(
  //         // model: model,
  //       ),
  //     ),
  //   );
  // }

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  static final _formKey = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController newPasswordEditingController = TextEditingController();
  TextEditingController confrimPasswordEditingController =
      TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _cPasswordFocusNode = FocusNode();
  bool hasConfirmedPassword = false;
  bool obscureConfirmPassWord = false;
  bool obscurePassWord = false;
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

  GeneralTextField _buildPasswordTextField() {
    return GeneralTextField(
      textController: newPasswordEditingController,
      //validator: passwordVal,
      hintText: 'Enter New Password',
      textInputAction: TextInputAction.next,
      focusNode: _passwordFocusNode,
      obscureText: obscurePassWord,
      //inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\s"))],
      // onChanged: ,
      // errorText: passwordErrorText,

      suffixIcon: InkWell(
        onTap: () {
          // model.updateObscurePassword(!model.obscurePassWord);
        },
        onFocusChange: (isHover) {
          // Move the focus to the next node explicitly.
          isHover ? FocusScope.of(context).nextFocus() : null;
        },
        child: Icon(
          obscurePassWord
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          size: sizer(true, 24, context),
          color: kBlack,
        ),
      ),
    );
  }

  GeneralTextField _buildConfirmPasswordTextField() {
    return GeneralTextField(
      textController: confrimPasswordEditingController,
      // validator: passwordVal,
      hintText: 'Confirm Password',
      focusNode: _cPasswordFocusNode,
      textInputAction: TextInputAction.next,
      obscureText: obscureConfirmPassWord,
      keyboardType: TextInputType.text,
      // inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\s"))],
      // onChanged: updateConfirmPassword,
      // errorText: model.isSignInPage
      //     ? model.passwordErrorText
      //     : model.passWordDontMatchText,
      suffixIcon: IconButton(
        onPressed: () {
          // model.updateObscureConfirmPassword(!model.obscureConfirmPassWord);
        },
        icon: Icon(
          obscureConfirmPassWord
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          size: sizer(true, 24, context),
          color: kBlack,
        ),
      ),
    );
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
                      offset: hasConfirmedPassword == false
                          ? sizer(true, 280.0, context)
                          : sizer(true, 300, context),
                      color: kWhiteColor,
                      content: [
                        Column(
                          children: [
                            Text(
                              'Password Reset',
                              style: TextStyle(
                                color: kBlack,
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                                fontSize: sizer(true, 20.0, context),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Enter your email address',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: kBlack,
                                fontWeight: FontWeight.w500,
                                height: 1.2,
                                fontSize: sizer(true, 20.0, context),
                              ),
                            ),
                            SizedBox(
                              height: sizer(false, 20.0, context),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: sizer(false, 15.0, context),
                        ),
                        _buildEmailTextField(),
                        SizedBox(
                          height: sizer(false, 15.0, context),
                        ),
                        SizedBox(
                          height: sizer(false, 30, context),
                        ),
                        FullButton(
                          height: sizer(true, 50, context),
                          width: MediaQuery.of(context).size.width,
                          buttonText: 'Password Reset',
                          buttonFunction: () {
                            hasConfirmedPassword == false
                                ? _submit
                                : Navigator.of(context)
                                    .pushNamed(Routes.signInRoute);
                            setState(() {
                              hasConfirmedPassword = true;
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
                            'Quick Sign Up?',
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
                                  text: "Have an account? ",
                                  style: TextStyle(fontSize: 15.0)),
                              TextSpan(
                                  text: 'Sign In',
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
                                      Navigator.of(context)
                                          .pushNamed(Routes.signUpRoute);
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
