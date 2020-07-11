

import 'dart:convert';
import 'dart:io';

import 'package:beautysquare/util/network_checking.dart';
import 'package:dio/dio.dart';
import 'package:beautysquare/repository/app_repository.dart';
import 'package:beautysquare/util/data_injector.dart';
import 'package:beautysquare/util/device_info.dart';

import 'login_page_view.dart';


class LoginPresenter {

  LoginView _view;
  AppRepository _repository;

  Map<String, String> _deviceData = <String, String>{};
  FormData formData;
  LoginPresenter(this._view) {
    _repository = new Injector().myRepository;
  }

  Future<void> loadData(String mobile,String password) async {

    var device_id ="";
    var device_name = "";
    var platform = "";

    _deviceData = await DeviceInfo.initPlatformState();

           device_id  = _deviceData['device_id'];
           device_name =  _deviceData['device_name'];
           platform = _deviceData['platform'];

     print('initPlatformState: $device_name');

    // 9446317290 / dyenal
    // 9961538185 / vipin

    Map data = {
      'phone': " 9446317290",
      'password': "dyenal",
      'device_id': device_id,
      'device_info': device_name,
      'device_type': platform,
      'push_token': "token",
      'user_type': "Public"
    };
    //encode Map to JSON
    var body = json.encode(data);
    print("initPlatformState - $body");


     formData = new FormData.fromMap({
      "phone": "9961538185",
      "password": "vipin",
      "device_id": device_id,
      "device_info": device_name,
      "device_type": platform,
      "push_token": "token",
      "user_type": "Public",
    });


    if(await NetworkChecking.NetworkAvailable()){

      _repository
          .loginChecking(formData)
          .then((data) => _view.onLoadSucces(data))
          .catchError((e) => _view.showErrorMessage("Some probelm occure,Please try again!"));
    }else{
      _view.hideLoader();
      _view.showWarningMessage("Internet not available");
    }

  }



}
