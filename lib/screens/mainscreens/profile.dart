import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietri/components/show_alert_dialog.dart';
import 'package:dietri/components/show_exception_dialog.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/helper/sizer.dart';
import 'package:dietri/models/user.dart';
import 'package:dietri/screens/kyc/fourth_kyc_screen.dart';
import 'package:dietri/screens/kyc/second_kyc_screen.dart';
import 'package:dietri/screens/kyc/third_kyc_screen.dart';
import 'package:dietri/services/auth.dart';
import 'package:dietri/services/database.dart';
import 'package:dietri/view_models/profile_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.userModel, required this.model})
      : super(key: key);
  final UserModel userModel;
  final ProfileViewModel model;

  static Widget create(BuildContext context, UserModel userModel) {
    final db = Provider.of<Database>(context);
    final auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<ProfileViewModel>(
        create: (_) => ProfileViewModel(db: db, auth: auth),
        builder: (context, child) {
          return Consumer<ProfileViewModel>(builder: (__, model, _) {
            return ProfilePage(
              userModel: userModel,
              model: model,
            );
          });
        });
  }

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _signOut() async {
    try {
      await widget.model.signOut();
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(context,
          title: 'Couldn\'t sign out', exception: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
          ),
          Container(
            height: height * 0.5,
            width: width,
            decoration: const BoxDecoration(
                color: kPrimaryAccentColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
          ),
          _userPhotoCircle(context, width),
          Positioned(
            top: sizer(false, 250, context),
            left: width * 0.5 - (320 / 2),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                _userDetailsWidget(),
                const SizedBox(
                  height: 70,
                ),
                TextButton(
                    onPressed: () {
                      showAlertDialog(context,
                              title: 'Logout',
                              content: 'Are you sure you want to logout?',
                              defaultActionText: 'YES',
                              cancelActionText: 'NO')
                          .then((value) {
                        if (value == true) {
                          _signOut();
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        minimumSize: const Size(100, 50)),
                    child: Text('Logout',
                        style: Fonts.montserratFont(
                            color: Colors.white,
                            size: 16,
                            fontWeight: FontWeight.normal)))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _userDetailsWidget() {
    return Container(
      width: 320,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _userDetailsCard(widget.userModel.name, 'Username', false),
            const SizedBox(
              height: 20,
            ),
            _userDetailsCard(widget.userModel.email, 'Email', false),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            iconTheme:
                                const IconThemeData(color: kPrimaryColor),
                          ),
                          body: SecondKYCScreen(
                            gender: widget.userModel.gender,
                            viewModel: widget.model,
                          ),
                        ),
                      ));
                },
                child: _userDetailsCard(
                    widget.model.getGenderString(widget.userModel.gender!),
                    'Gender',
                    true)),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => Scaffold(
                        appBar: AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          iconTheme: const IconThemeData(color: kPrimaryColor),
                        ),
                        body: FourthKYCScreen(
                          weight: widget.model
                              .getWeight(widget.userModel.weightParam!),
                          editingController: _editingController,
                          weightString: widget.userModel.weight,
                          viewModel: widget.model,
                        ),
                      ),
                    ));
              },
              child: _userDetailsCard(
                  '${widget.userModel.weight!} ${widget.userModel.weightParam!}',
                  'Current weight',
                  true),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => Scaffold(
                        appBar: AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          iconTheme: const IconThemeData(color: kPrimaryColor),
                        ),
                        body: ThirdKYCScreen(
                          goals: widget.userModel.goal,
                          viewModel: widget.model,
                        ),
                      ),
                    ));
              },
              child: _userDetailsCard(
                  widget.model.getGoalString(widget.userModel.goal),
                  'My Goals',
                  true),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Positioned _userPhotoCircle(BuildContext context, double width) {
    return Positioned(
      top: sizer(false, 70, context),
      left: width * 0.5 - 80,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kPrimaryColor, width: 1.5)),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              // backgroundColor: Colors.transparent,
              child: Image.network(
                widget.userModel.photoURL!.isEmpty ||
                        widget.userModel.photoURL == null
                    ? kDefaultProfilePhoto
                    : widget.userModel.photoURL!,
                height: 160,
                fit: BoxFit.fill,
                width: 160,
              ),
            ),
          ),
          MaterialButton(
              onPressed: () {},
              shape: const CircleBorder(),
              color: kPrimaryColor,
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
              ))
        ],
      ),
    );
  }

  Container _userDetailsCard(String text1, String text2, bool isEditable) {
    return Container(
      height: 40,
      // width: 200,
      decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: kPrimaryAccentColor)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Text(
              text1,
              maxLines: 2,
              style: Fonts.montserratFont(
                  color: kPrimaryColor, size: 15, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            Text(
              text2,
              style: Fonts.montserratFont(
                  color: Colors.black38, size: 12, fontWeight: FontWeight.w300),
            ),
            if (isEditable) ...[
              const SizedBox(
                width: 10,
              ),
              const Icon(Icons.arrow_forward_ios)
            ]
          ],
        ),
      ),
    );
  }
}
