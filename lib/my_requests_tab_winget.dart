import 'package:flutter/material.dart';

class MyRequestsTab extends StatefulWidget {

  @override
  _MyRequests createState() => _MyRequests();

}

class _MyRequests extends State<MyRequestsTab> with TickerProviderStateMixin {

  String _textReqOrWork = "Заказы";


  @override
  initState() {
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
                  Text(
                    _textReqOrWork,
                      style: TextStyle(color: Colors.blueGrey.shade900,   // зеленый цвет текста
                          fontSize: 24,                       // высота шрифта 26
                      )
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );

    Widget _containerTab = Container(
      color: Colors.white,
      padding: EdgeInsets.only(top:16),
      child: Row (
        children: <Widget>[
          Expanded(
            child: Container(
//                height: double.infinity,
              width: 100.0,
              color: Colors.red,
              child:  Text("adsads"),
            ),
          ),
        ],
      ),
    );


    // return Container(
    //   height: double.infinity,
    //   width: double.infinity,
    //   child: Align(
    //     alignment: Alignment.topLeft,
    //     child: Column(
    //       children: [
    //         _titleTab,
    //         _containerTab
    //       ],
    //     ),
    //   )
    // );

    Widget activityRequest = new Container(
      color: Colors.white,
      padding: EdgeInsets.only(top:24),
      child: Align(
        alignment: Alignment.center,
        child: new Expanded(child: new Text("Активные заказы")),
      ),
    );

    Widget archRequest = new Container(
      color: Colors.white,
      padding: EdgeInsets.only(top:24),
      child: Align(
        alignment: Alignment.center,
        child: new Expanded(child: new Text("Активные заказы")),
      ),
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
                new Column(
                  children: <Widget>[activityRequest],
                ),
                new Column(
                  children: <Widget>[archRequest],
                )
              ],
            ),
          ),
        ),
      );

  }
}
