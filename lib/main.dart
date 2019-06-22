import 'package:fitness_app/radial_progress.dart';
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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  HomePageBloc _homePageBloc;

  AnimationController _iconAnimationController;

  @override
  void initState() {
    _homePageBloc = HomePageBloc();
    _iconAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 301));
    super.initState();
  }

  @override
  void dispose() {
    _homePageBloc.dispose();
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Column(
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
                      StreamBuilder(
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
            ),
            RadialProgress(),
            MonthlyStatusListing()
          ],
        ),
        Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red, width: 2.0)),
              child: IconButton(
                  icon: AnimatedIcon(
                      icon: AnimatedIcons.menu_close,
                      color: Colors.red,
                      progress: _iconAnimationController.view),
                  onPressed: () {
                    setState(() {
                      onIconPressed();
                    });
                  }),
            ))
      ],
    ));
  }

  void onIconPressed() {
    animationStatus
        ? _iconAnimationController.reverse()
        : _iconAnimationController.forward();
  }

  bool get animationStatus {
    final AnimationStatus status = _iconAnimationController.status;
    return status == AnimationStatus.completed;
  }
}

class MonthlyStatusListing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              MonthlyStatusRow('May 2019', 'On going'),
              MonthlyStatusRow('April 2019', 'Failed'),
              MonthlyStatusRow('March 2019', 'Completed'),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              MonthlyTargetRow('Lose weight', '3.8 ktgt/7 kg'),
              MonthlyTargetRow('Running per month', '15.3 km/20 km'),
              MonthlyTargetRow('Avg steps Per day', '10000/10000'),
            ],
          ),
        ],
      ),
    );
  }
}

class MonthlyStatusRow extends StatelessWidget {
  final String monthYear, status;

  MonthlyStatusRow(this.monthYear, this.status);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            monthYear,
            style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 17.0),
          ),
          Text(
            status,
            style: TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
                fontSize: 13.0),
          ),
        ],
      ),
    );
  }
}

class MonthlyTargetRow extends StatelessWidget {
  final String target, targetAchieved;

  MonthlyTargetRow(this.target, this.targetAchieved);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            target,
            style: TextStyle(color: Colors.black, fontSize: 15.0),
          ),
          Text(
            targetAchieved,
            style: TextStyle(color: Colors.grey, fontSize: 13.0),
          ),
        ],
      ),
    );
  }
}

