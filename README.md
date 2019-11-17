# Contracting/Expanding Button

Button the contracts/expands on tap to give visual feedback on press

## A Flutter Widget

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

