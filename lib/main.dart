import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MyHomePage()
      )
    );
  }
}

class MyHomePage extends StatefulWidget {

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _controller = false;

  void _handleChange(bool n) {
    setState(() {
      _controller = n;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Container(
      color: Colors.grey[100],
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              child: BannerNav(
                active: _controller,
                onChanged: _handleChange,
              )
            ),
            flex: _controller ? 6 : 10
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 35, right: 35),
              child: _controller ? ListOfSongs(_controller) : null,
            ),
            flex: _controller ? 5 : 0
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 35, right: 35, bottom: 15),
              child: Buttons(
                active: _controller,
                onChanged: _handleChange,
              ),
            ),
            flex: _controller ? 1 : 2
          )
        ],
      )
    );
  }
}

class BannerNav extends StatefulWidget {
  BannerNav({Key key, this.active: true, @required this.onChanged}) : super(key : key);
  final bool active;
  final ValueChanged<bool> onChanged;
  _BannerNav createState() => _BannerNav();
}

class _BannerNav extends State<BannerNav> {
  final double radius = 200;

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 20),
            child: Icon(
              Icons.arrow_back,
              color: widget.active ? Colors.red : Colors.black
            )
          ),
          flex: 2
        ),
        Expanded(
          child: Column(
            children: [
              AnimatedContainer(
                width: double.maxFinite,
                height: widget.active ? 360 : 530,
                duration: Duration(milliseconds: 800),
                curve: Curves.easeIn,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(this.radius),
                    bottomRight: Radius.circular(this.radius)
                  ),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey[400],
                      offset: new Offset(0.0, 8.0),
                      blurRadius: 18,
                      spreadRadius: 2
                    )
                  ],
                  color: Colors.red,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(this.radius),
                    bottomRight: Radius.circular(this.radius)
                  ),
                  child: Image(
                    image : AssetImage('assets/banner.jpg'),
                    fit: BoxFit.cover
                  )
                )
              ),
              widget.active ? SizedBox(height: 0) : MusicSlider()
            ],
          ),
          flex: 10
        ),
        Expanded(
          child:  Container(
            margin: EdgeInsets.only(top: 20),
            child: Icon(
              Icons.menu
            )
          ),
          flex: 2, 
        )
      ],
    );
  }
}

class CustomSlider extends SliderComponentShape {
  final double inner = 6;
  final double outer = 10;

  Size getPreferredSize(bool isEnables, bool isDiscrete) {
    return Size.fromRadius(outer);
  }

  void paint(
    PaintingContext context,
    Offset center, {
      Animation<double> activationAnimation,
      Animation<double> enableAnimation,
      bool isDiscrete,
      TextPainter labelPainter,
      RenderBox parentBox,
      SliderThemeData sliderTheme,
      TextDirection textDirection,
      double textScaleFactor,
      Size sizeWithOverflow,
      double value
    }
  ) {
    final Canvas canvas = context.canvas;
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    final paintTwo = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    

    canvas.drawCircle(center, outer * 0.9, paint);
    canvas.drawCircle(center, inner * 0.9, paintTwo);
  }
}

class MusicSlider extends StatefulWidget {
  _MusicSlider createState() => _MusicSlider();
}

class _MusicSlider extends State<MusicSlider> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3)
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  double _currentVal = 00;

  Widget build(BuildContext context) {
    _controller.forward();
    return FadeTransition(
      opacity: _animation,
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Text(
              "00:00", 
              style: TextStyle(
                letterSpacing: 1,
                fontWeight: FontWeight.w600
              )
            ),
          ],
        )
      )
    );
  }
}


class ListOfSongs extends StatelessWidget {
  bool control;
  ListOfSongs (bool active) {
    control = active;
  }
  Widget build(BuildContext contex) {
    return AnimatedContainer(
      height: control ? 90: 0,
      duration: Duration(milliseconds: 900),
      curve: Curves.easeIn,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Intro III"),
              Text("4:29")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Outcast"),
              Text("9:01")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Dreams"),
              Text("3:56")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("The Office"),
              Text("5:34")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Friends"),
              Text("4:18")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Brooklyn 99"),
              Text("14:29")
            ],
          ),
          Row (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.expand_more,
                color: Colors.grey
              )
            ],
          )
        ],
      )
    );
  }
}

class Buttons extends StatefulWidget {
  final bool active;
  final ValueChanged<bool> onChanged;
  Buttons({Key key, this.active: false, @required this.onChanged, height}) : super(key : key);
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Buttons> {
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(Icons.shuffle),
          onPressed: () {},
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 160,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  color: widget.active ? null : Colors.white
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.fast_rewind),
                    onPressed: () {
                      print("pressed");
                    },
                  ),
                  SizedBox(
                    width: 5
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[350],
                          offset: new Offset(0.0, 10.0),
                          blurRadius: 15,
                          spreadRadius: 1
                        )
                      ]
                    ),
                    child: IconButton(
                      iconSize: widget.active ? 36 : 50,
                      icon: Icon(widget.active ? Icons.play_circle_fill : Icons.pause_circle_filled),
                      onPressed: () {
                        widget.onChanged(!widget.active);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5
                  ),
                  IconButton(
                    icon : Icon(Icons.fast_forward),
                    onPressed: () {},
                  )
                ],
              ),
            ],
          ),
          flex: 7
        ),
        IconButton(
          icon: Icon(Icons.repeat),
          onPressed: () {},
        )
      ],
    );
  }
}