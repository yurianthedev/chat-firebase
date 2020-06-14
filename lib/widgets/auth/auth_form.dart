import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String, String, String, bool, BuildContext) submitFn;

  AuthForm(this.submitFn);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();

      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(),
          _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 10, top: 20),
                    child: TextFormField(
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email Address'),
                      onSaved: (value) {
                        _userEmail = value;
                      },
                    ),
                  ),
                  if (!_isLogin)
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        key: ValueKey('username'),
                        validator: (value) {
                          if (value.isEmpty || value.length < 4) {
                            return 'Please enter at least 4 characters';
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Username'),
                        onSaved: (value) {
                          _userName = value;
                        },
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: TextFormField(
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Password must have at least 7 characters';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Password'),
                      obscureText: true,
                      onSaved: (value) {
                        _userPassword = value;
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      child: Text(
                        _isLogin ? 'Login' : 'Register',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onPressed: _trySubmit,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child:
                          Text(_isLogin ? 'Register instead' : 'Login instead'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
