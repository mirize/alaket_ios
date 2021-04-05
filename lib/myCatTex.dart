import 'package:alaket_ios/creatMyTex.dart';
import 'package:alaket_ios/my_texnika.dart';
import 'package:alaket_ios/requesters_tab_winget.dart';
import 'package:flutter/material.dart';

class MyCatTexnik extends StatefulWidget {
  MyCatTexnik({Key key}) : super(key: key);

  @override
  _MyCatTexnikState createState() => _MyCatTexnikState();
}

class _MyCatTexnikState extends State<MyCatTexnik> {
  final name = [
    'Автобетононасос',
    'Автобетононасос с самозагрузкой',
    'Автобетоносместитель',
    'Автовышка',
    'Автодом',
    'Автокран',
    'Ассенизатор',
    'Асфальтоукладчик',
    'Бензовоз',
    'Бульдозер',
    'Буровое оборудование',
    'Вездеход',
    'Газозаправщик',
    'Генератор',
    'Гидробур',
    'Грейдер',
    'Гусеничный кран',
    'Дробилка',
    'Каток',
    'Коммунальная спецтехника',
    'Компрессор',
    'Погрузчик вилочный',
    'Погрузчик ковшовый',
    'Погрузчик ленточный',
    'Погрузчик непрерывного действия',
    'Погручзик платформенный',
    'Погрузчик роторный',
    'Погрузчик шнековый',
    'Погрузчик-копновоз',
    'Манипулятор',
    'Погрузчик-манипулятор',
    'Погрузчик',
    'Прицепы',
    'Полуприцепы',
    'Прицепы дачи',
    'Рефрижератор',
    'Сварочное оборудование',
    'Сельхозтехника',
    'Скотовоз',
    'Снегоуборщик',
    'Топливозаправщик',
    'Трактор',
    'Трал',
    'Траншеекопатель',
    'Фреза',
    'Цементовоз',
    'Штабелер',
    'Эвакуатор',
    'Мусоровоз',
    'Эвакуторная платформа',
    'Экскаватор-погрузчик',
    'Экскаватор',
    'Траншеекопатель',
    'Щетка дорожная',
    'Экскаватор мини',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: name.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CreateMyTex(
                      myCatTex: name[index],
                    )));
          },
          child: ListTile(
            title: Text(name[index]),
          ),
        );
      },
    ));
  }
}
