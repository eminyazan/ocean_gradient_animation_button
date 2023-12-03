import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'animation_gradient.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Ocean Animation Button'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: AnimationGradient(
          child: SizedBox(
            width: size.width * 0.5,
            height: size.height * 0.15,
            child: Stack(
              children: [
                //Text of button
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Flutter Animation Button',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                //Lottie Animation
                Lottie.asset(
                  'assets/animations/fish.json',
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
