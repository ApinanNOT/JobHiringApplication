import 'package:flutter/material.dart';
import 'package:jobhiring/widgets/history_design_ui.dart';
import 'package:provider/provider.dart';

import '../infoHandler/app_info.dart';

class TripsHistoryScreen extends StatefulWidget {

  @override
  State<TripsHistoryScreen> createState() => _TripsHistoryScreenState();
}

class _TripsHistoryScreenState extends State<TripsHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        thickness: 8,
        child: ListView.builder(
          itemBuilder: (context, i)
          {
            return HistoryDesignUIWidget(
              tripsHistoryModel: Provider.of<AppInfo>(context, listen: false).allTripsHistoryInformationList[i],
            );
          },
          itemCount: Provider.of<AppInfo>(context ,listen: false).countTotalTrips,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
        ),
      ),
    );
  }
}