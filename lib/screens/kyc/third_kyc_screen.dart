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
class ThirdKYCScreen extends StatefulWidget {
  ThirdKYCScreen(
      {Key? key,
      required this.goals,
      this.onPressed,
      this.onPressed1,
      this.onPressed2,
      this.viewModel})
      : super(key: key);
  Goals? goals;
  final VoidCallback? onPressed, onPressed1, onPressed2;
  final ProfileViewModel? viewModel;

  @override
  State<ThirdKYCScreen> createState() => _ThirdKYCScreenState();
}

class _ThirdKYCScreenState extends State<ThirdKYCScreen> {
  Goals? _goals;

  @override
  void initState() {
    super.initState();
    if (widget.goals != null) {
      _goals = widget.goals;
    }
  }

   void _updateUserGoalsinDataBase(Goals goals) async {
    try {
      await widget.viewModel?.updateUserGoals(goals);
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
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'What is your current goal?',
            textAlign: TextAlign.center,
            style: Fonts.montserratFont(
                color: Colors.black, size: 24, fontWeight: FontWeight.w500),
          ),
          OutlinedButton(
              onPressed: widget.viewModel != null
                  ? () => setState(() {
                        _goals = Goals.gainweight;
                      })
                  : widget.onPressed,
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                      sizer(true, 388, context), sizer(false, 60, context)),
                  backgroundColor: _goals == Goals.gainweight
                      ? kPrimaryColor
                      : Colors.white),
              child: Text(
                'Gain weight',
                style: Fonts.montserratFont(
                    color: _goals == Goals.gainweight
                        ? Colors.white
                        : kPrimaryColor,
                    size: 16,
                    fontWeight: FontWeight.w500),
              )),
          OutlinedButton(
              onPressed: widget.viewModel != null
                  ? () => setState(() {
                        _goals = Goals.maintainweight;
                      })
                  : widget.onPressed1,
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                      sizer(true, 388, context), sizer(false, 60, context)),
                  backgroundColor: _goals == Goals.maintainweight
                      ? kPrimaryColor
                      : Colors.white),
              child: Text(
                'Maintain Weight',
                style: Fonts.montserratFont(
                    color: _goals == Goals.maintainweight
                        ? Colors.white
                        : kPrimaryColor,
                    size: 16,
                    fontWeight: FontWeight.w500),
              )),
          OutlinedButton(
              onPressed: widget.viewModel != null
                  ? () => setState(() {
                        _goals = Goals.looseweight;
                      })
                  : widget.onPressed2,
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                      sizer(true, 388, context), sizer(false, 60, context)),
                  backgroundColor: _goals == Goals.looseweight
                      ? kPrimaryColor
                      : Colors.white),
              child: Text(
                'Lose weight',
                style: Fonts.montserratFont(
                    color: _goals == Goals.looseweight
                        ? Colors.white
                        : kPrimaryColor,
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
                          _updateUserGoalsinDataBase(_goals!);
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
