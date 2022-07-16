import 'package:card_swiper/card_swiper.dart';
import 'package:dietri/components/empty_meal_plan%20card.dart';
import 'package:dietri/components/errorscreen.dart';
import 'package:dietri/components/loading_screen.dart';
import 'package:dietri/constants/colors.dart';
import 'package:flutter/material.dart';
import 'empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class SwiperViewItemsBuilder<T> extends StatelessWidget {
  const SwiperViewItemsBuilder(
      {Key? key,
      required this.snapshot,
      required this.itemBuilder,
      required this.isReverse,
      required this.layout,
      required this.itemHeight,
      required this.itemWidth,
      this.pagination,
      this.scale,
      required this.viewPortFraction,
      required this.autoPlay})
      : super(key: key);
  final AsyncSnapshot<List> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;
  final SwiperLayout layout;
  final double itemHeight;
  final double itemWidth;
  final SwiperPagination? pagination;
  final double? scale;
  final double viewPortFraction;
  final bool autoPlay;
  final bool isReverse;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List items = snapshot.data!;
      if (items.isNotEmpty) {
        return _buildSwiperView(items);
      } else {
        return Swiper(
            itemCount: 1,
            loop: false,
            itemBuilder: (context, index) => const EmptyMealPlanCard());
      }
    } else if (snapshot.hasError) {
      return const ErrorScreen();
    }
    return const Center(
        child: CircularProgressIndicator(
      backgroundColor: kPrimaryAccentColor,
      color: kPrimaryColor,
    ));
  }

  Widget _buildSwiperView(List items) {
    return Swiper(
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        layout: layout,
        itemHeight: itemHeight,
        itemWidth: itemWidth,
        //autoplayDelay: 18000,
        outer: true,
        autoplay: autoPlay,
        pagination: pagination,
        axisDirection: AxisDirection.right,
        viewportFraction: viewPortFraction,
        scale: scale,
        loop: false,
        itemBuilder: (context, index) => itemBuilder(context, items[index]));
  }
}
