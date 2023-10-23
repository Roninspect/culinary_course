import 'package:culinary_course/src/core/constants/colors.dart';
import 'package:culinary_course/src/features/courses/widgets/category_list.dart';
import 'package:culinary_course/src/features/home/widgets/featured_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(
              MaterialCommunityIcons.chef_hat,
              color: primaryColor,
              size: 30,
            ),
            Text(
              "  Culinary Course ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 10),
            FetauredCard(),
            Text(
              "Courses By Category",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            CategoriesListView(),
          ]),
        ),
      ),
    );
  }
}
