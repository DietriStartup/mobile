import 'package:dietri/constants/colors.dart';
import 'package:dietri/helper/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/bottom_sheet.dart';
import 'components/button.dart';
import 'components/input_field.dart';
import 'constants/fonts.dart';
import 'helper/regex.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  static final _formKey = new GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController newPasswordEditingController = TextEditingController();
  TextEditingController confrimPasswordEditingController =
      TextEditingController();
  String? _email;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // print(MediaQuery.of(context).size.height - 606);
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          decoration:const BoxDecoration(
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
                    SizedBox(height: 40.0,),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[ Image.asset('assets/images/dietriLogo.png')])],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: MyBottomSheet(
                      paddingTop: sizer(true, 54.0, context),
                      offset: sizer(true, 250.0, context),
                      color: kWhiteColor,
                      content: [
                        GeneralTextField(
                          hintText: 'Email',
                          key: _formKey,
                          focusNode: focusNode,
                          textController: emailEditingController,
                          keyboardType: TextInputType.emailAddress,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          // hintText: "email",
                          validator: passwordVal,
                          onChanged: (val) => setState(() {
                            _email = val;
                          }),
                        ),
                        SizedBox(
                          height: sizer(false, 35.0, context),
                        ),
                        GeneralTextField(
                          textController: newPasswordEditingController,
                          validator: passwordVal,
                          hintText: 'Password',
                          obscureText: obscurePassword,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r"\s"))
                          ],
                          onChanged: (val) => setState(() {}),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: sizer(true, 24, context),
                              color: kBlack,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sizer(false, 35.0, context),
                        ),
                        GeneralTextField(
                          textController: confrimPasswordEditingController,
                          validator: passwordVal,
                          hintText: 'Confirm Password',
                          obscureText: obscurePassword,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r"\s"))
                          ],
                          onChanged: (val) => setState(() {}),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: sizer(true, 24, context),
                              color: kBlack,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sizer(false, 30.0, context),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      text:
                                          'By Signing up, you are agreeing to\nour ',
                                      style: Fonts.robotoFont(
                                          color: kBlack,
                                          size: sizer(true, 15.0, context),
                                          fontWeight: FontWeight.w400),
                                      children: [
                                    TextSpan(
                                        text: 'Terms and Policy',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          decoration: TextDecoration.underline,
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
                          buttonText: 'Sign Up',
                          buttonFunction: () {
                           // Navigator.of(context).pushNamed('signIn');
                          },
                        ),
                        SizedBox(
                          height: 32.0,
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
                        Container(
                          child: Center(
                            child: Image.asset(
                              'assets/images/ImageGoogle.jpg',
                              scale: 0.5,
                              width: 58.0,
                              height: 58.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sizer(false, 23, context),
                        ),
                        RichText(
                            text: const TextSpan(
                                style: TextStyle(color: kBlack),
                                children: [
                              TextSpan(
                                  text: "Have an account? ",
                                  style: TextStyle(fontSize: 15.0)),
                              TextSpan(
                                  text: 'Sign In',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2,
                                    decorationColor: Colors.black,
                                  ))
                            ]))
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
