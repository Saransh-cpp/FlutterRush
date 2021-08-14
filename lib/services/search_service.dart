import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchService extends SearchDelegate<String> {

  loadData () async {
    List results = [];
    http.Response res = await http.get(Uri.parse("http://40.83.89.182:8000/artist?username=$query"));
    Map resMap = json.decode(res.body);
    results.add(resMap['username']);
    print(resMap['username']);
    return results;
  }

  // @override
  // ThemeData appBarTheme(BuildContext context) {
  //   // assert(context != null);
  //   final ThemeData theme = Theme.of(context);
  //   // assert(theme != null);
  //   return theme.copyWith(
  //     primaryColor: theme.primaryColor,
  //     primaryIconTheme: theme.primaryIconTheme,
  //     primaryColorBrightness: Brightness.dark,
  //     primaryTextTheme: theme.primaryTextTheme,
  //     inputDecorationTheme: const InputDecorationTheme(
  //       focusedBorder: OutlineInputBorder(
  //         borderSide: BorderSide(color: Colors.transparent),
  //       ),
  //       disabledBorder: OutlineInputBorder(
  //         borderSide: BorderSide(color: Colors.transparent),
  //       ),
  //     ),
  //   );
  // }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    var results = loadData();
    return Container(
      child: Text(results.toString()),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      child: Text("Press search to search for a gallery or a buyer"),
    );
  }
}