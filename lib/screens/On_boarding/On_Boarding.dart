import 'package:flutter/material.dart';
import 'package:shop_app/Helper/cach.dart';
import 'package:shop_app/screens/Login/ShopLoginPage.dart';
import 'package:shop_app/shared/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({required this.image, required this.title, required this.body});
}

// ignore: must_be_immutable
class On_Boarding_View extends StatefulWidget {
  On_Boarding_View({Key? key}) : super(key: key);

  @override
  State<On_Boarding_View> createState() => _On_Boarding_ViewState();
}

class _On_Boarding_ViewState extends State<On_Boarding_View> {
  late PageController boardcontroller;
  void NavigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Widget),
      (Route<dynamic> route) => false);
  List<BoardingModel> boarding = [
    BoardingModel(
        image: "lib/assets/images/onboard3.jpg",
        title: "On Board 1 Title",
        body: "On Board 1 Body"),
    BoardingModel(
        image: "lib/assets/images/onboard2.jpg",
        title: "On Board 2 Title",
        body: "On Board 2 Body"),
    BoardingModel(
        image: "lib/assets/images/onboard1.jpg",
        title: "On Board 3 Title",
        body: "On Board 3 Body")
  ];
  bool islast = false;

  void submit() {
    CacheHelper.saveData(key: 'On_Boarding_View', value: true).then((value) {
      if (value!) {
        NavigateAndFinish(context, ShopLoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    boardcontroller = PageController();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            defaultTextButton(function: submit, text: "Skip")
            /*TextButton(
                onPressed: () {
                  NavigateAndFinish(context, ShopLoginPage());
                },
                child: Text(
                  "Skip",
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontFamily: "Jannah",
                      fontSize: 16),
                ))*/
          ],
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        islast = true;
                      });
                      // print("Last");
                    } else {
                      setState(() {
                        islast = false;
                      });
                      // print("Not Last");
                    }
                  },
                  controller: boardcontroller,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: ((context, index) =>
                      BuildOnBoardingItem(boarding[index])),
                  itemCount: boarding.length,
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  SmoothPageIndicator(
                      controller: boardcontroller,
                      count: boarding.length,
                      effect: ExpandingDotsEffect(
                          dotColor: Colors.grey,
                          dotHeight: 15,
                          dotWidth: 15,
                          activeDotColor: Colors.deepOrange,
                          expansionFactor: 4,
                          spacing: 5)),
                  Spacer(),
                  FloatingActionButton(
                    //elevation: 0,
                    backgroundColor: Colors.deepOrange,

                    onPressed: () {
                      if (islast == true) {
                        //navigateAndFinish(context, ShopLoginPage());
                        submit();
                      } else {
                        boardcontroller.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.white,
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget BuildOnBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('${model.image}'),
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 75,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontFamily: "Jannah",
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
                fontFamily: "Jannah", fontSize: 18, color: Colors.black),
          )
        ],
      );
}
