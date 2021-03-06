import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final currentFilters;
  final Function saveFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Your Filters")),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              child: Text("Adjust your meal selection", style: Theme.of(context).textTheme.headline6),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildSwitchListTile('Gluten-free', 'Only include gluten-free meals.', _glutenFree, (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                    _saveFilters();
                  }),
                  _buildSwitchListTile('Lactose-free', 'Only include lactose-free meals.', _lactoseFree, (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                    _saveFilters();
                  }),
                  _buildSwitchListTile('Vegetarian', 'Only include vegetarian meals.', _vegetarian, (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                    _saveFilters();
                  }),
                  _buildSwitchListTile('Vegan', 'Only include vegan meals.', _vegan, (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                    _saveFilters();
                  }),
                ],
              ),
            )
          ],
        ));
  }

  SwitchListTile _buildSwitchListTile(String title, String subtitle, bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(subtitle),
      onChanged: updateValue,
    );
  }

  void _saveFilters() {
    final selectedFilters = {
      'gluten': _glutenFree,
      'lactose': _lactoseFree,
      'vegetarian': _vegetarian,
      'vegan': _vegan,
    };
    // trigger _setFilters() in MyAppState
    widget.saveFilters(selectedFilters);
  }
}
