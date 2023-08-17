import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wiseki/datasource/darkmode.dart';
import 'package:wiseki/model/note.dart';
import 'package:wiseki/provider/home_provider.dart';
import 'package:wiseki/screens/add_note.dart';
import 'package:wiseki/utils/app_assets.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<Notes> listNotes = ref.watch(homeStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("All Notes"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(Assets.searchIcon),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          margin: EdgeInsets.symmetric(vertical: 100, horizontal: 30),
          child: Column(
            children: [
              Consumer(builder: (context, ref, child) {
                final theme = ref.watch(themeModeProvider);
                return IconButton(
                    onPressed: () {
                      ref.read(themeModeProvider.notifier).state =
                          theme == ThemeMode.light
                              ? ThemeMode.dark
                              : ThemeMode.light;
                    },
                    icon: AnimatedSwitcher(
                      duration: Duration(milliseconds: 400),
                      transitionBuilder: (child, animation) {
                        return RotationTransition(
                          turns: Tween(begin: 0.5, end: 1.0).animate(animation),
                          child: child,
                        );
                      },
                      child: Icon(
                        theme == ThemeMode.dark
                            ? Icons.light_mode
                            : Icons.dark_mode,
                        key: ValueKey(theme == ThemeMode.dark),
                      ),
                    ));
              }),
              Row(
                children: [
                  SvgPicture.asset(Assets.drawerOne),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "All Note",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddNote()));
                },
                child: Row(
                  children: [
                    SvgPicture.asset(Assets.drawerTwo),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      " Notebook",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SvgPicture.asset(Assets.drawerThree),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Favorite",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SvgPicture.asset(Assets.drawerFive),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Deleted",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SvgPicture.asset(Assets.drawerFive),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Settings",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Row(
                children: [
                  Text("Pinned notes"),
                  Container(
                    color: Colors.black,
                    height: 1,
                    width: 250,
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: listNotes.length,
                  itemBuilder: (context, index) {
                    final data = listNotes[index];
                    return Container(
                      padding: EdgeInsets.all(30),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Color(0xFFFF9E9E),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.sp),
                              ),
                              SvgPicture.asset(Assets.popIcon)
                            ],
                          ),
                          Text(
                            data.description,
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w300,
                                color: Color(0xFF000000)),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            Row(
              children: [
                Text(
                  "Other notes",
                  style: TextStyle(),
                ),
                Container(
                  color: Colors.black,
                  height: 1,
                  width: 250,
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNote()));
        },
      ),
    );
  }
}
