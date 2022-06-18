 import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Fonts{
 
 static TextStyle montserratFont({required Color color,  required double size, required FontWeight fontWeight}) => GoogleFonts.montserrat(color: color, fontSize: size, fontWeight: fontWeight);

 static TextStyle interFont({required Color color,  required double size, required FontWeight fontWeight}) => GoogleFonts.inter(color: color, fontSize: size, fontWeight: fontWeight);

 static TextStyle robotoFont({required Color color,  required double size, required FontWeight fontWeight}) => GoogleFonts.roboto(color: color, fontSize: size, fontWeight: fontWeight); 

}

