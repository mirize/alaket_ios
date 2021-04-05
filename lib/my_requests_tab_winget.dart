import 'package:alaket_ios/MyActiveListing.dart';
import 'package:alaket_ios/MyDeteleListing.dart';
import 'package:alaket_ios/all_task.dart';
import 'package:alaket_ios/myApplyActive.dart';
import 'package:alaket_ios/state/feedState.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyRequestsTab extends StatefulWidget {
  @override
  _MyRequests createState() => _MyRequests();
}

class _MyRequests extends State<MyRequestsTab> with TickerProviderStateMixin {
  String _textReqOrWork = "Заказы";
  bool status = false;

  init() {
    var authUser = FirebaseAuth.instance.currentUser;
    if (authUser != null) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(authUser.uid)
          .get()
          .then((value) {
        if (value.data() != null) {
          setState(() {
            status = value.data()['status'];
          });
        }
      });
    }
  }

  @override
  initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _titleTab = Container(
      margin: EdgeInsets.only(top: 30),
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 16.0),
          child: Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(_textReqOrWork,
                      style: TextStyle(
                        color: Colors.blueGrey.shade900, // зеленый цвет текста
                        fontSize: 24, // высота шрифта 26
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
    Widget activityRequest = status
        ? StreamProvider<List<Contract>>.value(
            value: FeedState().allMyApplyTaskApplications,
            child: MyApplyActiveListing(),
          )
        : StreamProvider<List<Tasks>>.value(
            value: FeedState().allMyTaskApplications,
            child: MyActiveListing(),
          );

    Widget archRequest = status
        ? Center(
            child: Text('Вы в режиме исполнителя'),
          )
        : StreamProvider<List<Tasks>>.value(
            value: FeedState().allMyDeteleTaskApplications,
            child: MyDeteleListing(),
          );

    return new MaterialApp(
      title: 'msc',
      home: new DefaultTabController(
        length: 2,
        child: new Scaffold(
          appBar: new PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: new Container(
              color: Colors.white,
              child: new SafeArea(
                child: Column(
                  children: <Widget>[
                    new Expanded(child: new Container()),
                    new TabBar(
                      labelColor: Colors.deepOrange,
                      indicatorColor: Colors.deepOrange,
                      unselectedLabelColor: Colors.blueGrey.shade900,
                      tabs: [new Text("АКТИВНЫЕ"), new Text("АРХИВ")],
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: new TabBarView(
            children: <Widget>[
              activityRequest,
              archRequest,
            ],
          ),
        ),
      ),
    );
  }
}
