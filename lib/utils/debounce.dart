import 'dart:async';

import 'package:flutter/material.dart';

class Debounce {
  final int millisecond;

  Debounce({
     this.millisecond = 500,
  });

  Timer? _timer;

  void run(VoidCallback action){
    close();
    _timer = Timer(Duration(milliseconds: millisecond), action);
  }

  void close(){
    if(_timer != null){
      _timer!.cancel();
    }
  }
  
}