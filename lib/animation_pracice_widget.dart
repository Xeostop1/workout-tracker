import 'package:flutter/material.dart';

class AnimationPraciceWidget extends StatefulWidget {
  const AnimationPraciceWidget({super.key});

  @override
  State<AnimationPraciceWidget> createState() => _AnimationPraciceWidgetState();
}

class _AnimationPraciceWidgetState extends State<AnimationPraciceWidget>  with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller; //

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller =AnimationController(vsync: this, duration: Duration(seconds: 2));    // 위의 컨드톨러 초기화 -> 자기 자신을 계속 가르치고 있음
    final Animation<double> _curvedAnimation = CurvedAnimation(parent: _controller, curve: Curves.elasticInOut);
    _animation = Tween(begin: 50.0, end: 200.0).animate(_curvedAnimation);

    _animation.addListener((){
      setState(() {

      });
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: _animation.value,
        width: _animation.value,
        color: Colors.blue,

      ),
    );
  }

}

