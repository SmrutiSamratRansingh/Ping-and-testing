import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/material.dart';
import 'package:skysoft_assignment/models/ping_model.dart';

class PingEventsData extends ChangeNotifier {
  late List<Duration?> responsetimeList;
  late PingDataModel pingData;
  List<PingDataModel> pingDataList = [];
  late String ip;

  int count = 0; //check event number
  bool isPinged = false; //check if button is pressed
  bool hasData = false; //check if we have data from events

  void onPingGoogle() {
    count = 0; //reset count to zero for new button taps
    this.responsetimeList = [];

    final ping = Ping('google.com', count: 5); //start the ping

    ping.stream.listen((event) {
      //listen to ping events
      setBoolAndCount(event);

      getIpAndResponseList(event);
      createPingDataModelObject();

      removeOldPingDataModelObject();
      getListOfPingDataModel();

      notifyListeners();
    });
  }

  void getListOfPingDataModel() {
    pingDataList.add(
        pingData); //add the new PingDataModel with updated list of response times.
  }

  void removeOldPingDataModelObject() {
    if (count >= 2) {
      //remove the last object of PingDataModel added to  pingDataList which has old list of response times.
      //this code is not executed for first event since pingDataList is empty here.
      var index = pingDataList.length - 1;
      pingDataList.removeAt(index);
    }
  }

  void createPingDataModelObject() {
    this.pingData = PingDataModel.fromEvent(this
        .responsetimeList); //create object of PingDataModel with current list of response times.
  }

  void getIpAndResponseList(PingData event) {
    if (event.response != null) {
      //get ip and updated list of response times from events
      this.ip = event.response!.ip!;
      this.responsetimeList.add(event.response!.time);
    }
  }

  void setBoolAndCount(PingData event) {
    //controls what widgets are displayed on screen
    count++;
    this.isPinged = true;
    if (event.response == null) {
      isPinged = false;
    }
    this.hasData = true;
  }
}
