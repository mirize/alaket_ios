import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProfileTab extends StatefulWidget {

  @override
  MapScreenState createState() => MapScreenState();

}

class MapScreenState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  String _view_profile = 'Заказчик';
  bool is_worker = false;
  String _reg_nnumber_profile = '№0000000000000';
  String _name = '';
  String _lname = '';
  String _radius = '0';
  bool _sw_show_fio = true;
  bool _sw_show_date_reg = true;
  bool _sw_show_phone = true;
  bool _sw_show_notifications = false;
  bool _sw_show_chat_messages = false;
  final TextEditingController _text_name_controller = new TextEditingController();
  final TextEditingController _text_lname_controller = new TextEditingController();
  final TextEditingController _text_radius_controller = new TextEditingController();
  final double _height_switch_container = 30.0;



  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _text_name_controller.text = _name;
    _text_name_controller.text = _lname;
    _text_radius_controller.text = _radius;
    _status = false;

    Widget buttonReplaceType = Container(
      width: double.infinity,
      padding: EdgeInsets.only(top:8, left: 8, right: 8, bottom: 28),
      height: 84,
      color: Colors.white,
      child: new RaisedButton(
        child: Text(is_worker?'СТАТЬ ЗАКАЗЧИКОМ':'СТАТЬ ПОДРЯДЧИКОМ'),
        onPressed: () {},
        highlightColor: Colors.deepOrange,
        color: Colors.deepOrange,
        textColor: Colors.white,
        padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
        highlightElevation: 8,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        colorBrightness: Brightness.light,
      ),

    );

    Widget divider = new Container(
      height: 1.0,
      color: Colors.blueGrey.shade50,
      margin: EdgeInsets.only(left: 8.0, right: 8.0),
    );

    return new Scaffold(
        body: new Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Container(
                    height: 150.0,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: new Stack(
                              fit: StackFit.loose,
                              children: <Widget>[
                            new Row(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                    width: 96.0,
                                    height: 96.0,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        image: new ExactAssetImage(
                                            'assets/icons/ic_icon_user_type_req.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                                new Expanded(
                                    child: new Column(
                                      children: [
                                        new Container(
                                          alignment: Alignment.topLeft,
                                          padding: EdgeInsets.only(left: 16.0),
                                          height: 48.0,
                                          color: Colors.white,
                                          child: new Text(
                                            _view_profile,
                                              style: TextStyle(
                                                  fontSize: 24.0
                                              )
                                          ),
                                        ),
                                        new Container(
                                          alignment: Alignment.topLeft,
                                          padding: EdgeInsets.only(left: 16.0),
                                          height: 48.0,
                                          color: Colors.white,
                                          child: new Text(
                                              _reg_nnumber_profile,
                                              style: TextStyle(
                                                  fontSize: 18.0
                                              )
                                          ),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          ]
                          ),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    color: Colors.white,
                    child: buttonReplaceType,
                  ),
                  divider,
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Персональные данные',
                                        style: TextStyle(
                                            fontSize: 16.0
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      decoration: const InputDecoration(
                                        hintText: "Имя",
                                      ),
                                      style: TextStyle(
                                          fontSize: 12.0
                                      ),
                                      enabled: !_status,
                                      autofocus: !_status,
                                      controller: _text_name_controller,
                                    ),
                                  ),
                                ],
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      decoration: const InputDecoration(
                                        hintText: "Фамилия",
                                      ),
                                      style: TextStyle(
                                          fontSize: 12.0
                                      ),
                                      enabled: !_status,
                                      autofocus: !_status,
                                      controller: _text_lname_controller,
                                    ),
                                  ),
                                ],
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                  divider,
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 32.0, bottom: 16),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Отображение данных',
                                        style: TextStyle(
                                            fontSize: 16.0
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 2.0),
                              child: new Container(
                                height: _height_switch_container,
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Показывать фамилию:',
                                          style: TextStyle(
                                              fontSize: 12.0
                                          ),
                                        ),
                                      ],
                                    ),
                                    new Switch(
                                      value: _sw_show_fio,
                                      onChanged: (value) {
                                        setState(() {
                                          _sw_show_fio = value;
                                        });
                                      },
                                      activeTrackColor: Colors.deepOrange.shade200,
                                      activeColor: Colors.deepOrange.shade700,
                                    )
                                  ],
                                ),
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 2.0),
                              child: new Container(
                                height: _height_switch_container,
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Показывать дату регистрации:',
                                          style: TextStyle(
                                              fontSize: 12.0
                                          ),
                                        ),
                                      ],
                                    ),
                                    new Switch(
                                      value: _sw_show_date_reg,
                                      onChanged: (value) {
                                        setState(() {
                                          _sw_show_date_reg = value;
                                        });
                                      },
                                      activeTrackColor: Colors.deepOrange.shade200,
                                      activeColor: Colors.deepOrange.shade700,
                                    )
                                  ],
                                ),
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 2.0),
                              child: new Container(
                                height: _height_switch_container,
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Показывать телефон:',
                                          style: TextStyle(
                                              fontSize: 12.0
                                          ),
                                        ),
                                      ],
                                    ),
                                    new Switch(
                                      value: _sw_show_phone,
                                      onChanged: (value) {
                                        setState(() {
                                          _sw_show_phone = value;
                                        });
                                      },
                                      activeTrackColor: Colors.deepOrange.shade200,
                                      activeColor: Colors.deepOrange.shade700,
                                    )
                                  ],
                                ),
                              )
                          )

                        ],
                      ),
                    ),
                  ),
                  divider,
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 32.0, bottom: 16),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Уведомления',
                                        style: TextStyle(
                                            fontSize: 16.0
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 2.0),
                              child: new Container(
                                height: _height_switch_container,
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Состояние заказов:',
                                          style: TextStyle(
                                              fontSize: 12.0
                                          ),
                                        ),
                                      ],
                                    ),
                                    new Switch(
                                      value: _sw_show_notifications,
                                      onChanged: (value) {
                                        setState(() {
                                          _sw_show_notifications = value;
                                        });
                                      },
                                      activeTrackColor: Colors.deepOrange.shade200,
                                      activeColor: Colors.deepOrange.shade700,
                                    )
                                  ],
                                ),
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 2.0),
                              child: new Container(
                                height: _height_switch_container,
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Сообщения в чатах:',
                                          style: TextStyle(
                                              fontSize: 12.0
                                          ),
                                        ),
                                      ],
                                    ),
                                    new Switch(
                                      value: _sw_show_chat_messages,
                                      onChanged: (value) {
                                        setState(() {
                                          _sw_show_chat_messages = value;
                                        });
                                      },
                                      activeTrackColor: Colors.deepOrange.shade200,
                                      activeColor: Colors.deepOrange.shade700,
                                    )
                                  ],
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                  divider,
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Радиус поиска заказов',
                                        style: TextStyle(
                                            fontSize: 16.0
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      decoration: const InputDecoration(
                                        hintText: "Радиус поиска (0, если нет ограничений), км.",
                                      ),
                                      style: TextStyle(
                                          fontSize: 12.0
                                      ),
                                      enabled: !_status,
                                      autofocus: !_status,
                                      controller: _text_radius_controller,
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                    divider,
                  new Padding(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 16.0,
                      bottom: 16.0
                    ),
                    child: new Container(
                      height: _height_switch_container,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Text(
                                'Справка и документы',
                                style: TextStyle(
                                    fontSize: 16.0
                                ),
                              ),
                            ],
                          ),
                          new Icon(
                            Icons.library_books_outlined,
                            size: 20.0,
                            color: Colors.blueGrey.shade700
                          )
                        ],
                      ),
                    ),
                  ),
                  divider,
                  new Padding(
                    padding: EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 16.0,
                        bottom: 16.0
                    ),
                    child: new Container(
                      height: _height_switch_container,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Text(
                                'Поделиться ссылкой',
                                style: TextStyle(
                                    fontSize: 16.0
                                ),
                              ),
                            ],
                          ),
                          new Icon(
                              Icons.share,
                              size: 20.0,
                              color: Colors.blueGrey.shade700
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

}