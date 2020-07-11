import 'package:beautysquare/base/base_view.dart';
import 'package:beautysquare/model/passes_responds.dart';
import 'package:beautysquare/repository/repsonse_util.dart';



abstract class PassesView implements BaseView{
  onLoadSucces(PassResponds items);
}