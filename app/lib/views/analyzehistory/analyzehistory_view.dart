import 'package:flutter/material.dart';
import 'package:app/controller/analyze/analyze_controller.dart';
import 'package:app/models/analyze/analyze_history.dart';
import 'package:app/views/common/text_widgets.dart';
import 'package:get/get.dart';

class AnalysisHistoryView extends StatelessWidget {
  const AnalysisHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: KText.head5Text(text: "Analyze History"),
      ),
      body: GetX<AnalyzeController>(
        init: AnalyzeController(),
        initState: (_) {
          _.controller?.getAnalyzeHistory();
        },
        builder: (_) {
          final analyzeHistoryList = _.analyzeHistoryResponse.reversed.toList();

          return ListView.builder(
            itemCount: analyzeHistoryList.length,
            itemBuilder: (context, index) {
              return _buildAnalysisCard(context, analyzeHistoryList[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildAnalysisCard(
      BuildContext context, AnalyzeHistoryResponse analysisData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          leading: _buildThumbnail(analysisData.video ?? ""),
          title: Text("Video ID: ${analysisData.id}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4.0),
              Text("Voice Emotion: ${analysisData.voiceEmotion}"),
              Text("Face Emotion: ${analysisData.faceEmotion}"),
              const SizedBox(height: 4.0),
              Text("Feedback: ${analysisData.feedback}"),
              const SizedBox(height: 4.0),
              Text("Additional Feedback: ${analysisData.additionalFeedback}"),
              const SizedBox(height: 4.0),
              Text("Date: ${analysisData.createdAt}"),
            ],
          ),
          onTap: () {
            // Handle tap, e.g., navigate to a detailed view
          },
        ),
      ),
    );
  }

  Widget _buildThumbnail(String videoPath) {
    // Replace this with your logic to get or generate a video thumbnail
    return Container(
      width: 50.0,
      height: 50.0,
      color: Colors.grey, // Placeholder color
      // You can use a package like cached_network_image to load thumbnails from a URL
      // child: CachedNetworkImage(
      //   imageUrl: yourThumbnailUrl,
      //   fit: BoxFit.cover,
      //   placeholder: (context, url) => CircularProgressIndicator(),
      //   errorWidget: (context, url, error) => Icon(Icons.error),
      // ),
    );
  }
}
