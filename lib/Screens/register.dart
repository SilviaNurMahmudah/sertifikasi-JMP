import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sertifikasi/Helper/DbHelpers.dart';
import 'package:sertifikasi/Model/UserModel.dart';
import 'package:sertifikasi/Screens/login.dart';
import 'package:sertifikasi/Widget/comHelper.dart';
import 'package:sertifikasi/Widget/getTextFormField.dart';
import 'package:toast/toast.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = new GlobalKey<FormState>();

  // final _conUserId = TextEditingController();
  final TextEditingController _conUserName = TextEditingController();
  final TextEditingController _conNama = TextEditingController();
  final TextEditingController _conNohp = TextEditingController();
  final TextEditingController _conPassword = TextEditingController();
  final TextEditingController _conCPassword = TextEditingController();
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

  signUp() async {
    int id = 1;
    String username = _conUserName.text;
    String nama = _conNama.text;
    String nohp = _conNohp.text;
    String password = _conPassword.text;
    String cpassword = _conCPassword.text;

    if (_formKey.currentState!.validate()) {
      if (password != cpassword) {
        alertDialog(context, 'Password Mismatch');
      } else {
        _formKey.currentState!.save();

        UserModel uModel = UserModel(username, nama, nohp, password);
        await dbHelper.saveData(uModel).then((userData) {
          alertDialog(context, "Successfully Saved");
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => LoginForm()));
        }).catchError((error) {
          print(error);
          alertDialog(context, "Error: Register Fail");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: const Color.fromARGB(255, 75, 74, 74),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
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
                getTextFormField(
                  controller: _conUserName,
                  icon: Icons.person_outline,
                  inputType: TextInputType.name,
                  hintName: 'User Name',
                ),
                const SizedBox(height: 10.0),
                getTextFormField(
                  controller: _conNama,
                  icon: Icons.person,
                  inputType: TextInputType.name,
                  hintName: 'Nama',
                ),
                const SizedBox(height: 10.0),
                getTextFormField(
                  controller: _conNohp,
                  icon: Icons.phone,
                  inputType: TextInputType.name,
                  hintName: 'No HP',
                ),
                const SizedBox(height: 10.0),
                getTextFormField(
                  controller: _conPassword,
                  icon: Icons.lock,
                  hintName: 'Password',
                  isObscureText: _isHidePassword,
                ),
                const SizedBox(height: 10.0),
                getTextFormField(
                  controller: _conCPassword,
                  icon: Icons.lock,
                  hintName: 'Confirm Password',
                  isObscureText: _isHidePassword,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      _togglePasswordVisibility();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Show Password'),
                        Icon(
                          _isHidePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color:
                              _isHidePassword ? Colors.grey[600] : Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 75, 74, 74),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Does you have account? '),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 75, 74, 74),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Login'),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => LoginForm()),
                          (Route<dynamic> route) => false,
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
