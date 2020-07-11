import 'package:flutter/material.dart';

import 'package:beautysquare/samples/platform_adaptive.dart';


class LoginForm extends StatefulWidget {
    @override
    _LoginFormState createState() => new _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
    final formKey = new GlobalKey<FormState>();

    String _username;
    String _password;

    void _submit() {
        final form = formKey.currentState;

        if (form.validate()) {
            form.save();
        }
    }

    @override
    Widget build(BuildContext context) {
        return  Form(
                    key: formKey,
                    child: new Column(
                        children: [
                            new TextFormField(
                                decoration: new InputDecoration(labelText: 'Username'),
                                validator: (val) =>
                                    val.isEmpty ? 'Please enter your username.' : null,
                                onSaved: (val) => _username = val,
                            ),
                            new TextFormField(
                                decoration: new InputDecoration(labelText: 'Password'),
                                validator: (val) =>
                                    val.isEmpty ? 'Please enter your password.' : null,
                                onSaved: (val) => _password = val,
                                obscureText: true,
                            ),
                            new Padding(
                                padding: new EdgeInsets.only(top: 20.0),
                                child: new PlatformAdaptiveButton(
                                    onPressed:() {
                                        _submit();
                                        //loginAction(context, _username, _password);
                                    },
                                    icon: new Icon(Icons.done),
                                    child: new Text('Log In'),
                                ),
                            )
                        ],
                    ),
                );
    }

}