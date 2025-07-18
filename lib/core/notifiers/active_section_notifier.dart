import 'package:flutter/foundation.dart';

class ActiveSectionNotifier extends ValueNotifier<int> {
  ActiveSectionNotifier() : super(0);


  void setActiveSection(int index) {
    if (value != index) {
      value = index;
    }
  }
}