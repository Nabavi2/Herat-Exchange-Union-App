// import 'package:flutter/cupertino.dart';

class Exchange {
  int id;
  String value;

  Title title;
  metaData Data;

  String country, count, kharid, forosh;

  Exchange.loading() {
    country = "AMC";
    count = "دالر به درهم";
    kharid = "78 ";
    forosh = "79 ";
  }

  Exchange.fromMap(Map<String, dynamic> map) {
    id = map['id'];

//    title=map['title'];
//    Data = map['metadata'];
  }
}

class metaData {
  String
      //dolar  1
      BuyDollar,
      SellDollar,
      //youro  2
      BuyYuro,
      SellYuro,
      //puond  3
      Buypuond,
      Sellpuond,
      //toman   4
      BuyToman,
      sellToman,
      //caldar 5
      Buycaldar,
      Sellcaldar,
      //ropia  6
      BuyRopya,
      SellRopya,
      //darham  7
      BuyDeham,
      SellDeham,
      //rela  8
      BuyReal,
      SellReal,
      //frank  9
      BuyFrank,
      SellFrank,
      //dolor canada  10
      Buydollarcanada,
      Selldollarcanada,
      //dolar astrial    11
      BuyastrDollar,
      SellastrDollar,
      // cron   12
      Buycrone,
      Sellcrone,
      //dolar to toamna    13
      BuyDatoTo,
      SellDatoTo,
      // caldar to dalar  14
      BuyCaToDo,
      SellCaToDo,
      // dalar to darham   15
      BuyDoToDar,
      SellDoToDar,
      //dolar to  yuro    16
      BuydorToYu,
      SelldorToYu;

  metaData.fromJson(Map<String, dynamic> map) {
    //doal
    BuyDollar = map['BuyDollar'];
    SellDollar = map['SellDollar'];
    //yuro
    BuyYuro = map['BuyYuro'];
    SellYuro = map['SellYuro'];

    // puond
    Buypuond = map['Buypuond'];
    Sellpuond = map['Sellpuond'];

    /// toman
    BuyToman = map['BuyToman'];
    sellToman = map['sellToman'];

    /// aldar
    Buycaldar = map['Buycaldar'];
    Sellcaldar = map['Sellcaldar'];

    /// Ropya
    BuyRopya = map['BuyRopya'];
    SellRopya = map['SellRopya'];

    BuyDeham = map['BuyDeham'];
    SellDeham = map['SellDeham'];

    BuyReal = map['BuyReal'];
    SellReal = map['SellReal'];

    BuyFrank = map['BuyFrank'];
    SellFrank = map['SellFrank'];

    Buydollarcanada = map['Buydollarcanada'];
    Selldollarcanada = map['Selldollarcanada'];

    BuyastrDollar = map['BuyastrDollar'];
    SellastrDollar = map['SellastrDollar'];

    Buycrone = map['Buycrone'];
    Sellcrone = map['Sellcrone'];

    BuyDatoTo = map['BuyDatoTo'];
    SellDatoTo = map['SellDatoTo'];

    BuyCaToDo = map['BuyCaToDo'];
    SellCaToDo = map['SellCaToDo'];

    BuyDoToDar = map['BuyDoToDar'];
    SellDoToDar = map['SellDoToDar'];

    BuydorToYu = map['BuydorToYu'];
    SelldorToYu = map['SelldorToYu'];
  }
}

class Title {
  String name;

  Title.fromJson(Map<String, String> m) {
    name = m['rendered'];
  }
}
