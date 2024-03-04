// ignore_for_file: invalid_use_of_protected_member

import 'package:app/controller/analyze/analyze_controller.dart';
import 'package:app/helper/constant/colors.dart';
import 'package:app/helper/utils/borderradius.dart';
import 'package:app/helper/utils/edgeinsert.dart';
import 'package:app/helper/utils/sizedbox.dart';
import 'package:app/helper/utils/textstyle.dart';
import 'package:app/models/analyze/analyze_history.dart';
import 'package:app/views/common/datanotfound.dart';
import 'package:app/views/common/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

class AnalyticsChartView extends StatelessWidget {
  AnalyticsChartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: KText.head5Text(text: "Analytics Chart"),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              margin: KEdgeInset.kVH10,
              padding: KEdgeInset.kVH20,
              height: 400.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: KBorderRadius.kAllLR(radius: 10.r),
                border: Border.all(
                  color: KColors.primaryColor,
                  width: 5.h,
                ),
              ),
              child: Column(
                children: [
                  KText.head4Text(
                      text: "Performance Score",
                      textStyle: KTextStyle.style20.copyWith(
                        color: KColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      )),
                  Container(
                    margin: KEdgeInset.kV20,
                    height: 200.h,
                    child: GetX<AnalyzeController>(
                      init: AnalyzeController(),
                      initState: (_) {
                        _.controller?.getAnalyzeHistory();
                      },
                      builder: (_) {
                        var analyzeHistoryList =
                            _.analyzeHistoryResponse.value.reversed.toList();
                        if (analyzeHistoryList.length >= 5) {
                          analyzeHistoryList = analyzeHistoryList.sublist(0, 5);
                        }

                        if (analyzeHistoryList.isNotEmpty) {
                          return BarChart(BarChartData(
                            maxY: 100,
                            barGroups: createBarGroups(analyzeHistoryList),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 35.w,
                                interval: 20,
                              )),
                              rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              topTitles: const AxisTitles(),
                              show: true,
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                          ));
                        }
                        return const DataNotFoundWidget();
                      },
                    ),
                  ),
                  Column(
                    children: List.generate(
                      emotionScoreList.length,
                      (index) => Padding(
                        padding: KEdgeInset.kH10,
                        child: Row(
                          children: <Widget>[
                            Container(
                              color: emotionScoreList[index].color,
                              width: 10.w,
                              height: 10.h,
                            ),
                            KSizedBox.w10,
                            KText.head5Text(text: emotionScoreList[index].title)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> createBarGroups(
      List<AnalyzeHistoryResponse> analyzeResultList) {
    return List.generate(analyzeResultList.length, (index) {
      final double value = index.toDouble();
      int perfomanceScore = analyzeResultList[index].performanceScore ?? 0;

      final Color barColor = getBarColorByValue(perfomanceScore);

      return BarChartGroupData(
        x: value.toInt() + 1,
        barRods: [
          BarChartRodData(
            width: 15.w,
            backDrawRodData: BackgroundBarChartRodData(show: false),
            color: barColor,
            toY: perfomanceScore.toDouble(),
          ),
        ],
      );
    });
  }

  List<EmotionScore> emotionScoreList = [
    EmotionScore(
      title: "Excellent",
      color: Colors.green,
      scoreLimit: 80,
    ),
    EmotionScore(
      title: "Good",
      color: Colors.yellow,
      scoreLimit: 60,
    ),
    EmotionScore(
      title: "Average",
      color: Colors.orange,
      scoreLimit: 40,
    ),
    EmotionScore(
      title: "Bad",
      color: Colors.red,
      scoreLimit: 0,
    ),
  ];

  Color getBarColorByValue(int score) {
    for (var emotionScore in emotionScoreList) {
      if (score >= emotionScore.scoreLimit) {
        return emotionScore.color;
      }
    }
    // Return a default color if no match is found
    return Colors.grey;
  }
}

class EmotionScore {
  final String title;
  final Color color;
  final int scoreLimit;

  EmotionScore({
    required this.title,
    required this.color,
    required this.scoreLimit,
  });
}
