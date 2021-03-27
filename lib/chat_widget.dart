import 'package:flutter/material.dart';

class ChatTab extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16,right: 16,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Сообщения",style: TextStyle(fontSize: 20),),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}