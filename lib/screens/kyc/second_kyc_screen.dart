import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietri/components/show_alert_dialog.dart';
import 'package:dietri/components/show_exception_dialog.dart';
import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/helper/enums.dart';
import 'package:dietri/helper/sizer.dart';
import 'package:dietri/view_models/profile_page_view_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SecondKYCScreen extends StatefulWidget {
  SecondKYCScreen(
      {Key? key,
      required this.gender,
      this.onPressed,
      this.onPressed1,
      this.onPressed2,
      this.viewModel})
      : super(key: key);
  Gender? gender;
  final VoidCallback? onPressed, onPressed1, onPressed2;
  final ProfileViewModel? viewModel;
  @override
  State<SecondKYCScreen> createState() => _SecondKYCScreenState();
}

class _SecondKYCScreenState extends State<SecondKYCScreen> {
  Gender? _gender;

  @override
  void initState() {
    super.initState();
    if (widget.gender != null) {
      _gender = widget.gender;
    }
  }

     void _updateUserGenderinDataBase(Gender gender) async {
    try {
      await widget.viewModel?.updateUserGender(gender);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(context,
          title: 'Something went wrong', exception: e);
    } catch (e) {
      showAlertDialog(context,
          title: 'Unknown Error',
          content: 'oops, something\'s not right',
          defaultActionText: 'OK');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'What is your gender?',
            textAlign: TextAlign.center,
            style: Fonts.montserratFont(
                color: Colors.black, size: 24, fontWeight: FontWeight.w500),
          ),
          OutlinedButton(
              onPressed: widget.viewModel != null ? () => setState(() {
                    _gender = Gender.male;
                  }): widget.onPressed,
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _gender == Gender.male ? kPrimaryColor : Colors.white,
                  minimumSize: Size(
                      sizer(true, 388, context), sizer(false, 60, context))),
              child: Text(
                'Male',
                style: Fonts.montserratFont(
                    color:
                        _gender == Gender.male ? Colors.white : kPrimaryColor,
                    size: 16,
                    fontWeight: FontWeight.w500),
              )),
          OutlinedButton(
              onPressed: widget.viewModel != null ? () => setState(() {
                    _gender = Gender.female;
                  }) : widget.onPressed1,
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _gender == Gender.female ? kPrimaryColor : Colors.white,
                  minimumSize: Size(
                      sizer(true, 388, context), sizer(false, 60, context))),
              child: Text(
                'Female',
                style: Fonts.montserratFont(
                    color:
                        _gender == Gender.female ? Colors.white : kPrimaryColor,
                    size: 16,
                    fontWeight: FontWeight.w500),
              )),
          OutlinedButton(
              onPressed: widget.viewModel != null?  () => setState(() {
                    _gender = Gender.others;
                  }) : widget.onPressed2,
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _gender == Gender.others ? kPrimaryColor : Colors.white,
                  minimumSize: Size(
                      sizer(true, 388, context), sizer(false, 60, context))),
              child: Text(
                'Others',
                style: Fonts.montserratFont(
                    color:
                        _gender == Gender.others ? Colors.white : kPrimaryColor,
                    size: 16,
                    fontWeight: FontWeight.w500),
              )),
        if (widget.viewModel != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: TextButton(
                  onPressed: widget.viewModel!.isLoading
                      ? null
                      : () {
                          _updateUserGenderinDataBase(_gender!);
                          Navigator.of(context).pop();
                        },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      minimumSize: const Size(150, 50)),
                  child: widget.viewModel!.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                          ),
                        )
                      : Text('Update',
                          style: Fonts.montserratFont(
                              color: Colors.white,
                              size: 16,
                              fontWeight: FontWeight.normal))),
            ),
        ],
      ),
    );
  }
}
