import 'package:beautysquare/base/base_view.dart';
import 'package:beautysquare/model/login_responds.dart';


abstract class LoginView implements BaseView{
  onLoadSucces(LoginResponds items);

}