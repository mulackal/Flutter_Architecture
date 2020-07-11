

import 'dart:convert';

import 'package:beautysquare/model/passes_responds.dart';
import 'package:beautysquare/repository/app_repository.dart';
import 'package:beautysquare/util/common_util.dart';

import 'package:beautysquare/util/data_injector.dart';
import 'package:beautysquare/util/network_checking.dart';

import 'package:beautysquare/util/shared_Preference_manager.dart';
import 'package:dio/dio.dart';


import 'passes_page_view.dart';



class PassesPresenter {
  PassesView _view;
  AppRepository _repository;
  FormData formData;

  PassesPresenter(this._view) {
    _repository = new Injector().myRepository;
  }

  Future<List<PassData>> loadData() async {

    _view.showLoader();

    if (await NetworkChecking.NetworkAvailable()) {
      formData = new FormData.fromMap({
        "date": "2020-05-10",//CommonUtil().currentDate("revers"), //"2020-05-10"
        "access_token": SharedPreferenceManager().getAuthToken(),});

      var passdata = await _repository.getPassesList(formData);

      return passdata.data;

      /*   _repository
        .getPassesList(formData)
        .then((data) => _view.onLoadSucces(data))
        .catchError((e) => _view.showErrorMessage("Some probelm occure,Please try again!"));
  }else{
  _view.hideLoader();
  _view.showWarningMessage("Internet not available");
  }*/
    }
  }
}