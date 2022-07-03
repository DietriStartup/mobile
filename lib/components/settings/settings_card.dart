import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/helper/sizer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SettingsCard extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final buttonText;
  bool showSwitch = false;
  bool isSwitched = false;
  bool tailing = true;
   SettingsCard({ 
    Key? key,
    required this.text, required this.onPressed, this.buttonText, required this.showSwitch, required this.tailing
    }) : super(key: key);

  @override
  State<SettingsCard> createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kListGrey,
        borderRadius:  BorderRadius.circular(6.0),
        border: Border.all(
          width: 1,
          color: kLightGrey
        )
      
   
      ),
      // height: sizer(false, 40.0, context),
      child:Padding(
            padding: EdgeInsets.symmetric(horizontal: sizer(true, 21.0, context) ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget.text, style: Fonts.montserratFont(color: Colors.black, size: sizer(true, 15.0, context), fontWeight: FontWeight.w400),),
          widget.tailing != false?
          TextButton.icon(
            onPressed: widget.onPressed, 
            icon: Text(' ${widget.buttonText}', style: Fonts.montserratFont(color: kSubPrimaryColor, size: sizer(true, 16, context), fontWeight: FontWeight.w600),), 
            label: Icon(Icons.arrow_forward_ios_sharp, color: kDefaultGrey, size: 17.0)):
            
            
            widget.showSwitch == true?
             Switch(
          value: widget.isSwitched,
          onChanged: (value){
            setState(() {
              widget.isSwitched=value;
              print(widget.isSwitched);
            });
          },
          activeTrackColor: kGreen ,
          activeColor: Colors.white,
          inactiveTrackColor: kPrimaryColor,
        ): TextButton(onPressed: () {}, child: Text('')),

        ],
      ),
        ) 
      
    );
 
 
 
  }
}