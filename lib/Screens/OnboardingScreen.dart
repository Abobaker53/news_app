import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/Screens/HomePage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<Map<String, String>> images = [
    {"image": "assets/Images/onbording1.png"},
    {"image": "assets/Images/onbording2.png"},
    {"image": "assets/Images/onbording3.png"},
  ];
  PageController controller = PageController();
  int currentpage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: controller,
        itemCount: images.length,
        onPageChanged: (index) {
          setState(() {
            currentpage = index;
          });
        },
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  images[index]["image"]!,
                  width: double.infinity,
                  height: 584,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Lorem Ipsum is simply\ndummy",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color(0xffE4E6EB),
                        ),
                      ),
                      Text(
                        "Lorem Ipsum is simply dummy text of\nthe printing and typesetting industry.",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xffB0B3B8),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      SmoothPageIndicator(
                        controller: controller,
                        count: images.length,
                        effect: WormEffect(
                          dotHeight: 10,
                          dotWidth: 10,
                          activeDotColor: Color(0xff1877F2),
                          dotColor: Color(0xffA0A3BD),
                        ),
                      ),
                      Spacer(),
                      if (currentpage > 0)
                        TextButton(
                          onPressed: () {
                            controller.previousPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Text("Back",style:TextStyle(color: Color(0xffB0B3B8)) ,),
                        ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(6),
                          ),
                          backgroundColor: Color(0xff1877F2),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if (currentpage < images.length - 1) {
                            controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                            );
                          }
                        },

                        child: Text(
                          currentpage == images.length - 1 ? "Get Started" : "Next",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
