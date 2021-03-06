
import 'dart:html' as html;
import 'package:flutter/material.dart';

extension hoverExtension on Widget{
  static final appContainer = html.window.document.getElementById("app-container");
  Widget get showCursorOnHover{
    return MouseRegion(
      child:this,
      onHover: (event)=> appContainer.style.cursor= 'pointer',
      onExit: (event) =>appContainer.style.cursor= 'default',
    );
  }
}