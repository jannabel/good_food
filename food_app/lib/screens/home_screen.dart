import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/models/category.dart';
import 'package:food_app/providers/category_provider.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/icons/icon_class_icons.dart';
import 'package:food_app/widgets/categoriesCard.dart';
import 'package:food_app/widgets/suggestionsCard_widget.dart';
import 'package:food_app/widgets/welcome_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context, listen: true);

    final List<Category> categories = categoryProvider.categories;

    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: _customAppBar(),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const WelcomeWidget(),
                const SizedBox(
                  height: 20.0,
                ),
                Text("Sugerencias",
                    style: GoogleFonts.robotoSlab(
                        fontWeight: FontWeight.bold, fontSize: 18.0)),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 320.0,
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => SuggestionsCardWidget(
                      imageUrl: "assets/images/hongos.png",
                      titlePlate: "Filete de Res en Salsa de Hongos",
                      persons: "8 personas",
                      time: "45 minutos",
                      firstColor: Color.fromARGB(213, 167, 194, 94),
                      secondColor: Color.fromARGB(255, 116, 144, 55),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Text("Categorias",
                    style: GoogleFonts.robotoSlab(
                        fontWeight: FontWeight.bold, fontSize: 18.0)),
                const SizedBox(
                  height: 20.0,
                ),
                FutureBuilder<List<Category>>(
                    future: categoryProvider.getCategories(),
                    builder: (_, AsyncSnapshot<List<Category>> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          widthFactor: 10,
                          heightFactor: 5,
                          child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(primaryColor)),
                        );
                      } else {
                        return GridView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemCount: categories.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CategoriesCardWidget(
                                  urlImage: categories[index].fullImagePath,
                                  title: categories[index].name,
                                  imageWidth: 70.0,
                                  imageHeigth: 70.0,
                                  titleSize: 15.0);
                            });
                      }
                    }),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ],
        ),
      ),

      // body:  ,
    );
  }

  AppBar _customAppBar() {
    return AppBar(
      backgroundColor: bgColor,
      elevation: 0,
      leading: IconButton(
        padding: const EdgeInsets.symmetric(horizontal: 17.0),
        icon: const Icon(
          Icons.menu,
          color: iconColor,
          size: 32.0,
        ),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            color: iconColor,
            size: 32.0,
          ),
        )
      ],
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
