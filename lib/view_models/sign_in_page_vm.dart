import 'package:dietri/helper/validators.dart';
import 'package:dietri/services/auth.dart';
import 'package:dietri/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SignInPageViewModel with EmailAndPasswordValidators, ChangeNotifier {
  SignInPageViewModel(
      {required this.auth,
      required this.db,
      this.email = '',
      this.password = '',
      this.isLoading = false,
      this.obscurePassWord = true,
      this.confirmPassword = '',
      this.isSignInPage = true,
      this.obscureConfirmPassWord = true,
      this.submitted = false});
  final AuthBase auth;
  final Database db;
  String email;
  String password;
  String confirmPassword;
  bool isLoading;
  bool submitted;
  bool? isEmailVerifyLinkSent;
  bool obscurePassWord;
  bool obscureConfirmPassWord;
  bool isSignInPage;

  void updateWith(
      {String? email,
      String? password,
      String? confirmPassword,
      bool? isLoading,
      bool? isEmailVerifyLinkSent,
      bool? submitted,
      bool? obscurePassWord,
      bool? obscureConfirmPassWord,
      bool? isSignInPage}) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    this.isEmailVerifyLinkSent =
        isEmailVerifyLinkSent ?? this.isEmailVerifyLinkSent;
    this.obscurePassWord = obscurePassWord ?? this.obscurePassWord;
    this.obscureConfirmPassWord =
        obscureConfirmPassWord ?? this.obscureConfirmPassWord;
    this.confirmPassword = confirmPassword ?? this.confirmPassword;
    this.isSignInPage = isSignInPage ?? this.isSignInPage;
    notifyListeners();
  }

  void updateEmail(String? email) => updateWith(email: email);

  void updatePassword(String? password) => updateWith(password: password);

  void updateConfirmPassword(String? confirmPassword) =>
      updateWith(confirmPassword: confirmPassword);

  void updateObscurePassword(bool obscurePassword) =>
      updateWith(obscurePassWord: obscurePassword);

  void updateObscureConfirmPassword(bool obscureConfirmPassword) =>
      updateWith(obscureConfirmPassWord: obscureConfirmPassword);

  void updateIsSignInPage(bool isSigninPage) => updateWith(
        email: '',
        password: '',
        isLoading: false,
        submitted: false,
        isSignInPage: isSigninPage,
        obscurePassWord: true,
      );

  bool get canSubmit {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  Future<void> submit() async {
    updateWith(isLoading: true, submitted: true);
    try {
      if (isSignInPage) {
        await auth
            .signInWithEmailandPassword(email.trim(), password.trim())
            .then((user) {
              user!.reload();
          if (!user.emailVerified) {
            throw FirebaseAuthException(
                code: 'email_not_verified', message: 'Email not verified');
          }
          
        });
      } else {
        await auth
            .createUserWithEmailandPassword(email.trim(), password.trim())
            .then((user) async {
              if (user != null) {   
            await user.sendEmailVerification();
             await user.reload();
              db.createUserinDatabase(user);
              }
             
        });
      }
      //await auth.signInWithEmailandPassword(email, password);
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  Future<void> signInWithGoogle() async {
    updateWith(isLoading: true);
    try {
      await auth.signInWithGoogle().then((userCredential) {
        if (userCredential!.additionalUserInfo!.isNewUser) {
          
          db.createUserinDatabase(userCredential.user!);
        }
      });
      //db.createUserinDatabase(user!.user!);

    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  String? get emailErrorText {
    bool showErrorText = submitted && !emailValidator.isValid(email);
    return showErrorText ? invalidEmailText : null;
  }

  String? get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(password);
    return showErrorText ? invalidPasswordText : null;
  }

  String? get passWordDontMatchText {
    bool showErrorText = password.compareTo(confirmPassword) == 0;
    return showErrorText ? null : invalidPasswordMatch;
  }
}
