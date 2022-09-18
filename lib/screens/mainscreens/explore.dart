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
import 'package:dietri/models/saved_meal_model.dart';
import 'package:dietri/services/auth.dart';
import 'package:dietri/services/database.dart';
import 'package:dietri/view_models/explore_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key, required this.vm}) : super(key: key);
  final ExploreViewModel vm;

  static Widget create(BuildContext context) {
    final db = Provider.of<Database>(context, listen: false);
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ExploreViewModel>(
      create: (_) => ExploreViewModel(db: db, auth: auth),
      child: Consumer<ExploreViewModel>(
        builder: (_, model, __) => ExplorePage(
          vm: model,
        ),
      ),
    );
  }

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final TextEditingController _controller = TextEditingController();

  ExploreViewModel get vm => widget.vm;

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
                  saveMeal: () {},
                  isSavedMeal: vm.foodSuggestion[index].isSavedMeal ?? false,
                  showMealPlan: () {
                    UserUtils.dietriModalBSheet(
                        context,
                        vm.foodSuggestion[index].food,
                        MediaQuery.of(context).size.height);
                  },
                  foodName: vm.foodSuggestion[index].food.foodName,
                  foodURL: vm.foodSuggestion[index].food.foodName);
            },
          );
  }

  void _toggleSavedMeal(
      BuildContext context, bool isSavedMeal, Food food) async {
    try {
      await vm.toggleSavedMeal(food, isSavedMeal);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(context,
          title: 'Could\'nt save meal', exception: e);
    }
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
        body: SafeArea(
          child: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxScrolled) => [
                    SliverAppBar(
                      floating: true,
                      centerTitle: true,
                      backgroundColor: Colors.white,
                      elevation: 0,
                      title: Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 10),
                        child: Text('Explore',
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
                                    onPressed: () {
                                      if (vm.query.isNotEmpty) {
                                        vm.updateQuery('');
                                        _controller.clear();
                                      }
                                    },
                                    icon: Icon(
                                      vm.query.isNotEmpty
                                          ? Icons.close
                                          : Dietre.search_normal,
                                      color: kPrimaryColor,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: kPrimaryColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: kPrimaryColor,
                                  ),
                                ),
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
                      vm.filterQuery.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: _filterQueryContainer(),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: TextButton(
                                  onPressed: () async {
                                    final foodType =
                                        await _filterDialog(context);
                                    if (foodType != null) {
                                      vm.updateFilterQuery(
                                          UserUtils.getFoodTypeString(
                                              foodType!));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: kPrimaryAccentColor,
                                      minimumSize: const Size(50, 30)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.filter_alt_outlined,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(width: 10),
                                      Text('Filters',
                                          style: Fonts.montserratFont(
                                              color: Colors.black,
                                              size: 14,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  )),
                            ),
                      Expanded(
                        flex: 5,
                        child: vm.query.isNotEmpty || vm.filterQuery.isNotEmpty
                            ? _buildSearchResults()
                            : StreamBuilder<List<SavedMeal?>>(
                                stream: vm.exploreMealsStream(),
                                builder: (context, snapshot) {
                                  return GridViewItemsBuilder<SavedMeal>(
                                      snapshot: snapshot,
                                      crossAxisCount: 2,
                                      itemBuilder: (context, savedMeal) =>
                                          FoodCard(
                                              addNewMeal: () async {
                                                final foodType =
                                                    await _addNewMealPlanDialog(
                                                        context,
                                                        savedMeal.food);
                                                if (foodType != null) {
                                                  _addNewMeal(
                                                      context,
                                                      savedMeal.food,
                                                      UserUtils
                                                              .getFoodTypeString(
                                                                  foodType)
                                                          .toLowerCase(),
                                                      foodType);
                                                }
                                              },
                                              saveMeal: () {
                                                _toggleSavedMeal(
                                                    context,
                                                    savedMeal.isSavedMeal ??
                                                        false,
                                                    savedMeal.food);
                                              },
                                              isSavedMeal:
                                                  savedMeal.isSavedMeal ??
                                                      false,
                                              showMealPlan: () {
                                                UserUtils.dietriModalBSheet(
                                                    context,
                                                    savedMeal.food,
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height);
                                              },
                                              foodName: savedMeal.food.foodName,
                                              foodURL: savedMeal.food.foodURL),
                                      isReverse: false);
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }

  Future<dynamic> _filterDialog(BuildContext context) {
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
                            'Filters',
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
                          'Meal',
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
                            onChanged: (FoodType? val) => setState(
                              () {
                                vm.foodType = val;
                              },
                            ),
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
                            onChanged: (FoodType? val) => setState(
                              () {
                                vm.foodType = val;
                              },
                            ),
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
                            onChanged: (FoodType? val) => setState(
                              () {
                                vm.foodType = val;
                              },
                            ),
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
                                primary: kPrimaryColor,
                                minimumSize: const Size(50, 30)),
                            child: Text('Save',
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
                            onChanged: (FoodType? val) => setState(
                              () {
                                vm.foodType = val;
                              },
                            ),
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
                            onChanged: (FoodType? val) => setState(
                              () {
                                vm.foodType = val;
                              },
                            ),
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
                            onChanged: (FoodType? val) => setState(
                              () {
                                vm.foodType = val;
                              },
                            ),
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
                                primary: kPrimaryColor,
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

  Container _filterQueryContainer() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: kPrimaryAccentColor, borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 3.0, left: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              vm.filterQuery,
              style: Fonts.montserratFont(
                  color: Colors.black, size: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () => vm.updateWith(filterQuery: '', foodType: null),
              child: const Icon(Icons.close, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
