import 'package:flutter/material.dart';
import 'const/assets.dart';
import 'dart:math' as math;

class AnimationPage extends StatefulWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(duration: const Duration(seconds: 5), vsync: this);

    animation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(animationController)
    ..addListener(() {
      setState(() {});
    });

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform.rotate(
          angle: animation.value,
        child: Container(
          alignment: Alignment.center,
          padding: const  EdgeInsets.all(30),
          child: Image.asset(Assets.resocode),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }
}
