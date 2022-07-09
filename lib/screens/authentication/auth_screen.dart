import 'package:dietri/components/bottom_sheet.dart';
import 'package:dietri/components/button.dart';
import 'package:dietri/components/input_field.dart';
import 'package:dietri/components/show_exception_dialog.dart';
import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/helper/sizer.dart';
import 'package:dietri/services/auth.dart';
import 'package:dietri/services/database.dart';
import 'package:dietri/view_models/sign_in_page_vm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key, required this.model}) : super(key: key);
  final SignInPageViewModel model;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    final db = Provider.of<Database>(context);
    return ChangeNotifierProvider<SignInPageViewModel>(
      create: (_) => SignInPageViewModel(auth: auth, db: db),
      child: Consumer<SignInPageViewModel>(
        builder: (_, model, __) => AuthScreen(
          model: model,
        ),
      ),
    );
  }

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  static final _formKey = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController newPasswordEditingController = TextEditingController();
  TextEditingController confrimPasswordEditingController =
      TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _cPasswordFocusNode = FocusNode();
  SignInPageViewModel get model => widget.model;

  void _submit() async {
    try {
      await model.submit();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(context, title: 'Sign In Failed', exception: e);
    }
  }

  void _signInWithGoogle() async {
    try {
      await model.signInWithGoogle();
      //Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(context, title: 'Sign In Failed', exception: e);
    }
  }

  GeneralTextField _buildPasswordTextField() {
    return GeneralTextField(
      textController: newPasswordEditingController,
      //validator: passwordVal,
      hintText: 'Password',
      textInputAction: TextInputAction.next,
      focusNode: _passwordFocusNode,
      obscureText: model.obscurePassWord,
      //inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\s"))],
      onChanged: model.updatePassword,
      errorText: model.passwordErrorText,

      suffixIcon: InkWell(
        onTap: () {
          model.updateObscurePassword(!model.obscurePassWord);
        },
        onFocusChange: (isHover) {
          // Move the focus to the next node explicitly.
          isHover ? FocusScope.of(context).nextFocus() : null;
        },
        child: Icon(
          model.obscurePassWord
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
      obscureText: model.obscureConfirmPassWord,
      keyboardType: TextInputType.text,
      // inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\s"))],
      onChanged: model.updateConfirmPassword,
      errorText: model.isSignInPage
          ? model.passwordErrorText
          : model.passWordDontMatchText,
      suffixIcon: IconButton(
        onPressed: () {
          model.updateObscureConfirmPassword(!model.obscureConfirmPassWord);
        },
        icon: Icon(
          model.obscureConfirmPassWord
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
      errorText: model.emailErrorText,
      textInputAction: TextInputAction.next,
      onChanged: model.updateEmail,
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
                      offset: sizer(true, 250.0, context),
                      color: kWhiteColor,
                      content: [
                        _buildEmailTextField(),
                        SizedBox(
                          height: sizer(false, 35.0, context),
                        ),
                        _buildPasswordTextField(),
                        SizedBox(
                          height: sizer(false, 30.0, context),
                        ),
                        if (!model.isSignInPage)
                          _buildConfirmPasswordTextField(),
                        if (!model.isSignInPage)
                          SizedBox(
                            height: sizer(false, 30.0, context),
                          ),
                        model.isSignInPage
                            ? const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: kBlack,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 1.5,
                                  decorationColor: kBlack,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                    RichText(
                                        text: TextSpan(
                                            text:
                                                'By Signing up, you are agreeing to\nour ',
                                            style: Fonts.robotoFont(
                                                color: kBlack,
                                                size:
                                                    sizer(true, 15.0, context),
                                                fontWeight: FontWeight.w400),
                                            children: const [
                                          TextSpan(
                                              text: 'Terms and Policy',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationThickness: 1.5,
                                                decorationColor: kBlack,
                                              ))
                                        ])),
                                  ]),
                        SizedBox(
                          height: sizer(false, 30, context),
                        ),
                        FullButton(
                          height: sizer(true, 50, context),
                          width: MediaQuery.of(context).size.width,
                          buttonText:
                              model.isSignInPage ? 'Sign In' : 'Sign Up',
                          buttonFunction: _submit,
                        ),
                        const SizedBox(
                          height: 14.5,
                        ),
                        if (!model.isSignInPage)
                          Center(
                            child: Image.asset(
                              'assets/images/biometric.png',
                              scale: 0.5,
                              width: 58.0,
                              height: 58.0,
                            ),
                          ),
                        if (!model.isSignInPage)
                          const SizedBox(
                            height: 14.5,
                          ),
                        if (!model.isSignInPage)
                          Center(
                            child: Text(
                              'Biometric',
                              style: TextStyle(
                                  color: kBlack,
                                  fontSize: sizer(true, 15.0, context),
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        const SizedBox(
                          height: 13.0,
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1.0,
                        ),
                        const SizedBox(
                          height: 13.0,
                        ),
                        Center(
                          child: Text(
                            model.isSignInPage
                                ? 'Sign In with Social'
                                : 'Quick SignUp',
                            style: TextStyle(
                                color: kBlack,
                                fontSize: sizer(true, 15.0, context)),
                          ),
                        ),
                        SizedBox(
                          height: sizer(false, 15, context),
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
                          height: sizer(false, 15, context),
                        ),
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(color: kBlack),
                                children: [
                              TextSpan(
                                  text: model.isSignInPage
                                      ? "New to Dietri? "
                                      : 'Have an account?',
                                  style: TextStyle(fontSize: 15.0)),
                              TextSpan(
                                  text: model.isSignInPage
                                      ? 'Sign Up'
                                      : 'Sign In',
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2,
                                    decorationColor: Colors.black,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      debugPrint('tap');
                                      model.isSignInPage
                                          ? model.updateIsSignInPage(false)
                                          : model.updateIsSignInPage(true);
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
