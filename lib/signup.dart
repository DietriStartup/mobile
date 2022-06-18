import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
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
              const Text('By Signing up, you are agreeing to'),
              const Text('our Terms and Policy'),
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
            ],
          ),
        ),
      ),
    );
  }
}
