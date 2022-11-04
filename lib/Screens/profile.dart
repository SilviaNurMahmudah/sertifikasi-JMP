import 'package:flutter/material.dart';
import 'package:sertifikasi/Helper/DbHelpers.dart';
import 'package:sertifikasi/Model/UserModel.dart';
import 'package:sertifikasi/Screens/login.dart';
import 'package:sertifikasi/Widget/comHelper.dart';
import 'package:sertifikasi/Widget/getTextFormField.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _HomeFormState createState() => _HomeFormState();
}

class _HomeFormState extends State<Profile> {
  final _formKey = new GlobalKey<FormState>();
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  late DbHelper dbHelper;
  final _conUserId = TextEditingController();
  final _conDelUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conNama = TextEditingController();
  final _conNohp = TextEditingController();
  final _conPassword = TextEditingController();

  bool _isHidePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();

    dbHelper = DbHelper();
  }

  Future<void> getUserData() async {
    final SharedPreferences sp = await _pref;

    setState(() {
      // _conUserId.text = sp.getString("user_id")!;
      // _conDelUserId.text = sp.getString("user_id")!;
      _conUserName.text = sp.getString("username")!;
      _conNama.text = sp.getString("nama")!;
      _conNohp.text = sp.getString("nohp")!;
      _conPassword.text = sp.getString("password")!;
    });
  }

  update() async {
    // String uid = _conUserId.text;
    String uname = _conUserName.text;
    String nama = _conNama.text;
    String nohp = _conNohp.text;
    String passwd = _conPassword.text;

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      UserModel user = UserModel(uname, nama, nohp, passwd);
      await dbHelper.updateUser(user).then((value) {
        if (value == 1) {
          alertDialog(context, "Successfully Updated");

          updateSP(user, true).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginForm()),
                (Route<dynamic> route) => false);
          });
        } else {
          alertDialog(context, "Error Update");
        }
      }).catchError((error) {
        print(error);
        alertDialog(context, "Error");
      });
    }
  }

  // delete() async {
  //   String delUserID = _conDelUserId.text;

  //   await dbHelper.deleteUser(delUserID).then((value) {
  //     if (value == 1) {
  //       alertDialog(context, "Successfully Deleted");

  //       updateSP(null, false).whenComplete(() {
  //         Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(builder: (_) => LoginForm()),
  //             (Route<dynamic> route) => false);
  //       });
  //     }
  //   });
  // }

  Future updateSP(UserModel user, bool add) async {
    final SharedPreferences sp = await _pref;

    if (add) {
      sp.setString("username", user.username);
      sp.setString("nama", user.nama);
      sp.setString("nohp", user.nohp);
      sp.setString("password", user.password);
    } else {
      sp.remove('id');
      sp.remove('username');
      sp.remove('nama');
      sp.remove('nohp');
      sp.remove('password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color.fromARGB(255, 75, 74, 74),
      ),
      body:
          // _children[_selectedNavbar],
          Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10.0),
                  getTextFormField(
                      controller: _conUserName,
                      icon: Icons.person_outline,
                      inputType: TextInputType.name,
                      hintName: 'User Name'),
                  const SizedBox(height: 10.0),
                  getTextFormField(
                      controller: _conNama,
                      icon: Icons.email,
                      inputType: TextInputType.name,
                      hintName: 'Nama'),
                  const SizedBox(height: 10.0),
                  getTextFormField(
                      controller: _conNohp,
                      icon: Icons.email,
                      inputType: TextInputType.name,
                      hintName: 'No HP'),
                  const SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conPassword,
                    icon: Icons.lock,
                    hintName: 'Password',
                    isObscureText: _isHidePassword,
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
                            _isHidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: _isHidePassword
                                ? Colors.grey[600]
                                : Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
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
                      onPressed: update,
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 75, 74, 74),
        ),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => LoginForm()),
            (Route<dynamic> route) => false,
          );
        },
        child: const Icon(
          Icons.logout,
        ),

        // BottomNavigationBar(
        //   items: const [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'home'
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.person),
        //       label: 'profile'
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.location_on),
        //       label: 'maps'
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.logout),
        //       label: 'logout'
        //     ),
        //   ],
        //   currentIndex: _selectedNavbar,
        //   selectedItemColor: Colors.black,
        //   unselectedItemColor: Colors.grey,
        //   showUnselectedLabels: true,
        //   onTap: _changeSelectedNavBar,
        // ),
      ),
    );
  }
}
