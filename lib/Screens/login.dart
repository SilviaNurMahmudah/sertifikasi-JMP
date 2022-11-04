import 'package:flutter/material.dart';
import 'package:sertifikasi/Helper/DbHelpers.dart';
import 'package:sertifikasi/Model/UserModel.dart';
import 'package:sertifikasi/Screens/profile.dart';
import 'package:sertifikasi/Screens/home.dart';
import 'package:sertifikasi/Screens/register.dart';
import 'package:sertifikasi/Widget/comHelper.dart';
import 'package:sertifikasi/Widget/getTextFormField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = new GlobalKey<FormState>();

  final TextEditingController _conUserName = TextEditingController();
  final TextEditingController _conPassword = TextEditingController();
  var dbHelper;

  bool _isHidePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  login() async {
    String username = _conUserName.text;
    String password = _conPassword.text;

    if (username.isEmpty) {
      alertDialog(context, "Please Enter User ID");
    } else if (password.isEmpty) {
      alertDialog(context, "Please Enter Password");
    } else {
      await dbHelper.getLoginUser(username, password).then((userData) {
        if (userData != null) {
          setSP(userData).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => Home()),
                (Route<dynamic> route) => false);
          });
        } else {
          alertDialog(context, "Error: User Not Found");
        }
      }).catchError((error) {
        print(error);
        alertDialog(context, "Error: Login Fail");
      });
    }
  }

  Future setSP(UserModel user) async {
    final SharedPreferences sp = await _pref;

    // sp.setInt("id", user.id);
    sp.setString("username", user.username);
    sp.setString("nama", user.nama);
    sp.setString("nohp", user.nohp);
    sp.setString("password", user.password);
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: const Color.fromARGB(255, 75, 74, 74),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50.0),
            Image.asset(
              "assets/key.png",
              height: 150.0,
              width: 150.0,
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: getTextFormField(
                controller: _conUserName,
                icon: Icons.person,
                hintName: 'User Name',
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: getTextFormField(
                controller: _conPassword,
                icon: Icons.lock,
                hintName: 'Password',
                isObscureText: _isHidePassword,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: GestureDetector(
                onTap: () {
                  _togglePasswordVisibility();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Show Password'),
                    Icon(
                      _isHidePassword ? Icons.visibility_off : Icons.visibility,
                      color: _isHidePassword ? Colors.grey[600] : Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                margin: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 75, 74, 74),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: login,
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Does not have account? '),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 75, 74, 74),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Register'),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => SignupForm()),
                        (Route<dynamic> route) => false);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
