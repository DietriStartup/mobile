import 'dart:async';

import 'package:dietri/components/dietre_icons.dart';
import 'package:dietri/components/errorscreen.dart';
import 'package:dietri/components/food_card.dart';
import 'package:dietri/components/grid_view_item_builder.dart';
import 'package:dietri/components/input_field.dart';
import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/helper/enums.dart';
import 'package:dietri/helper/user_utils.dart';
import 'package:dietri/models/food.dart';
import 'package:dietri/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<Food> foodList = [];
  String query = "";
  String filterQuery = '';
  final TextEditingController _controller = TextEditingController();
  StreamSubscription? _streamSubscription;

  List<Widget> _getfoodProcedure(List procedure) {
    var textWidgets = <Text>[];
    for (var i = 0; i < procedure.length; i++) {
      textWidgets.add(Text('step${i + 1} : ${procedure[i]}'));
    }
    return textWidgets;
  }

  FoodType? _foodType;

  String _getFoodTypeString(FoodType foodType) {
    switch (foodType) {
      case FoodType.breakfast:
        return 'Breakfast';
      case FoodType.lunch:
        return 'Lunch';
      case FoodType.dinner:
        return 'Dinner';
      default:
        return '';
    }
  }

  @override
  void initState() {
    super.initState();
    final db = Provider.of<Database>(context, listen: false);

    _streamSubscription = db.mealPlanStream().listen((event) {
      setState(() {
        foodList = event;
      });
    });
  }

  @override
  void dispose() {
    _streamSubscription!.cancel();
    _controller.dispose();
    super.dispose();
  }

  _buildSearchResults(String query, String filterQuery) {
    List<Food> foodSuggestion = [];
    if (query.isNotEmpty && filterQuery.isNotEmpty) {
      foodSuggestion = foodList
          .where((element) {
            String _getFoodType =
                _getFoodTypeString(UserUtils.intToFoodType(element.foodType)!)
                    .toLowerCase();
            String _filterQuery = filterQuery.toLowerCase();
            bool matchesFilter = _getFoodType.contains(_filterQuery);
            return matchesFilter;
          })
          .toList()
          .where((element) {
            String _getFoodName = element.foodName.toLowerCase();
            String _query = query.toLowerCase();
            bool matches = _getFoodName.contains(_query);
            return matches;
          })
          .toList();
    } else if (filterQuery.isNotEmpty) {
      foodSuggestion = foodList.where((element) {
        String _getFoodType =
            _getFoodTypeString(UserUtils.intToFoodType(element.foodType)!)
                .toLowerCase();
        String _filterQuery = filterQuery.toLowerCase();
        bool matchesFilter = _getFoodType.contains(_filterQuery);
        return matchesFilter;
      }).toList();
    } else if (query.isNotEmpty) {
      foodSuggestion = foodList.where((element) {
        String _getFoodName = element.foodName.toLowerCase();
        String _query = query.toLowerCase();
        bool matches = _getFoodName.contains(_query);
        return matches;
      }).toList();
    } else {
      foodSuggestion = <Food>[];
    }

    return foodSuggestion.isEmpty
        ? const ErrorScreen(
            title: 'No results for that search..',
          )
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
            physics: const BouncingScrollPhysics(),
            itemCount: foodSuggestion.length,
            itemBuilder: (context, index) {
              return FoodCard(
                  addNewMeal: () {},
                  saveMeal: () {},
                  isSavedMeal: true,
                  showMealPlan: () {
                    UserUtils.dietriModalBSheet(context, foodSuggestion[index],
                        MediaQuery.of(context).size.height);
                  },
                  foodName: foodSuggestion[index].foodName,
                  foodURL: foodSuggestion[index].foodName);
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context);
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
                    elevation: 0,
                    title: Text('Explore',
                        style: Fonts.montserratFont(
                            color: kPrimaryColor,
                            size: 18,
                            fontWeight: FontWeight.w500)),
                    bottom: PreferredSize(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: TextField(
                            controller: _controller,
                            onChanged: (val) {
                              setState(() {
                                query = val;
                                //filterQuery = '';
                              });
                            },
                            cursorColor: kPrimaryColor,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    if (query.isNotEmpty) {
                                      setState(() {
                                        query = '';
                                      });
                                      _controller.clear();
                                    }
                                  },
                                  icon: Icon(
                                    query.isNotEmpty
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
                    filterQuery.isNotEmpty
                        ? _filterQueryContainer()
                        : TextButton(
                            onPressed: () async {
                              final foodType = await _filterDialog(context);
                              if (foodType != false || foodType != null) {
                                setState(() {
                                  filterQuery = _getFoodTypeString(foodType!);
                                });
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
                    Expanded(
                      flex: 5,
                      child: query.isNotEmpty || filterQuery.isNotEmpty
                          ? _buildSearchResults(query, filterQuery)
                          : StreamBuilder<List<Food>>(
                              stream: db.mealPlanStream(),
                              builder: (context, snapshot) {
                                return GridViewItemsBuilder<Food>(
                                    snapshot: snapshot,
                                    itemBuilder: (context, food) => FoodCard(
                                        addNewMeal: () {},
                                        saveMeal: () {},
                                        isSavedMeal: true,
                                        showMealPlan: () {
                                          UserUtils.dietriModalBSheet(
                                              context,
                                              food,
                                              MediaQuery.of(context)
                                                  .size
                                                  .height);
                                        },
                                        foodName: food.foodName,
                                        foodURL: food.foodURL),
                                    isReverse: false);
                              },
                            ),
                    ),
                  ],
                ),
              ),
            )));
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
                            groupValue: _foodType,
                            onChanged: (FoodType? val) {
                              setState(() {
                                _foodType = val!;
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
                            groupValue: _foodType,
                            onChanged: (FoodType? val) {
                              setState(() {
                                _foodType = val!;
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
                            groupValue: _foodType,
                            onChanged: (FoodType? val) {
                              setState(() {
                                _foodType = val!;
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
                              Navigator.of(context).pop(_foodType);
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

  Container _filterQueryContainer() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: kPrimaryAccentColor, borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              filterQuery,
              style: Fonts.montserratFont(
                  color: Colors.black, size: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                setState(() {
                  filterQuery = '';
                  _foodType = null;
                });
              },
              child: const Icon(Icons.close, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
