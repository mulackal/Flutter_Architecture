import 'dart:async';

import 'package:beautysquare/model/passes_responds.dart';
import 'package:dio/dio.dart';
import 'package:beautysquare/model/login_responds.dart';




abstract class AppRepository {


  Future<LoginResponds> loginChecking(FormData data);
  Future<PassResponds> getPassesList(FormData data);

}
