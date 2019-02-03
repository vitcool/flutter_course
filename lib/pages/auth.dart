import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
        image: AssetImage('assets/background.jpg'),
        fit: BoxFit.cover,
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop));
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Email', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'This email is not valid';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Password is required and should be 6+ long';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildSwitchTile() {
    return SwitchListTile(
      value: _formData['acceptTerms'],
      onChanged: (bool value) {
        _formData['acceptTerms'] = value;
      },
      title: Text("Accept Terms"),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate() || !_formData['acceptTerms']) {
      return;
    }
    _formKey.currentState.save();
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500 : deviceWidth * 0.95;

    return Scaffold(
        appBar: AppBar(
          title: Text('Log in'),
        ),
        body: Form(
            key: _formKey,
            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(image: _buildBackgroundImage()),
                padding: EdgeInsets.all(10.0),
                child: Center(
                    child: SingleChildScrollView(
                        child: Container(
                  width: targetWidth,
                  child: Column(children: <Widget>[
                    _buildEmailTextField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildPasswordTextField(),
                    _buildSwitchTile(),
                    SizedBox(
                      height: 10.0,
                    ),
                    RaisedButton(
                      child: Text('Login'),
                      textColor: Colors.white,
                      onPressed: _submitForm,
                    )
                  ]),
                ))))));
  }
}
