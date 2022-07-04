import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/enum/language.dart';
import 'package:dietri/helper/sizer.dart';
import 'package:dietri/screens/landinpage.dart';
import 'package:flutter/material.dart';


class LanguageTiles extends StatefulWidget {
  final String text;
   Language lang;
   final dynamic isOthers;
   final dynamic height;

   LanguageTiles({ Key? key, required this.text, required this.lang, this.isOthers = false, this.height  }) : super(key: key);

  @override
  State<LanguageTiles> createState() => _LanguageTilesState();
}

class _LanguageTilesState extends State<LanguageTiles> {
      Language _lang = Language.English;
      TextEditingController _others = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: widget.isOthers != true ? 50 : 70,
      child: Container(
        padding: EdgeInsets.only(bottom: 13.0),
        
        // alignment: widget.isOthers != true ? Alignment.center: null,
        height: 50.0,
        decoration: BoxDecoration(
            color: kListGrey,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(width: 1, color: kLightGrey)),
        child: ListTile(
          leading: widget.isOthers != true ?
          Text(widget.text, style: Fonts.montserratFont(color: Colors.black, size: sizer(true, 15.0, context), fontWeight: FontWeight.w400),):
          Container(
            height: 70,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.text, style: Fonts.montserratFont(color: Colors.black, size: sizer(true, 15.0, context), fontWeight: FontWeight.w400),),
                Expanded(
                  // flex: 3,
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.black
                    ),
                      maxLines: 3,
                    controller: _others,
                    scrollPhysics: AlwaysScrollableScrollPhysics(),
                  decoration: InputDecoration(filled: true, hintText: 'Kindly tyoe in here', fillColor: Colors.white,),
                          ),
                ),
              ],
            ),
          ),
        
          trailing:  widget.isOthers != true?
          Radio<Language>(
            toggleable: true,
                // activeColor: kPrimaryColor,
            fillColor: MaterialStateColor.resolveWith((states) => kPrimaryColor),
            focusColor: MaterialStateColor.resolveWith((states) => Colors.green),
                value: widget.lang,
                groupValue: _lang ,
                onChanged: (Language? value) {
                  setState(() {
                    _lang = value! ;
                  });
                  print(_lang);
                },
              ): Spacer()
        ),
      ),
    );

  }
}