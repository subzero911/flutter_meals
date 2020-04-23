import 'package:flutter/material.dart';
import '../widgets/category_item.dart';

import '../dummy_data.dart';

// экран со всеми категориями
class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        //children: DUMMY_CATEGORIES.map((catData) => CategoryItem(catData.id, catData.title, catData.color)).toList(),
        children: <Widget>[
          // новый синтаксис
          for (var catData in DUMMY_CATEGORIES) CategoryItem(catData.id, catData.title, catData.color),
        ],
    );
  }
}
