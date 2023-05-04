import 'package:flutter/material.dart';

import '../main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/image/splash_screen.png',
              width: 300,
              height: 300,
            ),
          ),
          const SizedBox(height: 70),
          ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(10),
              minimumSize: MaterialStateProperty.all<Size>(
                const Size(300, 60),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xFFFF4500),
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
            child: const Text(
              'VAMOS COMEÇAR',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
