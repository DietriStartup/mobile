import 'package:dietri/components/errorscreen.dart';
import 'package:dietri/components/loading_screen.dart';
import 'package:dietri/constants/colors.dart';
import 'package:flutter/material.dart';
import 'empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class GridViewItemsBuilder<T> extends StatelessWidget {
  const GridViewItemsBuilder(
      {Key? key,
      required this.snapshot,
      required this.crossAxisCount,
      required this.itemBuilder,
      required this.isReverse})
      : super(key: key);
  final AsyncSnapshot<List> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;
  final int crossAxisCount;

  final bool isReverse;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List items = snapshot.data!;

      if (items.isNotEmpty) {
        
        return _buildGridView(items);
      } else {
        return const EmptyContent();
      }
    } else if (snapshot.hasError) {
      return const ErrorScreen();
    }
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: kPrimaryAccentColor,
        color: kPrimaryColor,
      ),
    );
  }

  Widget _buildGridView(List items) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount, mainAxisSpacing: 10, crossAxisSpacing: 10),
        physics: const BouncingScrollPhysics(),
        reverse: isReverse,
        itemCount:  items.length,
        itemBuilder: (context, index) => itemBuilder(context, items[index]));
  }
}
