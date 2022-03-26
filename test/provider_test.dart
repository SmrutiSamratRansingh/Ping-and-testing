import 'package:dart_ping/dart_ping.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skysoft_assignment/provider/ping_provider.dart';

void main() {
  Duration duration = Duration(milliseconds: 12);
  PingResponse pingResponse =
      PingResponse(ip: '173.334.4545:112', time: duration);
  PingData pingData = PingData(response: pingResponse);
  PingEventsData pingEventsData = PingEventsData();
  pingEventsData.responsetimeList = [];

  setUp(() {});
  tearDown(() {});
  test('test all functions used in provider when first event occurs on Ping',
      () {
    pingEventsData.setBoolAndCount(pingData);
    pingEventsData.getIpAndResponseList(pingData);
    pingEventsData.createPingDataModelObject();
    pingEventsData.removeOldPingDataModelObject();
    pingEventsData.getListOfPingDataModel();
    expect(pingEventsData.isPinged, true);
    expect(pingEventsData.ip, '173.334.4545:112');
    expect(pingEventsData.pingData.responseTimeList.length, 1);
    expect(pingEventsData.pingDataList.length, 1);
  });
  test('test all functions used in provider when second event occurs on Ping',
      () {
    pingEventsData.setBoolAndCount(pingData);
    pingEventsData.getIpAndResponseList(pingData);
    pingEventsData.createPingDataModelObject();
    pingEventsData.removeOldPingDataModelObject();
    pingEventsData.getListOfPingDataModel();
    expect(pingEventsData.isPinged, true);
    expect(pingEventsData.ip, '173.334.4545:112');
    expect(pingEventsData.pingData.responseTimeList.length, 2);
    expect(pingEventsData.pingDataList.length, 1);
  });

  test('test all functions used in provider when button is tapped again', () {
    pingEventsData.count = 0;
    pingEventsData.responsetimeList = [];
    pingEventsData.setBoolAndCount(pingData);
    pingEventsData.getIpAndResponseList(pingData);
    pingEventsData.createPingDataModelObject();
    pingEventsData.removeOldPingDataModelObject();
    pingEventsData.getListOfPingDataModel();
    expect(pingEventsData.isPinged, true);
    expect(pingEventsData.ip, '173.334.4545:112');
    expect(pingEventsData.pingData.responseTimeList.length, 1);
    expect(pingEventsData.pingDataList.length, 2);
  });
  test('test all functions when a ping has ended completely', () {
    PingData nullPingData = PingData(response: null);
    pingEventsData.setBoolAndCount(nullPingData);
    pingEventsData.getIpAndResponseList(nullPingData);
    pingEventsData.createPingDataModelObject();
    pingEventsData.removeOldPingDataModelObject();
    pingEventsData.getListOfPingDataModel();
    expect(pingEventsData.isPinged, false);
  });
}
