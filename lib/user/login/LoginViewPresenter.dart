import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:budget_tracker/common/di/injection.dart';
import 'package:budget_tracker/user/AuthenticationRequest.dart';
import 'package:budget_tracker/user/AuthenticationResponse.dart';
import 'package:budget_tracker/user/UserRepository.dart';

abstract class LoginViewContract {
  void navigateToTransactionsListPage();
  void showError();
}

class LoginViewPresenter {
  LoginViewContract _view;
  UserRepository _repository;
  LoginViewPresenter(this._view) {
    _repository = new Injector().userRepository;
  }

  void login(AuthenticationRequest authenticationRequest) {
    assert(_view != null);
    _repository
        .login(authenticationRequest)
        .then((AuthenticationResponse authenticationResponse) {
      _setTokenValue(authenticationResponse);
      _view.navigateToTransactionsListPage();
    }).catchError((onError) {
      _view.showError();
    });
  }

  void _setTokenValue(AuthenticationResponse authenticationResponse) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setString("token", authenticationResponse.token);
  }
}