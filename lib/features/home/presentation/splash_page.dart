import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom_api/core/constants/app_constant.dart';
import 'package:flutter_ecom_api/core/network/api_helper.dart';
import 'package:flutter_ecom_api/core/routes/app_routes.dart';
import 'package:flutter_ecom_api/features/authentication/presentation/bloc/user_bloc.dart';
import 'package:flutter_ecom_api/features/authentication/presentation/bloc/user_event.dart';
import 'package:flutter_ecom_api/features/authentication/presentation/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(LoadUserFromPrefsEvent());
    Timer(Duration(seconds: 2), () async {
      String nextPage = AppRoutes.LOGINPAGE;
      String token = await ApiHelper.getToken();

      if (token.isNotEmpty) {
        nextPage = AppRoutes.DASHBOARDPAGE;
      }
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, nextPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      //backgroundColor: Color.fromARGB(255, 235, 163, 91),
      //backgroundColor: Color(0xFF9D4D6F),
      body: Container(
        width: double.infinity,
        //color: Colors.amber,
        padding: EdgeInsets.only(top: 250, bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 80),
            SizedBox(height: 11),
            Text(
              AppConstants.APPNAME,
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 11),
            Text(
              'Your smart shopping companion.',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 21),
            Container(
              height: 51,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 21),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: OutlinedButton.styleFrom(backgroundColor: Colors.white),
                child: Text(
                  'Get Started',
                  style: TextStyle(color: Color(0xFFFA9938), fontSize: 16),
                ),
              ),
            ),
            Spacer(),
            Text(
              'Powered by The Software Source',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
