import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/material.dart';
import 'package:skysoft_assignment/models/ping_model.dart';

class PingEventsData extends ChangeNotifier {
  late List<Duration?> responsetimeList;
  List<PingDataModel> pingDataList = [];
  late PingDataModel pingData;
  late String ip;
  bool isPinged = false;
  bool hasData = false;
  int count = 0;

  bool hasEnded = false;

  Duration totalResponse = Duration();
  void onPingGoogle() {
    count = 0;
    this.responsetimeList = [];
    final ping = Ping('google.com', count: 5);

    ping.stream.listen((event) {
      count++;
      if (event.response != null) {
        this.ip = event.response!.ip!;

        this.responsetimeList.add(event.response!.time);
      }

      this.pingData = PingDataModel.fromEvent(this.responsetimeList);
      this.isPinged = true;
      this.hasData = true;
      //this.hasEnded = false;
      if (count >= 2) {
        var index = pingDataList.length - 1;
        pingDataList.removeAt(index);
      }
      pingDataList.add(pingData);

      if (event.response == null) {
        isPinged = false;
        hasEnded = true;
      }

      notifyListeners();
    });
  }
}
