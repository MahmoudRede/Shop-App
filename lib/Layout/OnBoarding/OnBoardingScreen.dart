import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Module/LoginScreen/LoginScreen.dart';
import 'package:shop_app/Shared/Companent/companents.dart';
import 'package:shop_app/Shared/Network/local/cacheHelper.dart';
import 'package:shop_app/Shared/Style/colors.dart';
import 'package:shop_app/Model/BoardingModel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();
  bool isLast = false;

  List<BoardingModel> boarding = [
    BoardingModel(
        title: 'Salla App',
        body: 'Provide Many Products , Categories and many attributes.',
        image: "assets/images/store.png",
    ),
    BoardingModel(
      title: 'Buy From App',
      body: 'App Allow to Make Order And Update Data',
      image: "assets/images/online-shopping.png",
    ),
    BoardingModel(
      title: 'E-Commerce',
      body: 'TThis App don\'t consume time , use and support by many attributes',
      image: "assets/images/sale.png",
    ),
  ];

  void submit ()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value == true)
        {
          navigateAndRemove(context: context, widget: LoginScreen());
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [

          IconButton(
              onPressed: submit,
              icon: CircleAvatar(
                radius: 30,
                child: Icon(
                  Icons.skip_next,size: 20,
                  ),
              ),
              ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (index){
                  if(index == boarding.length - 1)
                  {
                    setState(() {
                      isLast = true;
                    });
                  }else
                    {
                      setState(() {
                        isLast = false;
                      });
                    }
                },
                itemBuilder: (context, index) => pageViewItemBuilder(boarding[index]),
                itemCount: 3,
                controller: pageController,
              ),
            ),
            SizedBox(
              height: 45.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    expansionFactor: 4,
                    spacing: 5.0,
                  ),
                  count: boarding.length,
                ),
                Spacer(),
                isLast==true?
                FloatingActionButton.extended(
                  onPressed: (){
                    if(isLast == true)
                      {
                        submit();
                      }else
                        {
                          pageController.nextPage(
                            duration: Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        }

                  },
                  icon: Icon(
                        Icons.login,
                        color: Colors.white,
                        ),
                  label: Text('Start')
                ):
                FloatingActionButton.extended(
                  onPressed: (){
                    if(isLast == true)
                    {
                      submit();
                    }else
                    {
                      pageController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }

                  },
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      ),
                  label: Text('Next')
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


