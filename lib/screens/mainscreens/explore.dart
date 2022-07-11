import 'package:dietri/components/dietre_icons.dart';
import 'package:dietri/components/food_card.dart';
import 'package:dietri/components/input_field.dart';
import 'package:dietri/constants/colors.dart';
import 'package:dietri/constants/fonts.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
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
                            cursorColor: kPrimaryColor,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Dietre.search_normal)),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: kPrimaryColor,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: kPrimaryColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        preferredSize: Size.fromHeight(40)),
                  )
                ],
            body: GestureDetector(
              onTap: () {},
              child: GridView(
                padding: EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
                children: [
                    
                ],
              ),
            )));
  }
}
