import 'package:dart_ping/dart_ping.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skysoft_assignment/provider/ping_provider.dart';

class MockPingEventsData extends PingEventsData {}

class MockPingData extends PingData {
  MockPingData({this.response, this.summary, this.error});

  PingResponse? response;

  PingSummary? summary;

  PingError? error;
}

class MockPingResponse extends PingResponse {
  MockPingResponse({this.seq, this.ttl, this.time, this.ip});

  int? seq;

  int? ttl;

  Duration? time;

  String? ip;
}

void main() {
  MockPingEventsData mockPingEventsData = MockPingEventsData();
  Duration duration = Duration(milliseconds: 12);
  MockPingResponse mockPingResponse =
      MockPingResponse(ip: '173.334.4545:112', time: duration);
  MockPingData mockPingData = MockPingData(response: mockPingResponse);
  mockPingEventsData.responsetimeList = [];
  setUp(() {});
  tearDown(() {
    mockPingEventsData.dispose();
  });
  test('test all functions used in provider when first event occurs on Ping',
      () {
    mockPingEventsData.setBoolAndCount(mockPingData);
    mockPingEventsData.getIpAndResponseList(mockPingData);
    mockPingEventsData.createPingDataModelObject();
    mockPingEventsData.removeOldPingDataModelObject();
    mockPingEventsData.getListOfPingDataModel();
    expect(mockPingEventsData.isPinged, true);
    expect(mockPingEventsData.ip, '173.334.4545:112');
    expect(mockPingEventsData.pingData.responseTimeList.length, 1);
    expect(mockPingEventsData.pingDataList.length, 1);
  });
}
