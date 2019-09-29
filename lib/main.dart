import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() async {
  List currencies = await _getCurrencies();

  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.amber, accentColor: Colors.teal),
    title: 'Cryptocurrency app',
    home: Homepage(currencies),
  ));
}

Future<List> _getCurrencies() async {
  String url = 'https://api.coinmarketcap.com/v1/ticker/?limit=50';
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

class Homepage extends StatefulWidget {
  List currencies;
  Homepage(this.currencies);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List currencies;
  final List<MaterialColor> _color = [Colors.red, Colors.green, Colors.grey];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cryptocurrency'),
        centerTitle: true,
      ),
      body: _bodywidget(),
    );
  }

  Widget _bodywidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
                itemCount: widget.currencies.length,
                itemBuilder: (BuildContext context, int index) {
                  final Map currency = widget.currencies[index];
                  final MaterialColor color = _color[index % _color.length];
                  return _getlistitem(currency, color);
                }),
          ),
        ],
      ),
    );
  }

  ListTile _getlistitem(currency, color) {
    var a=currency['price_usd'] ;
    return ListTile(
      leading: CircleAvatar(
        child: Text(currency['symbol']),
      ),
      title: new Text(
        currency['name'],
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      ),
      subtitle: Container(
        margin: EdgeInsets.only(right: 100.0),
        child: Column(
          children: <Widget>[

            Text("\$$a"
              ),
          ],
        ),
      ),
    );
  }
}
