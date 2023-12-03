import 'package:flutter/material.dart';

class AnimationGradient extends StatefulWidget {
  final Widget child;

  const AnimationGradient({super.key, required this.child});

  @override
  State<AnimationGradient> createState() => _AnimationGradientState();
}

class _AnimationGradientState extends State<AnimationGradient> with TickerProviderStateMixin {
  //Animation Stuff
  late Animation<double> _animation;
  late AnimationController _controller;

  //Colors
  late List<ColorTween> _colorTween;

  final List<Color> _beginColors = [
    const Color(0xFF065291),
    const Color(0xFF1da2d8),
  ];

  //Reverse of _beginColors for simulating waves
  final List<Color> _endColors = [
    const Color(0xFF1da2d8),
    const Color(0xFF065291),
  ];

  //Positions of animations
  AlignmentTween begin = AlignmentTween(begin: Alignment.topLeft, end: Alignment.topRight);
  AlignmentTween end = AlignmentTween(begin: Alignment.bottomLeft, end: Alignment.bottomRight);

  List<ColorTween> getColorTween() {
    final List<ColorTween> colorTween = [];
    //Same length _beginColors it doesn't matter
    for (int i = 0; i < _beginColors.length; i++) {
      colorTween.add(
        ColorTween(
          //Colors was reverse so it will looks like a wave
          begin: _beginColors[i],
          end: _endColors[i],
        ),
      );
    }
    return colorTween;
  }

  @override
  void initState() {
    //We will get list of ColorTween
    _colorTween = getColorTween();

    //Setup animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    //Create curve animation
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    super.initState();
  }

  //We can get colors from _colorTween but we did not define it yet now let's define it
  List<Color> evaluateColors(Animation<double> animation) {
    final List<Color> colors = [];
    for (int i = 0; i < _colorTween.length; i++) {
      colors.add(_colorTween[i].evaluate(animation)!);
    }
    return colors;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        //Returns a container with linear gradient
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: begin.evaluate(_animation),
              end: end.evaluate(_animation),
              //Nor crete evaluateColors metthod
              colors: evaluateColors(_animation),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          //Give a child
          child: widget.child,
        );
      },
    );
  }
}
