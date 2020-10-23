import 'package:flutter/material.dart';
import 'package:shopuo/Components/SearchCard.dart';
import 'package:shopuo/Models/SearchModel.dart';

class SearchResultComponent extends StatelessWidget {
  final loading;
  final List<SearchModel> results;
  final loaded;

  const SearchResultComponent({
    Key key,
    this.loading,
    this.results,
    this.loaded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...results
            .map(
              (e) => SearchCard(
                product: e,
              ),
            )
            .toList()
      ],
    );
  }
}
