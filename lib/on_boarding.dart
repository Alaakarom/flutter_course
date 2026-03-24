import 'package:flutter/material.dart';
import 'package:flutter_course/app_colors.dart';
import 'package:flutter_course/tasks_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<OnBoardingPage> pages = [
    OnBoardingPage(
      image: 'assets/images/image1.png',
      title:
          "Plan your tasks to do, that way you’ll stay organized and you won’t skip any",
    ),
    OnBoardingPage(
      image: 'assets/images/image2.png',
      title:
          "Make a full schedule for the whole week and stay organized and productive all days",
    ),
    OnBoardingPage(
      image: 'assets/images/image3.png',
      title: "create a team task, invite people and manage your work together",
    ),
    OnBoardingPage(
      image: 'assets/images/image4.png',
      title: "You informations are secure with us",
    ),
  ];

  int currentPage = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.white,
        child: Icon(currentPage == 3 ? Icons.check : Icons.arrow_forward),
        onPressed: () async {
          pageController.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          if (currentPage == 3) {
            SharedPreferences sh = await SharedPreferences.getInstance();
            sh.setBool('screen', true);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TasksScreen()),
            );
          }
        },
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topEnd,
            end: AlignmentDirectional.bottomStart,
            colors: [AppColors.primary, AppColors.secondary],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {});
                  currentPage = index;
                },
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Image.asset(pages[index].image, width: 411, height: 297),
                      SizedBox(height: 65),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                          pages[index].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Container(
                      height: 10,
                      width: currentPage == index ? 50 : 25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoardingPage {
  final String image;
  final String title;

  OnBoardingPage({required this.image, required this.title});
}
