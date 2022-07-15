import 'dart:async';

import 'package:dietri/components/dietre_icons.dart';
import 'package:dietri/components/empty_content.dart';
import 'package:dietri/components/errorscreen.dart';
import 'package:dietri/components/food_card.dart';
import 'package:dietri/components/grid_view_item_builder.dart';
import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:dietri/helper/user_utils.dart';
import 'package:dietri/models/food.dart';
import 'package:dietri/services/auth.dart';
import 'package:dietri/services/database.dart';
import 'package:dietri/view_models/explore_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedMealsPage extends StatefulWidget {
  const SavedMealsPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    final db = Provider.of<Database>(context, listen: false);
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<SavedMealsViewModel>(
      create: (_) => SavedMealsViewModel(db: db, auth: auth),
      child: const SavedMealsPage(),
    );
  }

  @override
  State<SavedMealsPage> createState() => _SavedMealsPageState();
}

class _SavedMealsPageState extends State<SavedMealsPage> {
  List<Food> foodList = [];
  String query = "";
  final TextEditingController _controller = TextEditingController();
  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();
    final db = Provider.of<Database>(context, listen: false);
    final auth = Provider.of<AuthBase>(context, listen: false);

    _streamSubscription =
        db.userSavedMealStream(auth.currentUser!.uid).listen((event) {
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

  _buildSearchResults(String query) {
    List<Food> foodSuggestion = [];
    if (query.isNotEmpty) {
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
                  saveMeal: () {
                    _deleteSavedMeal(
                        context,
                        foodSuggestion[index].isSavedMeal!,
                        foodSuggestion[index]);
                  },
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
    FocusScopeNode currentFocus = FocusScope.of(context);
    final auth = Provider.of<AuthBase>(context, listen: false);
    final db = Provider.of<Database>(context, listen: false);
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
                  Expanded(
                    flex: 5,
                    child: query.isNotEmpty
                        ? _buildSearchResults(query)
                        : StreamBuilder<List<Food?>>(
                            stream:
                                db.userSavedMealStream(auth.currentUser!.uid),
                            builder: (context, snapshot) {
                              return GridViewItemsBuilder<Food>(
                                  snapshot: snapshot,
                                  crossAxisCount: 2,
                                  itemBuilder: (context, savedMeal) => FoodCard(
                                      addNewMeal: () {},
                                      saveMeal: () {
                                        _deleteSavedMeal(
                                            context,
                                            savedMeal.isSavedMeal ?? false,
                                            savedMeal);
                                      },
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

  void _deleteSavedMeal(
      BuildContext context, bool isSavedMeal, Food food) async {
    final db = Provider.of<Database>(context, listen: false);
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await db.deleteSavedMeal(food.foodId, auth.currentUser!.uid);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
