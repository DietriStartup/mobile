import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietri/components/show_alert_dialog.dart';
import 'package:dietri/components/show_exception_dialog.dart';
import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/helper/enums.dart';
import 'package:dietri/helper/user_utils.dart';
import 'package:dietri/view_models/profile_page_view_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FourthKYCScreen extends StatefulWidget {
  FourthKYCScreen(
      {Key? key,
      required this.editingController,
      this.onPressed,
      this.onPressed1,
      this.onPressed2,
      required this.weight,
      this.weightString,
      this.viewModel})
      : super(key: key);
  final TextEditingController editingController;
  final VoidCallback? onPressed, onPressed1, onPressed2;
  Weight? weight;
  final String? weightString;
  final ProfileViewModel? viewModel;

  @override
  State<FourthKYCScreen> createState() => _FourthKYCScreenState();
}

class _FourthKYCScreenState extends State<FourthKYCScreen> {
  Weight? _weight;

  @override
  void initState() {
    super.initState();
    if (widget.weight != null && widget.weightString != null) {
      _weight = widget.weight;
      widget.editingController.text = widget.weightString!;
    }
    debugPrint(_weight.toString());
  }

  void _updateUserWeightinDataBase(Weight weight, String weightString) async {
    try {
      await widget.viewModel?.updateUserWeight(weight, weightString);
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            widget.viewModel != null
                ? 'Update your current weight'
                : 'What is your current weight?',
            textAlign: TextAlign.center,
            style: Fonts.montserratFont(
                color: Colors.black, size: 24, fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: TextField(
              controller: widget.editingController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: Fonts.montserratFont(
                  color: kPrimaryColor, size: 32, fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: kPrimaryColor,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: kPrimaryColor,
                  ),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: kPrimaryColor,
                  ),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text(
                    UserUtils.getWeightString(_weight ?? widget.weight),
                    style: Fonts.montserratFont(
                        color: kPrimaryColor,
                        size: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: widget.viewModel != null
                    ? () => setState(() {
                          _weight = Weight.st;
                        })
                    : widget.onPressed,
                child: Text(
                  'st',
                  style: Fonts.montserratFont(
                      color: kPrimaryColor,
                      size: 16,
                      fontWeight: FontWeight.w400),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: (_weight ?? widget.weight) == Weight.st
                        ? kPrimaryAccentColor
                        : Colors.white),
              ),
              TextButton(
                  onPressed: widget.viewModel != null
                      ? () => setState(() {
                            _weight = Weight.lb;
                          })
                      : widget.onPressed1,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: (_weight ?? widget.weight) == Weight.lb
                          ? kPrimaryAccentColor
                          : Colors.white),
                  child: Text(
                    'lb',
                    style: Fonts.montserratFont(
                        color: kPrimaryColor,
                        size: 16,
                        fontWeight: FontWeight.w400),
                  )),
              TextButton(
                  onPressed: widget.viewModel != null
                      ? () => setState(() {
                            _weight = Weight.kg;
                          })
                      : widget.onPressed2,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: (_weight ?? widget.weight) == Weight.kg
                          ? kPrimaryAccentColor
                          : Colors.white),
                  child: Text(
                    'kg',
                    style: Fonts.montserratFont(
                        color: kPrimaryColor,
                        size: 16,
                        fontWeight: FontWeight.w400),
                  )),
            ],
          ),
          if (widget.viewModel != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: TextButton(
                  onPressed: widget.viewModel!.isLoading
                      ? null
                      : () {
                          _updateUserWeightinDataBase(
                              _weight!, widget.editingController.text);
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
