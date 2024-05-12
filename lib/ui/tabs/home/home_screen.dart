import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/ui/auth/login/login.dart';
import '../../../models/bottom_sheet_dm.dart';
import '../../../models/categories_dm.dart';
import '../../utils/bottom_sheet.dart';
import 'categories_screens/categories_screen.dart';
import 'categories_screens/important_screen/important_screen.dart';
import 'categories_screens/upcoming_screen/upcoming_screen.dart';
import 'home_screen_view_model.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

HomeScreenViewModel viewModel = HomeScreenViewModel();

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    BottomSheetDM bottomSheetDM = BottomSheetDM();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 233, 247),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bottomSheetDM.segmentedControlGroupValue = 0;
          bottomSheetDM.cat = bottomSheetDM.category[0];
          bottomSheetDM.date = DateTime.now();
          bottomSheetDM.timeFrom = TimeOfDay.now();
          bottomSheetDM.timeTo = TimeOfDay.now();
          showTodosBottomSheet(context, bottomSheetDM, viewModel);
        },
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
        backgroundColor: const Color.fromARGB(255, 72, 108, 189),
        focusColor: Colors.white,
        isExtended: true,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                const Text(
                  "Lists",
                  style: TextStyle(
                      fontFamily: "Ubuntu",
                      fontSize: 35,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ));
                    },
                    icon: const Icon(
                      Icons.logout,
                      size: 40,
                      color: Colors.black,
                    ))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 25),
            margin: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: const Color.fromARGB(255, 241, 244, 251)),
            child: Column(
              children: [
                InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoriesTab(
                              field: "day",
                              sortBy: DateTime.now().day,
                              title: "My day",
                          ),
                        )),
                    child: buildRow(Icons.sunny, "My day")),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                InkWell(onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpcomingScreen(
                          field: "date",
                          sortBy: DateTime.now(),
                          title: "Upcoming"),
                    )),
                    child: buildRow(CupertinoIcons.calendar, "Upcoming")),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImportantScreen(
                              title: "Important"),
                        )),
                    child: buildRow(Icons.star, "Important")
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Expanded(
            child: GridView.builder(
                itemCount: CategoryDM.category.length,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) =>
                    buildCategoryWidget(CategoryDM.category[index]),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.15/1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 8)),
          )
        ],
      ),
    );
  }

  Widget buildRow(IconData iconData, String title) {
    return Row(
      children: [
        Icon(
          iconData,
          size: 40,
          color: const Color.fromARGB(255, 72, 108, 189),
        ),
        const SizedBox(
          width: 18,
        ),
        Text(
          title,
          style: const TextStyle(
              fontFamily: "Ubuntu",
              color: Color.fromARGB(255, 72, 108, 189),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget buildCategoryWidget(CategoryDM category) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoriesTab(
                field: "category",
                sortBy: category.title,
                title: category.title),
          )),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: category.backgroundColor),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                category.iconData,
                color: Colors.white,
                size: 40,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                category.title,
                style: const TextStyle(
                    fontSize: 20, fontFamily: "Ubuntu", color: Colors.white),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}