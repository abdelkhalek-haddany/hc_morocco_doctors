import 'package:flutter/material.dart';
import 'package:hc_morocco_doctors/themes/style.dart';


ValueNotifier<String> query = ValueNotifier('');

class Searchfield extends StatelessWidget {
  const Searchfield({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 3, right:15, left:15, bottom: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey ,width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        onSubmitted: (value) {
          query.value = value;
        },
        onChanged: (value) {
          if (value.isEmpty) {
            query.value = value;
          }
        },
        decoration: InputDecoration(
          hintText: 'Cherchez ',
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30.0),

          ),
          filled: true,
          hintStyle: TextStyle(
              fontSize: 11, fontWeight: FontWeight.bold,),
          fillColor: Colors.white,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class SearchinfoLine extends StatelessWidget {
  const SearchinfoLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2, bottom: 2),
      child: ValueListenableBuilder<String>(
        valueListenable: query,
        builder: (context, value, child) => value.isNotEmpty
            ? Row(
                children: [
                  const Text(
                    'Résultats pour  ',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text('"$value"'),
                ],
              )
            : const SizedBox(),
      ),
    );
  }
}

class ProductSearchSection extends StatefulWidget {
  const ProductSearchSection({Key? key}) : super(key: key);

  @override
  State<ProductSearchSection> createState() => ProductSearchSectionState();
}

class ProductSearchSectionState extends State<ProductSearchSection> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(

    );
  }
}
