import 'package:flutter/material.dart';

enum AnimatedButtonPress {
  down,
  up,
}

typedef void KeyPress(AnimatedButtonPress action);

class AnimatedButton extends StatefulWidget {
  /// Add z-axis for 3-D Depth
  final List<BoxShadow> boxShadows;

  /// Widget in the center of the button. Defaults to Text()
  final Widget centerWidget;

  /// If a gradient IS NOT specified, there must be a color
  final Color color;

  /// Display a gradient for the button background, if null use 'color'
  final LinearGradient gradient;

  /// Height of the button
  final double height;

  /// Callback function to receive button up/down events
  final KeyPress keyPress;

  /// The radius of the button corner ( 25% of height is good )
  /// Default = 0 for a rectangular button
  final double radius;

  /// Width of the button
  final double width;

  AnimatedButton(
      {Key key,
      this.boxShadows,
      this.centerWidget = const Text(
        'PRESS',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      this.color = Colors.deepPurpleAccent,
      this.gradient,
      this.height = 50,
      @required this.keyPress,
      this.radius = 0,
      this.width = 200})
      : assert(centerWidget != null),
        assert(gradient != null || color != null),
        assert(height > 0.0),
        assert(keyPress != null),
        assert(radius >= 0.0),
        assert(width > 0.0);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;
  LinearGradient _gradient;

  @override
  void initState() {
    super.initState();

    /// If no gradient was passed, create one with identical begin and end colors
    /// to create a solid button color.
    _gradient = widget.gradient ??
        LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            widget.color,
            widget.color,
          ],
        );
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
    widget.keyPress(AnimatedButtonPress.down);
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.keyPress(AnimatedButtonPress.up);
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: Transform.scale(
        scale: _scale,
        child: _animatedButtonUI,
      ),
    );
  }

  Widget get _animatedButtonUI => Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
          boxShadow: widget.boxShadows,
          gradient: _gradient,
        ),
        child: Center(
          child: widget.centerWidget,
        ),
      );
}

/// Example of box shadow that adds a 0.8-opacity black shadow
/*
BoxShadow(
              color: Color(0x80000000),
              blurRadius: 30.0,
              offset: Offset(0.0, 30.0),
            ),
 */
