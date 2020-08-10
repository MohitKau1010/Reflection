import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:reflection/styles/color.dart';
import 'package:reflection/ui/home_screen.dart';
import 'package:reflection/utils/navigater_helper.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int currentIndexPage;
  int pageLength;

  ///control page view
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void initState() {
    currentIndexPage = 0;
    pageLength = 3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///
    return Scaffold(
        body: Stack(
      children: <Widget>[
        PageView(
          controller: pageController,
          children: <Widget>[
            WelcomeScreen1(screenIndex: 1),
            WelcomeScreen1(screenIndex: 2),
            WelcomeScreen1(screenIndex: 3),
          ],
          onPageChanged: (value) {
            setState(() => currentIndexPage = value);
          },
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,
          top: MediaQuery.of(context).size.height * 0.91, // * 0.7
          // left: MediaQuery.of(context).size.width * 0.35,
          child: Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.10,
            ), //MediaQuery.of(context).size.width * 0.38
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  DotsIndicator(
                    dotsCount: pageLength,
                    position: currentIndexPage.toDouble(),
                    decorator: DotsDecorator(
                      size: const Size.square(12.0),
                      activeSize: const Size(18.0, 12.0),
                      color: Colors.grey, // Inactive color
                      activeColor: hexToColor("#ffc0cb"),
                    ),
                  ),

                  new GestureDetector(
                    onTap: () {
                      onNextButtonTap(currentIndexPage + 1);
                    },
                    child: Container(
                      width: 200,
                      height: 80,
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                          color: hexToColor("#ffc0cb"),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                          border: Border.all(
                              width: 3, color: hexToColor("#ffc0cb"), style: BorderStyle.solid)),
                      child: Center(
                          child: Text(
                        (currentIndexPage == 2) ? "Start" : "Next",
                        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }

  onNextButtonTap(int index) {
    if (index == 3) {
      ///_skipClick
      ///set pref isfirsttime false
      NavigationHelper.removeAll(context, HomeScreen());
    }
    setState(() {
      pageController.jumpToPage(index);
    });
  }
}

class WelcomeScreen1 extends StatelessWidget {
  final int screenIndex;

  WelcomeScreen1({Key key, @required this.screenIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _skipClick() {
      ///set pref isfirsttime false
      NavigationHelper.removeAll(context, HomeScreen());
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ///top margin..
                  SizedBox(
                    height: 25,
                  ),

                  ///Skip row..
                  Padding(
                    padding: EdgeInsets.only(top: 19.0, right: 19.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: _skipClick,
                            child: Text(
                              "Skip",
                              style: TextStyle(
                                fontSize: 18.0,
                                decoration: TextDecoration.underline,
                              ),
                            )),
                      ],
                    ),
                  ),


                  ///Image row..
                  _appLogo(context),

                  SizedBox(
                    height: 30,
                  ),

                  ///text title
                  Text(
                    "Lets Reflect the maditate",
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  ///text subtitle
                  Text(
                    "Mindfulness allow us to live life fully.\n fully aware, filly awake, fully alive.",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //region AppLogo
  Widget _appLogo(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Opacity(
        opacity: 1.0,
        child: Padding(
          padding: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
          child: Image.asset('assets/images/intro_logo.png'),
        ),
      ),
    );
  }
//endregion

}
