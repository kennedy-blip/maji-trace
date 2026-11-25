import 'dart:ui';
import 'package:flutter/material.dart';
class GlassCard extends StatelessWidget {
 const GlassCard({super.key,required this.child,this.padding=const EdgeInsets.all(18)});
 final Widget child; final EdgeInsets padding;
 @override Widget build(BuildContext context)=>ClipRRect(borderRadius:BorderRadius.circular(22),child:BackdropFilter(filter:ImageFilter.blur(sigmaX:14,sigmaY:14),child:Container(padding:padding,decoration:BoxDecoration(color:Theme.of(context).brightness==Brightness.dark?Colors.white.withValues(alpha:.055):Colors.white.withValues(alpha:.72),borderRadius:BorderRadius.circular(22),border:Border.all(color:Theme.of(context).brightness==Brightness.dark?Colors.white12:Colors.teal.withValues(alpha:.16))),child:child)));
}
