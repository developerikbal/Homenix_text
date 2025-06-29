// lib/screens/remedy/remedy_graph_screen.dart

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// RemedyScore Model for Graph Input
class RemedyScore {
  final String name;
  final int score;

  RemedyScore({required this.name, required this.score});
}

/// RemedyGraphScreen: রেমেডির গ্রাফ বিশ্লেষণ
class RemedyGraphScreen extends StatelessWidget {
  final List<RemedyScore> remedyScores;

  const RemedyGraphScreen({Key? key, required this.remedyScores}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<RemedyScore, String>> series = [
      charts.Series(
        id: 'RemedyScores',
        domainFn: (RemedyScore remedy, _) => remedy.name,
        measureFn: (RemedyScore remedy, _) => remedy.score,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        data: remedyScores,
        labelAccessorFn: (RemedyScore remedy, _) => '${remedy.name}: ${remedy.score}',
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Remedy Graph Analysis'),
        backgroundColor: Colors.green.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: charts.BarChart(
          series,
          animate: true,
          barRendererDecorator: charts.BarLabelDecorator<String>(),
          domainAxis: const charts.OrdinalAxisSpec(),
        ),
      ),
    );
  }
}