import 'package:fitness_app/top_bar.dart';
import 'package:flutter/material.dart';

import 'blocs/home_page_bloc.dart';
import 'date_utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageBloc _homePageBloc;

  @override
  void initState() {
    _homePageBloc = HomePageBloc();
    super.initState();
  }

  @override
  void dispose() {
    _homePageBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Stack(
            children: <Widget>[
              TopBar(),
              Positioned(
                top: 50.0,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        _homePageBloc.subtractDate();
                      },
                    ),
                    StreamBuilder<Object>(
                        stream: _homePageBloc.dateStream,
                        initialData: _homePageBloc.selectedDate,
                        builder: (context, snapshot) {
                          return Column(
                            children: <Widget>[
                              Text(
                                formatterDayOfWeek.format(snapshot.data),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0,
                                    letterSpacing: 1.2,
                                    color: Colors.white),
                              ),
                              Text(
                                formatterDate.format(snapshot.data),
                                style: TextStyle(
                                    fontSize: 19.0, color: Colors.white),
                              )
                            ],
                          );
                        }),
                    Transform.rotate(
                      angle: 135.1,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          _homePageBloc.addDate();
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
