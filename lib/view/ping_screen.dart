import 'dart:ui';

import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skysoft_assignment/provider/ping_provider.dart';

class PingProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PingEventsData(),
      child: PingProviderScreen(),
    );
  }
}

class PingProviderScreen extends StatefulWidget {
  const PingProviderScreen({Key? key}) : super(key: key);

  @override
  State<PingProviderScreen> createState() => _PingProviderScreenState();
}

class _PingProviderScreenState extends State<PingProviderScreen> {
  late PingData data;
  late Duration totalResponse;

  late bool isPinged;
  late bool hasEnded;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: ValueKey('scaffold'),
        backgroundColor: Colors.amber,
        appBar: AppBar(
          key: ValueKey('appBar'),
          centerTitle: true,
          title: Text(
            'Response Timer',
            key: ValueKey('appbar text'),
          ),
        ),
        body: SafeArea(
          child: Consumer<PingEventsData>(
              builder: (context, pingEventsData, child) {
            //initData();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: double.infinity,
                ),
                !pingEventsData.isPinged
                    ? ElevatedButton(
                        key: ValueKey('ping button'),
                        child: Text('Ping Google'),
                        onPressed: () {
                          pingEventsData.onPingGoogle();
                        },
                      )
                    : CircularProgressIndicator.adaptive(),
                SizedBox(
                  height: 10,
                ),
                pingEventsData.hasData
                    ? Row(
                        key: ValueKey('ip'),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'CURRENT IP:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            pingEventsData.ip,
                            style: TextStyle(
                                color: Colors.pinkAccent, fontSize: 18),
                          )
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                pingEventsData.hasData
                    ? Expanded(
                        child: ListView.separated(
                          key: ValueKey('outerListView'),
                          //shrinkWrap: true,
                          // outer ListView
                          itemCount: pingEventsData.pingDataList.length,
                          itemBuilder: (_, index1) {
                            return Column(
                              children: [
                                ListTile(
                                  key: ValueKey('innerListView'),
                                  subtitle: ListView.builder(
                                    // inner ListView
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true, // 1st add
                                    physics: ClampingScrollPhysics(), // 2nd add
                                    itemCount: pingEventsData
                                        .pingDataList[index1]
                                        .responseTimeList
                                        .length,
                                    itemBuilder: (_, index2) => Row(
                                      key: ValueKey('responseTimeText'),
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Response time ${index2 + 1}:',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${pingEventsData.pingDataList[index1].responseTimeList[index2]}',
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Total Response Time:',
                                      key: ValueKey('totalResponseTimeText'),
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        '${pingEventsData.pingDataList[index1].totalResponseTime}'),
                                  ],
                                )
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              color: Colors.blueAccent,
                            );
                          },
                        ),
                      )
                    : Container()
              ],
            );
          }),
        ));
  }
}
