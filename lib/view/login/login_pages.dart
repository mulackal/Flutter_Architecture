
import 'package:beautysquare/providers/appLanguage.dart';
import 'package:beautysquare/util/app_localizations.dart';
import 'package:beautysquare/util/common_util.dart';
import 'package:beautysquare/util/constant.dart';
import 'package:beautysquare/util/logger_util.dart';
import 'package:beautysquare/util/network_checking.dart';
import 'package:beautysquare/util/resource_string.dart';
import 'package:beautysquare/util/screen_argument.dart';
import 'package:beautysquare/util/screen_text_util.dart';
import 'package:beautysquare/util/shared_Preference_manager.dart';
import 'package:beautysquare/view/passes/passes_pages.dart';
import 'package:flutter/services.dart';

import 'package:beautysquare/base/base_page.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:beautysquare/model/login_responds.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'login_page_view.dart';
import 'login_presenter.dart';


class LoginPages extends BasePage {

  static const routeName = '/login';

  @override
  _LoginPagesState createState() => new _LoginPagesState();
}

class _LoginPagesState extends BasePageState<LoginPages>  implements LoginView  {

  LoginPresenter _presenter;

  var txt_mobile = TextEditingController();
  var txt_password = TextEditingController();

  String password = "";
  String mobile = "";
  String LOGTXT =  "Login";

  final focuspassword = FocusNode();
  var txt_logname = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();

  _LoginPagesState() {
    _presenter = new LoginPresenter(this);
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    /** receive data from bundle**/
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    LoggerUtil().e("loginkey", args.title);


    final screeSize = MediaQuery.of(context).size;
    ScreenSizeTextUtil().setScreenSize(screeSize);
    ScreenSizeTextUtil().updateScreenDimesion(width: screeSize.width, height: screeSize.height);

    var appLanguage = Provider.of<AppLanguage>(context);
    
    return new Scaffold(
      key: _scaffold,
      appBar:  AppBar(
        title: Text(
          ResourceString().getString("title"),
        textAlign: TextAlign.left,
        style: ScreenSizeTextUtil().getTextStyleRegular(
            color: Colors.white, fontsize: 16, fontWeight: FontWeight.bold),
      ),
        automaticallyImplyLeading: false,
        elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0.0 : 5.0,
      ),
      body: _getLoginUi(appLanguage),
    );
  }



  Widget _getLoginUi(AppLanguage appLanguage) {
    return  Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0,0.0,20.0,0.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          new TextFormField(
          controller: txt_mobile,
          decoration: new InputDecoration(
            labelText: 'Phone Number',
            labelStyle: new TextStyle(color: Colors.black),
            counterText: "",
          ),

          keyboardType: TextInputType.number,
          maxLength: 10,
          maxLines: 1,
          textInputAction: TextInputAction.next,
            onFieldSubmitted: (v){
              FocusScope.of(context).requestFocus(focuspassword);
            },
          onChanged: (String text) {
            setState(() {
              mobile = text;
              print("mobile : " + mobile);
            });
          },),

            new TextFormField(
              focusNode: focuspassword,
              controller: txt_password,
              decoration: new InputDecoration(
                labelText: 'Password',
                labelStyle: new TextStyle(color: Colors.black,),),

              keyboardType: TextInputType.text,
              obscureText: true, // password format
              maxLines: 1,
              textInputAction: TextInputAction.done,
              onChanged: (String text) {
                setState(() {
                  password = text;
                  print("password : " + password);
                });
              },),

            new SizedBox(height: 25.0,),


            SizedBox(
              width: double.infinity,
              height: ScreenSizeTextUtil().loginButtonHight,
              child: new RaisedButton(
                child: Text( LOGTXT,textAlign: TextAlign.center,),
                onPressed: _clickButton, //()=>clickButton(appLanguage),
                color: Colors.black,
                elevation: 2.0,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                splashColor: Colors.black12,
              ),
            ),

            new SizedBox(height: 20.0,),

            Text(AppLocalizations.of(context).translate('Message'), textAlign:TextAlign.center, style: Theme.of(context).textTheme.body1,),

          ],
        ),
      ),
    );
  }

  void _clickButton() {

    CommonUtil().keyboardHide(context);

    LoggerUtil().e("dateTime utl", CommonUtil().currentDateTimeMilli());
    LoggerUtil().e("Date", CommonUtil().currentDate(""));
    LoggerUtil().e("Time", CommonUtil().currentDateTime());
    LoggerUtil().e("Format", CommonUtil().dateFormater("2020/08/25"));


    if(mobile.trim().length > 0 ){
       showLoader();
      _presenter.loadData(mobile,password);

    }else
       showToast("Please enter the mobile number",duration: Toast.LENGTH_SHORT);

  }

  void _showSnackBar(String data) {
    _scaffold.currentState.showSnackBar(
      new SnackBar(content: new Text(data),),);
  }

  @override
  onLoadSucces(LoginResponds items) async {

     hideLoader();
     showToast("Login Successful!");
     
     LoggerUtil().v("LoginResponds:", items.data.name);

     SharedPreferenceManager().setLogin(true);
     SharedPreferenceManager().setAuthToken(items.data.access_token);
     
     LoggerUtil().e("LoginResponds:session",  SharedPreferenceManager().getAuthToken());

     /** get back data from another page**/
     final result = await Navigator.push(context,MaterialPageRoute(builder: (context) => PassesPages()));
     if(result!=null && result.toString().trim().length > 0){
       setState(() {
         LOGTXT = result;
       });
     }

  }

  @override
  hideLoader() {
    hideLoadingDialoge();
  }

  @override
  showLoader() {
   showLoadingDialoge();
  }

  @override
  showWarningMessage(String message) {
    showToast(message);
  }

  @override
  showErrorMessage(String message) {
    hideLoader();
    showToast(message);
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
   // _passwordController.dispose();
    super.dispose();
  }

  clickButton(AppLanguage appLanguage) {
    print("screensize"+ScreenSizeTextUtil().screenSize.height.toString());
    appLanguage.changeLanguage(Locale("ar"));
  }

}

