import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final PageController pageController;
  ScrollController _scrollController = ScrollController();
  int pageNo = 0;

  Timer? carasouelTmer;

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageNo == 4) {
        pageNo = 0;
      }
      pageController.animateToPage(
        pageNo,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutCirc,
      );
      pageNo++;
    });
  }

  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    carasouelTmer = getTimer();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        showBtmAppBr = false;
        setState(() {});
      } else {
        showBtmAppBr = true;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  bool showBtmAppBr = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              const SizedBox(
                height: 36.0,
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ListTile(
                  onTap: () {},
                  selected: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                  ),
                  selectedTileColor: Colors.indigoAccent.shade100,
                  title: Text(
                    "Welcome Back",
                    style: Theme.of(context).textTheme.subtitle1!.merge(
                          const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0,
                          ),
                        ),
                  ),
                  subtitle: Text(
                    "A Greet welcome to you all.",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  trailing: PopUpMen(
                    menuList: const [
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(
                            CupertinoIcons.person,
                          ),
                          title: Text("My Profile"),
                        ),
                      ),
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(
                            CupertinoIcons.bag,
                          ),
                          title: Text("My Bag"),
                        ),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem(
                        child: Text("Settings"),
                      ),
                      PopupMenuItem(
                        child: Text("About Us"),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(
                            Icons.logout,
                          ),
                          title: Text("Log Out"),
                        ),
                      ),
                    ],
                    icon: CircleAvatar(
                      backgroundImage: const NetworkImage(
                        'https://images.unsplash.com/photo-1644982647869-e1337f992828?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80',
                      ),
                      child: Container(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (index) {
                    pageNo = index;
                    setState(() {});
                  },
                  itemBuilder: (_, index) {
                    return AnimatedBuilder(
                      animation: pageController,
                      builder: (ctx, child) {
                        return child!;
                      },
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("Hello you tapped at ${index + 1} "),
                            ),
                          );
                        },
                        onPanDown: (d) {
                          carasouelTmer?.cancel();
                          carasouelTmer = null;
                        },
                        onPanCancel: () {
                          carasouelTmer = getTimer();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              right: 8, left: 8, top: 24, bottom: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: Colors.amberAccent,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 5,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.circle,
                        size: 12.0,
                        color: pageNo == index
                            ? Colors.indigoAccent
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: GridB(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: showBtmAppBr
          ? FloatingActionButtonLocation.centerDocked
          : FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
        ),
      ),
      bottomNavigationBar: AnimatedContainer(
        child: BottomAppBar(
          notchMargin: 8.0,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.home_outlined,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.heart,
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.bookmark,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.person_crop_circle,
                ),
              ),
            ],
          ),
        ),
        duration: const Duration(
          milliseconds: 800,
        ),
        curve: Curves.easeInOutSine,
        height: showBtmAppBr ? 70 : 0,
      ),
    );
  }
}

class PopUpMen extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget? icon;
  const PopUpMen({Key? key, required this.menuList, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      itemBuilder: ((context) => menuList),
      icon: icon,
    );
  }
}

class FabExt extends StatelessWidget {
  const FabExt({
    Key? key,
    required this.showFabTitle,
  }) : super(key: key);

  final bool showFabTitle;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {},
      label: AnimatedContainer(
        duration: const Duration(seconds: 2),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const Icon(CupertinoIcons.cart),
            SizedBox(width: showFabTitle ? 12.0 : 0),
            AnimatedContainer(
              duration: const Duration(seconds: 2),
              child: showFabTitle ? const Text("Go to cart") : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}

class GridB extends StatefulWidget {
  const GridB({Key? key}) : super(key: key);

  @override
  State<GridB> createState() => _GridBState();
}

class _GridBState extends State<GridB> {
  final List<Map<String, dynamic>> gridMap = [
    {
      "title": "Pandawa Lima",
      "images":
          "data:image/jpeg;base64,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",
    },
    {
      "title": "Mahabharata",
      "images":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwbqCAonE4fPYdkLUglFW8mjrbSO7eetDKI_tQjDrDglfTeeitg6sjIn3wb6S8gT5_pcs&usqp=CAU",
    },
    {
      "title": "Bharatayudha",
      "images":
          "data:image/jpeg;base64,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",
    },
    {
      "title": "Ramayana",
      "images":
          "data:image/jpeg;base64,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",
    },
    {
      "title": "Punakawan Catur",
      "images":
          "data:image/jpeg;base64,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",
    },

  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        mainAxisExtent: 310,
      ),
      itemCount: gridMap.length,
      itemBuilder: (_, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              16.0,
            ),
            color: Colors.amberAccent.shade100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                child: Image.network(
                  "${gridMap.elementAt(index)['images']}",
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${gridMap.elementAt(index)['title']}",
                      style: Theme.of(context).textTheme.subtitle1!.merge(
                            const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "${gridMap.elementAt(index)['price']}",
                      style: Theme.of(context).textTheme.subtitle2!.merge(
                            TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.grey.shade500,
                            ),
                          ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.heart,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}