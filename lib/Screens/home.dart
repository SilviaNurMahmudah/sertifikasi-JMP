import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sertifikasi/Helper/DbHelpers.dart';
import 'package:sertifikasi/Screens/login.dart';
import 'package:sertifikasi/Widget/getHomeWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();

    late DbHelper dbHelper;
    final _conUserId = TextEditingController();
    final _conDelUserId = TextEditingController();
    final _conUserName = TextEditingController();
    final _conNama = TextEditingController();
    final _conNohp = TextEditingController();
    final _conPassword = TextEditingController();

  Future<void> getUserData() async {
    final SharedPreferences sp = await _pref;

    setState(() {
      _conUserName.text = sp.getString("username")!;
      _conNama.text = sp.getString("nama")!;
      _conNohp.text = sp.getString("nohp")!;
      _conPassword.text = sp.getString("password")!;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();

    dbHelper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 25, 30, 55),
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.white70),
          ),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.home, color: Colors.white70),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "SELAMAT DATANG",
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    getHomeWidget(
                      text: 'Profile',
                      img: 'assets/profile.png',
                      onTap: '/profile',
                    ),
                    SizedBox(height: 20),
                    getHomeWidget(
                      text: 'Maps',
                      img: 'assets/maps.png',
                      onTap: '/maps',
                    ),
                  ],
                ),
              ],
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
        ));
  }
}
