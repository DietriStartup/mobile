import 'package:dietri/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../helper/sizer.dart';

class GeneralTextField extends StatelessWidget {
  final String? hintText;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final double? fontSize;
  final FocusNode? focusNode;
  final TextEditingController? textController;
  final bool multiline;
  final AutovalidateMode? autoValidateMode;
  final String? Function(String?)? validator;
  final Widget? prefixIcon, suffixIcon;
  final StrutStyle? strutStyle;
  final TextAlignVertical? textAlignVertical;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final bool obscureText;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  const GeneralTextField({
    Key? key,
    this.hintText,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.keyboardType,
    this.textController,
    this.textCapitalization,
    this.onSaved,
    this.fontSize,
    this.validator,
    this.textAlignVertical,
    this.strutStyle,
    this.autoValidateMode,
    this.multiline = false,
    this.inputFormatters,
    this.maxLength,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();
    return TextFormField(
      focusNode: focusNode,
      maxLength: maxLength,

      textCapitalization: textCapitalization ?? TextCapitalization.none,
      controller: textController ?? _controller,
      onSaved: onSaved,
      onChanged: onChanged,
      textAlignVertical: TextAlignVertical.center, // textAlignVertical,
      autovalidateMode: autoValidateMode,
      maxLines: multiline ? 5 : 1,
      minLines: multiline ? 5 : 1,
      cursorHeight: sizer(true, 20.0, context),
      keyboardType: keyboardType ?? TextInputType.text,
      style: TextStyle(
          decoration: TextDecoration.none,
          color: Colors.black,
          fontSize: fontSize ?? sizer(true, 15.0, context)),
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        isDense: true,
        isCollapsed: true,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 2,
            color: kBlack,
          ),
        ),
        counter: const Offstage(),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:const BorderSide(
            width: 0.5,
            color: kGreyColor,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
            vertical: multiline
                ? sizer(false, 10, context)
                : sizer(false, 22, context),
            horizontal: sizer(true, 25, context)),
        fillColor: kWhiteColor,
        hintText: hintText ?? '',
        hintStyle: TextStyle(
            color:kInputTextColor,
            fontSize: fontSize ?? sizer(true, 15, context)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(sizer(true, 12, context)),
          borderSide: const BorderSide(
            width: 2,
            color:kPrimaryAccentColor,
          ),
        ),
        errorStyle: TextStyle(fontSize: sizer(true, 12, context)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(sizer(true, 12, context)),
          borderSide:const BorderSide(
            width: 2, color: kBlack ,
            //  style: BorderStyle.none,
          ),
        ),
        filled: true,
      ),
    
      //autovalidateMode: AutovalidateMode.onUserInteraction,
      // validator: validator ??
      //     (val) {
      //       if ((val?.length ?? 0) == 0) {
      //         return "${hintText ?? "Field"} is required";
      //       } else {
      //         return null;
      //       }
      //     },
    );
  }
}
