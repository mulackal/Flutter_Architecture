import 'package:beautysquare/base/base_page.dart';
import 'package:beautysquare/model/login_responds.dart';
import 'package:beautysquare/model/passes_responds.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'passes_page_view.dart';
import 'passes_presenter.dart';




class PassesPages extends BasePage {
  static const routeName = '/passes';
  @override
  _PassesPagesState createState() => new _PassesPagesState();
}

class _PassesPagesState extends BasePageState<PassesPages> implements PassesView{

  PassesPresenter _presenter;
  List<PassData> _homedataS;


  final GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();


  _PassesPagesState() {
    _presenter = new PassesPresenter(this);
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffold,
      appBar: new AppBar(
        title: new Text('Passess'),
        elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0.0 : 5.0,
      ),
      body: FutureBuilder(
        future: _presenter.loadData(),
        builder: (context, snapshot) {
          /** hide loader**/
          hideLoader();

          if (snapshot.hasData) {
            List<PassData> data = snapshot.data;
            if(data!=null && data.length > 0)
            return _feedBackWidget(data);
            else
              return Center(child: Text("No data found"));
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: Text("No data found")); //return CircularProgressIndicator();
        },

      ),
    );
  }

  Widget _feedBackWidget(List<PassData> data) {
    return RefreshIndicator(
        onRefresh: () =>  _presenter.loadData(),
      child: Container(
      child: new Padding(
        padding: EdgeInsets.all(8.0),
        child: new Column(
          children: <Widget>[
            new Flexible(
              child: new ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  final PassData _homedata = data[index];
                  return _getCardItemUi(context, _homedata);
                },
              ),
            )
          ],
        ),
      ),
    ),
    );
  }


  Widget _getCardItemUi(BuildContext context, PassData _homedata) {
    return new Card(
      child: new Column(
        children: <Widget>[
          new ListTile(
            title: new Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: new Text(
                _homedata.name,
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent,
                  fontSize: 18.0,
                ),
              )
            ),

            subtitle: new Padding(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                child: new Text(
                  "Message: "+_homedata.created_date +
                      ",\n\nFeedback: " + _homedata.destination,
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                )),
            trailing:  new Padding(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                child: new Text(
                  _homedata.employer_phone_number,
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.green,
                  ),
                )),


            onTap: () {
              if(_homedata!=null)
               _popUpBack();
            },
          )
        ],
      ),
    );
  }

  void _popUpBack() {
    Navigator.pop(context, 'ReLogin');
  }

  @override
  onLoadSucces(PassResponds items) {
   /* setState(() {
      _homedataS = items.data;
    });*/
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

}


