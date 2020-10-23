import 'package:flutter/material.dart';
import 'package:shopuo/Components/HeaderComponent.dart';
import 'package:shopuo/Components/SearchComponent.dart';
import 'package:shopuo/Components/SearchResultComponent.dart';
import 'package:shopuo/Models/SearchModel.dart';

class Search extends StatelessWidget {
  final _searchResults = searchResults;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: HeaderComponent(
          leading: "assets/svg_icons/chevron-left.svg",
          title: "Search",
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 25),
          children: [
            SizedBox(
              height: 20,
            ),
            SearchComponent(
              hintText: "Article",
              icon: "assets/svg_icons/search.svg",
            ),
            SizedBox(
              height: 40,
            ),
            SearchResultComponent(
              results: _searchResults,
            ),
          ],
        ),
      ),
    );
  }
}
