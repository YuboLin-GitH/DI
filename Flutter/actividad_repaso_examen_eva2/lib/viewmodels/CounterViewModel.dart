import 'package:actividad_repaso_examen_eva2/models/CounterModel.dart';
import 'package:flutter/material.dart';

class CounterViewModel extends ChangeNotifier{
  final CounterModel _counterModel;

  CounterViewModel(this._counterModel);

  int get counter => _counterModel.value;

  void incrementar() {
    _counterModel.value++;
    notifyListeners();
  }

  void decrementar() {
    _counterModel.value--;
    notifyListeners();
  }
  
}