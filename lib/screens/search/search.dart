import 'package:flutter/material.dart';
import 'package:hc_morocco_doctors/screens/search/search_widgets.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Searchfield(),
            SearchinfoLine(),
            Expanded(child: ProductSearchSection())
          ]),
    );
  }
}
