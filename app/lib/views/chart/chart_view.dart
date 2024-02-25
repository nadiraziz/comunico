import 'package:app/models/analyze/analyze_history.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class FeedbackChart extends StatelessWidget {
  final List<AnalyzeHistoryResponse> analyzeResultList;

  const FeedbackChart(this.analyzeResultList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BarChart(
        BarChartData(
          barGroups: createBarGroups(),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(),
          ),
          borderData: FlBorderData(
            show: true,
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> createBarGroups() {
    return List.generate(analyzeResultList.length, (index) {
      final double value = index.toDouble();
      final String voiceEmotion = analyzeResultList[index].voiceEmotion ?? "";
      final Color barColor = getBarColor(voiceEmotion);

      return BarChartGroupData(
        x: value.toInt(),
        barRods: [
          BarChartRodData(
            color: barColor,
            toY: 1,
          ),
        ],
      );
    });
  }

  Color getBarColor(String emotion) {
    switch (emotion.toLowerCase()) {
      case "happy":
        return Colors.green;
      case "sad":
        return Colors.blue;
      case "fearful":
        return Colors.red;
      case "angry":
        return Colors.orange;
      case "neutral":
      default:
        return Colors.grey;
    }
  }
}
