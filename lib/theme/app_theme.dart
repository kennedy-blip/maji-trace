import 'package:flutter/material.dart';
const aqua=Color(0xff20d6d0);
ThemeData buildTheme(String mode) {
 final dark=mode!='Daylight Spring';
 final base=ThemeData(useMaterial3:true,brightness:dark?Brightness.dark:Brightness.light,colorSchemeSeed:mode=='High-Contrast Kiosk'?const Color(0xffffc247):aqua,scaffoldBackgroundColor:dark?const Color(0xff07131f):const Color(0xffedf7f5));
 return base.copyWith(cardTheme:CardThemeData(color:dark?const Color(0xff132638).withValues(alpha:.86):Colors.white.withValues(alpha:.88),elevation:0,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(22),side:BorderSide(color:dark?Colors.white12:Colors.teal.withValues(alpha:.15)))),inputDecorationTheme:InputDecorationTheme(filled:true,fillColor:dark?Colors.white.withValues(alpha:.06):Colors.black.withValues(alpha:.035),border:OutlineInputBorder(borderRadius:BorderRadius.circular(14),borderSide:BorderSide.none)));
}
