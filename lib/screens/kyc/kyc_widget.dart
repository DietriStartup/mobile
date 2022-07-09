import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietri/components/show_alert_dialog.dart';
import 'package:dietri/components/show_exception_dialog.dart';
import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/helper/enums.dart';
import 'package:dietri/screens/kyc/first_kyc_screen.dart';

import 'package:dietri/screens/kyc/fourth_kyc_screen.dart';
import 'package:dietri/screens/kyc/second_kyc_screen.dart';
import 'package:dietri/screens/kyc/third_kyc_screen.dart';
import 'package:dietri/services/auth.dart';
import 'package:dietri/services/database.dart';
import 'package:dietri/view_models/kyc_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KYCScreens extends StatefulWidget {
  const KYCScreens({
    Key? key,
    required this.model,
  }) : super(key: key);
  final KYCViewModel model;

  static Widget create(BuildContext context) {
    final db = Provider.of<Database>(context);
    final auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<KYCViewModel>(
        create: (_) => KYCViewModel(db: db, auth: auth),
        builder: (context, child) {
          return Consumer<KYCViewModel>(builder: (__, model, _) {
            return KYCScreens(model: model);
          });
        });
  }

  @override
  State<KYCScreens> createState() => _KYCScreensState();
}

class _KYCScreensState extends State<KYCScreens> {
  final PageController _pageController = PageController(initialPage: 0);
  final TextEditingController _editingController = TextEditingController();

  KYCViewModel get model => widget.model;

  void _updateUserGenderinDataBase()async{
    try {
      await model.updateUserParams(gender: model.gender);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(context, title: 'Something went wrong', exception: e);
    } catch (e) {
      showAlertDialog(context, title: 'Unknown Error', content: 'oops, something\'s not right', defaultActionText: 'OK');
    }
  }

  void _updateUserGoalsinDataBase()async{
    try {
      await model.updateUserParams(goals: model.goals);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(context, title: 'Something went wrong', exception: e);
    } catch (e) {
      showAlertDialog(context, title: 'Unknown Error', content: 'oops, something\'s not right', defaultActionText: 'OK');
    }
  }

  void _updateUserWeightinDataBase()async{
    try {
      await model.updateUserParams(weight: model.weight, weightString: _editingController.text.trim(), isKYCComplete: true);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(context, title: 'Something went wrong', exception: e);
    } catch (e) {
      showAlertDialog(context, title: 'Unknown Error', content: 'oops, something\'s not right', defaultActionText: 'OK');
    }
  }
  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < model.numPages; i++) {
      list.add(i == 0
          ? Container()
          : i == model.currentPage
              ? indicator(true)
              : indicator(false));
    }
    return list;
  }

  String getSubText(int page) {
    switch (page) {
      case 0:
        return '';
      case 1:
        return 'Let\'s get to know you!';
      case 2:
        return 'Interesting!';
      case 3:
        return 'Sweet!';
      default:
        return '';
    }
  }

  // The Single Dot
  Widget indicator(bool isCurrent) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      height: 15.0,
      width: 15.0,
      decoration: BoxDecoration(
        color: isCurrent ? kPrimaryColor : Colors.grey[300],
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: model.currentPage == 0 ? [] : _buildPageIndicator(),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(getSubText(model.currentPage),
                  style: Fonts.montserratFont(
                      color: kPrimaryColor,
                      size: 16,
                      fontWeight: FontWeight.normal))
            ],
          ),
        ),
        backgroundColor: kWhiteColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: height * 0.7,
                child: PageView(
                  physics: const ClampingScrollPhysics(),
                  onPageChanged: (page) {
                    model.updateCurrentPage(page);
                  },
                  controller: _pageController,
                  children: [
                    const FirstKYCScreen(),
                    SecondKYCScreen(
                        gender: model.gender,
                        onPressed: () => model.updateGender(Gender.male),
                        onPressed1: () => model.updateGender(Gender.female),
                        onPressed2: () => model.updateGender(Gender.others)),
                    ThirdKYCScreen(
                      goals: model.goals,
                      onPressed: () => model.updateGoals(Goals.gainweight),
                      onPressed1: () => model.updateGoals(Goals.maintainweight),
                      onPressed2: () => model.updateGoals(Goals.looseweight),
                    ),
                    FourthKYCScreen(
                        editingController: _editingController,
                        onPressed: () => model.updateWeight(Weight.st),
                        onPressed1: () => model.updateWeight(Weight.lb),
                        onPressed2: () => model.updateWeight(Weight.kg),
                        weight: model.weight),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          color: Colors.white,
          height: 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    model.currentPage == 0
                        ? Container()
                        : Text(
                            'This quiz helps make your Dietri journey easier and personalized',
                            textAlign: TextAlign.center,
                            style: Fonts.montserratFont(
                                color: kPrimaryColor,
                                size: 11,
                                fontWeight: FontWeight.normal)),
                    const SizedBox(
                      height: 10,
                    ),
                    getButtonForPage(model.currentPage),
                  ],
                )),
          ),
        ));
  }

  Widget getButtonForPage(int currentpage) {
    switch (currentpage) {
      case 0:
        return TextButton(
            onPressed: () {
              if (_pageController.hasClients) {
                _pageController.animateToPage(
                  model.currentPage + 1,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeIn,
                );
              }
            },
            style: ElevatedButton.styleFrom(
                primary: kPrimaryColor, minimumSize: const Size(150, 50)),
            child: Text('Continue',
                style: Fonts.montserratFont(
                    color: Colors.white,
                    size: 16,
                    fontWeight: FontWeight.normal)));
      case 1:
        return TextButton(
            onPressed: () {
              if (model.gender != null) {
                _updateUserGenderinDataBase();
                if (_pageController.hasClients) {
                  _pageController.animateToPage(
                    model.currentPage + 1,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeIn,
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
                primary: kPrimaryColor, minimumSize: const Size(150, 50)),
            child: Text('Next',
                style: Fonts.montserratFont(
                    color: Colors.white,
                    size: 16,
                    fontWeight: FontWeight.normal)));
      case 2:
        return TextButton(
            onPressed: () {
              if (model.goals != null) {
                _updateUserGoalsinDataBase();
                if (_pageController.hasClients) {
                  _pageController.animateToPage(
                    model.currentPage + 1,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeIn,
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
                primary: kPrimaryColor, minimumSize: const Size(150, 50)),
            child: Text('Next',
                style: Fonts.montserratFont(
                    color: Colors.white,
                    size: 16,
                    fontWeight: FontWeight.normal)));
      case 3:
        return TextButton(
            onPressed: () {
              _editingController.text.isNotEmpty ? _updateUserWeightinDataBase() : null;
              _editingController.clear();
              if (_pageController.hasClients) {
                _pageController.animateToPage(
                  model.currentPage + 1,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeIn,
                );
              }
            },
            style: ElevatedButton.styleFrom(
                primary: kPrimaryColor, minimumSize: const Size(150, 50)),
            child: Text('Next',
                style: Fonts.montserratFont(
                    color: Colors.white,
                    size: 16,
                    fontWeight: FontWeight.normal)));
      default:
        return const Text('');
    }
  }
}
