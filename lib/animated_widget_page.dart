import 'package:flutter/material.dart';
import 'const/assets.dart';
import 'dart:math' as math;

class AnimatedPage extends StatefulWidget {
  const  AnimatedPage({Key? key}) : super(key: key);

  @override
  State<AnimatedPage> createState() => _AnimatedPageState();
}

class _AnimatedPageState extends State<AnimatedPage> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        duration: const Duration(seconds: 5),
        vsync: this
    );

    final curvedAnimation = CurvedAnimation(
        parent: animationController,
        curve: Curves.bounceIn,
        reverseCurve: Curves.easeOut
    );

    animation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(curvedAnimation)
      ..addStatusListener((status) {
        if(status == AnimationStatus.completed){
          animationController.reverse();
        }else if(status == AnimationStatus.dismissed){
          animationController.forward();
        }
      });

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RotatingTransition(
          angle: animation,
          child:  const ResocoderImage(),
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

class RotatingTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> angle;
  const RotatingTransition({Key? key, required this.angle, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: angle,
        child : child,
      builder: (context, child){
          return Transform.rotate(
              angle: angle.value,
            child: child,
          );
      },
    );
  }
}


class ResocoderImage extends StatelessWidget  {
  const ResocoderImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const  EdgeInsets.all(30),
      child: Image.asset(Assets.resocode),
    );
  }
}





// class ResocoderImage extends AnimatedWidget  {
//   Animation<double> animation;
//   ResocoderImage({Key? key, required this.animation}) : super(key: key, listenable: animation);
//
//   @override
//   Widget build(BuildContext context) {
//     return Transform.rotate(
//       angle: animation.value,
//       child: Container(
//         alignment: Alignment.center,
//         padding: const  EdgeInsets.all(30),
//         child: Image.asset(Assets.resocode),
//       ),
//     );
//   }
// }

