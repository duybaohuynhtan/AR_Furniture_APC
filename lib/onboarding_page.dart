import 'package:flutter/material.dart';

import 'auth_gate.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: OnboardingPage(
        pages: [
          OnboardingPageModel(
            title: 'Welcome to AR Furniture!',
            description:
                'Step into a virtual world of furniture. Explore and design your space like never before.',
            icon: Icons.chair_outlined,
            bgColor: Colors.indigo,
          ),
          OnboardingPageModel(
            title: 'Easy AR Integration',
            description:
                'Choose, scan, place. Simple steps to bring virtual furniture into your real world.',
            icon: Icons.view_in_ar_outlined,
            bgColor: const Color(0xff1eb090),
          ),
          OnboardingPageModel(
            title: 'Discover Your Style',
            description:
                'Explore our catalog. Find furniture that suits your style perfectly.',
            icon: Icons.lightbulb_outline,
            bgColor: const Color(0xfffeae4f),
          ),
          OnboardingPageModel(
            title: 'Bring Your Vision to Life',
            description:
                'Place furniture, find your style. Start transforming your space now!',
            icon: Icons.home_outlined,
            bgColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}

class OnboardingPageModel {
  final String title;
  final String description;
  final IconData icon;
  final Color bgColor;
  final Color textColor;

  OnboardingPageModel(
      {required this.title,
      required this.description,
      required this.icon,
      this.bgColor = Colors.blue,
      this.textColor = Colors.white});
}

class OnboardingPage extends StatefulWidget {
  final List<OnboardingPageModel> pages;

  const OnboardingPage({Key? key, required this.pages}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: widget.pages[_currentPage].bgColor,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.pages.length,
                  onPageChanged: (idx) {
                    setState(() {
                      _currentPage = idx;
                    });
                  },
                  itemBuilder: (context, idx) {
                    final item = widget.pages[idx];
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(30.0),
                          margin: const EdgeInsets.fromLTRB(50, 100, 50, 100),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: item.textColor,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 20.0,
                                color: Colors.black.withOpacity(0.5),
                                offset: const Offset(10, 25),
                              ),
                            ],
                          ),
                          child: Icon(
                            item.icon,
                            size: 200,
                            color: item.bgColor,
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(item.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: item.textColor,
                                            fontSize: 25)),
                              ),
                              Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 280),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 8.0),
                                child: Text(item.description,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: item.textColor,
                                            fontSize: 15)),
                              )
                            ]))
                      ],
                    );
                  },
                ),
              ),

              // Current page indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.pages
                    .map((item) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: _currentPage == widget.pages.indexOf(item)
                              ? 20
                              : 4,
                          height: 4,
                          margin: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                        ))
                    .toList(),
              ),

              // Bottom buttons
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MaterialApp(
                                title: 'AR Furniture App',
                                debugShowCheckedModeBanner: false,
                                theme: ThemeData(brightness: Brightness.dark),
                                home: const AuthGate(),
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "Skip",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                    TextButton(
                      onPressed: () {
                        if (_currentPage == widget.pages.length - 1) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MaterialApp(
                                title: 'AR Furniture App',
                                debugShowCheckedModeBanner: false,
                                theme: ThemeData(brightness: Brightness.dark),
                                home: const AuthGate(),
                              ),
                            ),
                          );
                        } else {
                          _pageController.animateToPage(_currentPage + 1,
                              curve: Curves.easeInOutCubic,
                              duration: const Duration(milliseconds: 250));
                        }
                      },
                      child: Text(
                        _currentPage == widget.pages.length - 1
                            ? "Finish"
                            : "Next",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
