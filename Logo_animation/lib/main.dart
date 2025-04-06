import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logo Aniamtions',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const FadeInPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FadeInPage extends StatelessWidget {
  const FadeInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'animation Logo Examples',
          style: TextStyle(backgroundColor: (Colors.teal), color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: const [
            Text(
              "Implicit Animation",
              style: TextStyle(
                fontSize: 20,
                color: Colors.amber,
                backgroundColor: Colors.blue,
              ),
            ),
            ImplicitFadeInLogo(),

            Text(
              "Explicit Animation",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blueAccent,
                backgroundColor: Colors.amberAccent,
              ),
            ),
            ExplicitFadeInLogo(),
          ],
        ),
      ),
    );
  }
}

//ImplicitFadeInLogo

class ImplicitFadeInLogo extends StatefulWidget {
  const ImplicitFadeInLogo({super.key});

  @override
  State<ImplicitFadeInLogo> createState() => _ImplicitFadeInLogoState();
}

class _ImplicitFadeInLogoState extends State<ImplicitFadeInLogo> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(seconds: 2),
        curve: Curves.easeIn,
        height: _visible ? 100 : 0,
        width: _visible ? 100 : 0,
        child:
            _visible
                ? const FlutterLogo()
                : const SizedBox(), // Prevents layout overflow
      ),
    );
  }
}

// ---------------------------
// Explicit Animation using AnimationController
// ---------------------------

class ExplicitFadeInLogo extends StatefulWidget {
  const ExplicitFadeInLogo({super.key});

  @override
  State<ExplicitFadeInLogo> createState() => _ExplicitFadeInLogoState();
}

class _ExplicitFadeInLogoState extends State<ExplicitFadeInLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _opacityAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnim,
      child: const FlutterLogo(size: 100),
    );
  }
}
