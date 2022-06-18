import 'package:dietri/constants/colors.dart';
import 'package:dietri/helper/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/bottom_sheet.dart';
import 'components/input_field.dart';
import 'constants/fonts.dart';
import 'helper/regex.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
static final _formKey = new GlobalKey<FormState>();
FocusNode focusNode = FocusNode();
TextEditingController emailEditingController = TextEditingController();
TextEditingController newPasswordEditingController = TextEditingController();
  String? _email;
bool obscurePassword = true;


//  bool _showPassword = false;

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Email',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6.0,
                  offset: Offset(2, 2),
                )
              ]),
          height: 60.0,
          child: const TextField(
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Email',
              hintStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.height - 606);
    return SafeArea(
      child: Scaffold(
        backgroundColor: kGreyColor,
        body: Stack(
          // mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
              
            
            const TextField(
              style: TextStyle(color: Colors.yellow),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                hintText: 'Enter your Email',
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const TextField(
              style: TextStyle(color: Colors.yellow),
              obscureText: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const TextField(
              style: TextStyle(color: Colors.yellow),
              obscureText: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                hintText: 'Confirm Password',
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
      
            
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {},
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text('Sign up',
                      style: TextStyle(color: Colors.black)),
                ),
              ),
            ),
            const SizedBox(
              height: 19.0,
            ),
       
            const Text('Quick Sign Up?'),
               Align(
              alignment: Alignment.bottomCenter,
              child: MyBottomSheet(
                paddingTop: sizer(true, 54.0, context),
                offset: sizer(true, 250.0, context), 
                color: kWhiteColor,
              content: [
            
                 GeneralTextField(
                  // suffixIcon:const Icon(Icons.remove_red_eye,
                  // color: Colors.transparent,
                  // ),
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
                      textController: newPasswordEditingController,
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
                  children: [ RichText(
                    text: TextSpan(
                      text: 'By Signing up, you are agreeing to\n our ',
                      style: Fonts.robotoFont(
                                  color: kBlack,
                                  size: sizer(true, 15.0, context),
                                  fontWeight: FontWeight.w400),
                      children: [
                         TextSpan(
                          text:'Terms and Policy',
                           style: TextStyle(
                                       shadows: [
                                        Shadow(
                                          color: Colors.black,
                                          offset: Offset(0, -3)
                                        )
                                       ],
                                       color: Colors.transparent,
                                     
                                        fontSize: 15.0,
                                        decoration: TextDecoration.underline,
                                        decorationThickness: 1.5,
                                        decorationColor: Colors.black,

                                      )
                          )
                      ]
                    )
                  ),
                  ]
                ),



              ]),
            ),
          ],
        ),
      ),
    );
  }
}
