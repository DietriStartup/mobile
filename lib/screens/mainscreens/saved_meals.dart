import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietri/components/dietre_icons.dart';
import 'package:dietri/components/errorscreen.dart';
import 'package:dietri/components/food_card.dart';
import 'package:dietri/components/grid_view_item_builder.dart';
import 'package:dietri/components/show_exception_dialog.dart';
import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/helper/enums.dart';
import 'package:dietri/helper/user_utils.dart';
import 'package:dietri/models/food.dart';
import 'package:dietri/services/auth.dart';
import 'package:dietri/services/database.dart';
import 'package:dietri/view_models/savedmeals_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedMealsPage extends StatefulWidget {
  const SavedMealsPage({Key? key, required this.vm}) : super(key: key);
  final SavedMealsViewModel vm;

  static Widget create(BuildContext context) {
    final db = Provider.of<Database>(context, listen: false);
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<SavedMealsViewModel>(
      create: (_) => SavedMealsViewModel(db: db, auth: auth),
      child: Consumer<SavedMealsViewModel>(
        builder: (_, model, __) => SavedMealsPage(
          vm: model,
        ),
      ),
    );
  }

  @override
  State<SavedMealsPage> createState() => _SavedMealsPageState();
}

class _SavedMealsPageState extends State<SavedMealsPage> {
  final TextEditingController _controller = TextEditingController();

  SavedMealsViewModel get vm => widget.vm;

  @override
  void initState() {
    super.initState();
    vm.updateFoodList();
  }

  @override
  void dispose() {
    vm.closeStream();
    _controller.dispose();
    super.dispose();
  }

  _buildSearchResults() {
    vm.getFoodSearchResults();
    return vm.foodSuggestion.isEmpty
        ? const ErrorScreen(
            title: 'No results for that search..',
          )
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
            physics: const BouncingScrollPhysics(),
            itemCount: vm.foodSuggestion.length,
            itemBuilder: (context, index) {
              return FoodCard(
                  addNewMeal: () {},
                  saveMeal: () => vm.deleteSavedMeal(vm.foodSuggestion[index]),
                  isSavedMeal: true,
                  showMealPlan: () {
                    UserUtils.dietriModalBSheet(
                        context,
                        vm.foodSuggestion[index],
                        MediaQuery.of(context).size.height);
                  },
                  foodName: vm.foodSuggestion[index].foodName,
                  foodURL: vm.foodSuggestion[index].foodName);
            },
          );
  }

  void _addNewMeal(BuildContext context, Food food, String foodTypeString,
      FoodType foodType) async {
    try {
      await vm.addNewMeal(food, foodTypeString, foodType);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(context,
          title: 'Could\'nt add meal', exception: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxScrolled) => [
            SliverAppBar(
              floating: true,
              centerTitle: true,
              backgroundColor: Colors.white,
              title: Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 10),
                child: Text('Saved Meals',
                    style: Fonts.montserratFont(
                        color: Colors.black,
                        size: 24,
                        fontWeight: FontWeight.bold)),
              ),
              bottom: PreferredSize(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: TextField(
                      controller: _controller,
                      onChanged: (val) => vm.updateQuery(val),
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        suffixIcon: IconButton(
                            onPressed: () => vm.updateQuery(''),
                            icon: Icon(
                              vm.query.isNotEmpty
                                  ? Icons.close
                                  : Dietre.search_normal,
                              color: kPrimaryColor,
                            )),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  preferredSize: const Size.fromHeight(40)),
            )
          ],
          body: GestureDetector(
            onTap: () {
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 5,
                    child: vm.query.isNotEmpty
                        ? _buildSearchResults()
                        : StreamBuilder<List<Food?>>(
                            stream: vm.userSavedMealStream(),
                            builder: (context, snapshot) {
                              return GridViewItemsBuilder<Food>(
                                  snapshot: snapshot,
                                  crossAxisCount: 2,
                                  itemBuilder: (context, savedMeal) => FoodCard(
                                      addNewMeal: () async {
                                        final foodType =
                                            await _addNewMealPlanDialog(
                                                context, savedMeal);
                                        if (foodType != null) {
                                          _addNewMeal(
                                              context,
                                              savedMeal,
                                              UserUtils.getFoodTypeString(
                                                      foodType)
                                                  .toLowerCase(),
                                              foodType);
                                        }
                                      },
                                      saveMeal: () =>
                                          vm.deleteSavedMeal(savedMeal),
                                      isSavedMeal:
                                          savedMeal.isSavedMeal ?? false,
                                      showMealPlan: () {
                                        UserUtils.dietriModalBSheet(
                                            context,
                                            savedMeal,
                                            MediaQuery.of(context).size.height);
                                      },
                                      foodName: savedMeal.foodName,
                                      foodURL: savedMeal.foodURL),
                                  isReverse: false);
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<dynamic> _addNewMealPlanDialog(BuildContext context, Food food) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: kPrimaryAccentColor,
              child: SizedBox(
                //height: 300,
                width: 235,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            food.foodName,
                            style: Fonts.montserratFont(
                                color: Colors.black,
                                size: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Icon(Icons.close))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Choose as..',
                          style: Fonts.montserratFont(
                              color: Colors.black,
                              size: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            value: FoodType.breakfast,
                            groupValue: vm.foodType,
                            onChanged: (FoodType? val) {
                              setState(() {
                                vm.foodType = val!;
                              });
                            },
                            activeColor: kPrimaryColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Breakfast',
                            style: Fonts.montserratFont(
                                color: Colors.black,
                                size: 12,
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: FoodType.lunch,
                            groupValue: vm.foodType,
                            onChanged: (FoodType? val) {
                              setState(() {
                                vm.foodType = val!;
                              });
                            },
                            activeColor: kPrimaryColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Lunch',
                            style: Fonts.montserratFont(
                                color: Colors.black,
                                size: 12,
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: FoodType.dinner,
                            groupValue: vm.foodType,
                            onChanged: (FoodType? val) {
                              setState(() {
                                vm.foodType = val!;
                              });
                            },
                            activeColor: kPrimaryColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Dinner',
                            style: Fonts.montserratFont(
                                color: Colors.black,
                                size: 12,
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                      Center(
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(vm.foodType);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                                minimumSize: const Size(50, 30)),
                            child: Text('Add',
                                style: Fonts.montserratFont(
                                    color: Colors.white,
                                    size: 16,
                                    fontWeight: FontWeight.normal))),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}
