// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:p4all/shared/components/components.dart';
import 'package:p4all/shared/network/local/cache_helper.dart';
import 'package:p4all/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login/shop_login_screen.dart';

class BoardingModel
{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
});
}

class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding=[
    BoardingModel(
        title: 'On Board 1 Title',
        image: 'assets/images/onboard_1.png',
        body:' On Board 1 Body',
    ),
    BoardingModel(
      title: 'On Board 2 Title',
      image: 'assets/images/onboard_1.png',
      body:' On Board 2 Body',
    ),
    BoardingModel(
      title: 'On Board 3 Title',
      image: 'assets/images/onboard_1.png',
      body:' On Board 3 Body',
    ),
  ];

  var boardController=PageController();
  bool isLast=false;
void submit()
{
  CacheHelper.putData(key: 'onBoarding', value: false).then((value) {
    setState(() {
      navigateAndFinish(context, ShopLoginScreen());
    });
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: () =>submit(), child: Text('SKIP',style: TextStyle(fontWeight: FontWeight.bold),)),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                itemCount: 3,
                controller: boardController,
                onPageChanged: (index){
                  if (index==boarding.length-1)
                    {
                      isLast=true;
                    }
                  else
                    {
                      isLast=false;
                    }

                } ,
              ),
            ),
            SizedBox(height: 40.0,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,  // PageController
                    count:  boarding.length,
                    effect:  ExpandingDotsEffect(
                        activeDotColor:defaultColor,
                        expansionFactor: 4,
                      spacing: 5.0,

                    ),  // your preferred effect
                    onDotClicked: (index){

                    }

                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if (isLast)
                      {
                        submit();

                      }
                    else
                    boardController.nextPage(duration: Duration(milliseconds: 750), curve: Curves.fastLinearToSlowEaseIn);

                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                  ),


                  child: Icon(Icons.arrow_forward_ios),

                ),
              ],
            ),

          ],
        ),
      ),

    );
  }




  Widget buildBoardingItem(BoardingModel item)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image:AssetImage(item.image),
        ),
      ),
      SizedBox(height: 30,),
      Text(
        '${item.title}',
        style: TextStyle(
          fontSize: 24.0,

        ),
      ),
      SizedBox(height: 30,),
      Text(
        '${item.body}',
        style: TextStyle(
          fontSize: 14.0,

        ),
      ),
    ],
  );
}
