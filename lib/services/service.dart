import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum ConnectionStatus { loading, ready, error }

class Service {
  final ValueNotifier<Map<String, dynamic>> cardStateNotifier = ValueNotifier({
    'status': ConnectionStatus.loading,
    'dataObjects': [],
    'columnNames': [],
  });

  final ValueNotifier<Map<String, dynamic>> favoritesStateNotifier =
      ValueNotifier({
    'status': ConnectionStatus.ready,
    'dataObjects': [],
    'propertyNames': ['name', 'weapon', 'avatar', 'weakness', 'series'],
  });

  Future<void> loadRobotMaster() async {
    var robotsUri = Uri(
      scheme: 'http',
      host: '10.0.2.2',
      port: 8080,
      path: '/robotmasters',
    );

    var jsonString = await http.read(robotsUri);
    var robotsJson = jsonDecode(jsonString);

    cardStateNotifier.value = {
      'status': ConnectionStatus.ready,
      'dataObjects': robotsJson,
      'columnNames': ["Nome", "Arma", "Sprite", "Avatar", "Jogo"],
      'propertyNames': ["name", "weapon", "sprite", "avatar", "series"]
    };
  }
}
