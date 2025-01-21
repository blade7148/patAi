// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:petai/view_models/ai_controller.dart';
// import 'package:petai/views/pages/home_page.dart';

// class AnalysisResultWidget extends StatelessWidget {
//   const AnalysisResultWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Analysis Result'),
//         backgroundColor: Colors.deepOrangeAccent,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Get.offAll(() => const HomePage());
//           },
//         ),
//       ),
//       body: Obx(
//         () => SingleChildScrollView(
//           child: Card(
//             elevation: 0,
//             color: Colors.transparent,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "${'ai_name'.tr}:",
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20,
//                     ),
//                   ),
//                   // Markdown(
//                   //   shrinkWrap: true,
//                   //   physics: const NeverScrollableScrollPhysics(),
//                   //   data: Get.find<AIController>().aiResponse,
//                   // ),
//                   Text(
//                     Get.find<AIController>().aiResponse,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: Colors.black87,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petai/models/pet_analysis.dart';

import 'package:petai/view_models/ai_controller.dart';
import 'package:petai/views/pages/home_page.dart';

class PetAnalysis extends StatelessWidget {
  const PetAnalysis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final response = Get.find<AIController>().aiResponse;

      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Handle back button press
              Get.offAll(() => const HomePage());
            },
          ),
          title: Text(
              'Analysis Result • ${response.define?.breed ?? 'Unknown Pet'}'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pet • ${response.define?.breed ?? 'Unknown Pet'}',
                      style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 16),

                  // Tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildTag(
                          Icons.pets,
                          response.define?.characteristics?.size ??
                              'Unknown Size'),
                      _buildTag(
                          Icons.monitor_weight,
                          response.define?.characteristics?.weight == 'null'
                              ? 'Unknown Weight'
                              : '${response.define?.characteristics?.weight} kg'),
                      _buildTag(Icons.calendar_today,
                          response.define?.age ?? 'Unknown Age'),
                    ],
                  ),
                  const SizedBox(height: 16),

                  if (response.check?.medicalConditions?[0] != 'null')
                    _buildAlertCard(),

                  const SizedBox(height: 16),

                  // About section
                  _buildSectionCard(
                    'About',
                    '${response.define?.characteristics?.uniqueFeatures?.join(', ') ?? "No unique features available"}. '
                        '${response.define?.breed ?? 'This breed'} is known for its '
                        '${response.define?.characteristics?.uniqueFeatures?.firstOrNull?.toLowerCase() ?? 'unique'} '
                        'nature and makes an excellent family pet.',
                  ),
                  const SizedBox(height: 16),

                  // Details section
                  _buildDetailsCard(response),
                  const SizedBox(height: 16),

                  // Characteristics section
                  _buildCharacteristicsCard(response),
                  const SizedBox(height: 16),

                  // Health Issues section
                  _buildHealthIssuesCard(response),
                  const SizedBox(height: 16),

                  // Care Suggestions section
                  _buildCareSuggestionsCard(response),
                  const SizedBox(height: 16),

                  // Conclusion section
                  _buildConclusionCard(response),
                  const SizedBox(height: 16),

                  // Disclaimer
                  _buildDisclaimerCard(response),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomButton(),
      );
    });
  }

  Widget _buildTag(IconData icon, String? text) {
    if (text == null) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildAlertCard() {
    return Card(
      color: Colors.red[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.warning, color: Colors.red),
                SizedBox(width: 8),
                Text('Your pet may need attention!',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
                'Regular check-ups are important for your pet\'s health.'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Get More Info'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, String content) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(content),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard(AnalyzeModel resp) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildDetailRow(Icons.thermostat, 'Temperature',
                resp.check?.temperatureFit ?? 'No temperature information'),
            _buildDetailRow(
                Icons.pets, 'Breed', resp.define?.breed ?? 'Unknown Breed'),
            _buildDetailRow(Icons.color_lens, 'Fur Color',
                resp.define?.characteristics?.furColor ?? 'Unknown Color'),
            _buildDetailRow(
              Icons.toys,
              'Toys',
              resp.check?.toys ?? 'No toy recommendations',
            ),
            _buildDetailRow(
              Icons.restaurant,
              'Nutrition',
              resp.check?.nutritionAndDiet ?? 'No nutrition information',
            ),
            _buildDetailRow(
              Icons.home,
              'Environment',
              resp.check?.environment ?? 'No environment information',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCharacteristicsCard(AnalyzeModel resp) {
    List<dynamic>? features = resp.define?.characteristics?.uniqueFeatures;

    if (features == null || features.isEmpty) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Characteristics',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...features
                .map((feature) =>
                    _buildDetailRow(Icons.check_circle, feature, ''))
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthIssuesCard(AnalyzeModel resp) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Health Issues',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildDetailRow(
                Icons.medical_services,
                'Medical Conditions',
                resp.check?.medicalConditions?[0] == 'null'
                    ? 'No known conditions'
                    : resp.check?.medicalConditions?.join(', ')),
            _buildDetailRow(
                Icons.psychology,
                'Psychological Behaviors',
                resp.check?.psychologicalBehaviors?[0] == 'null'
                    ? 'No known behaviors'
                    : resp.check?.psychologicalBehaviors?.join(', ')),
            _buildDetailRow(
                Icons.warning,
                'Common Issues',
                resp.define?.characteristics?.commonIssues?.join(', ') ??
                    'No known issues'),
          ],
        ),
      ),
    );
  }

  Widget _buildCareSuggestionsCard(AnalyzeModel resp) {
    List<dynamic>? suggestions = resp.check?.careSuggestions;
    if (suggestions == null || suggestions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Care Suggestions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            if (suggestions[0] != 'null')
              ...suggestions
                  .map((suggestion) =>
                      _buildDetailRow(Icons.lightbulb, suggestion, ''))
                  .toList(),
            _buildDetailRow(Icons.sports_esports, 'Entertainment',
                resp.check?.entertainment ?? 'No entertainment suggestions'),
          ],
        ),
      ),
    );
  }

  Widget _buildConclusionCard(AnalyzeModel resp) {
    String? conclusion = resp.conclusion;
    if (conclusion == null) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Conclusion',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(conclusion),
          ],
        ),
      ),
    );
  }

  Widget _buildDisclaimerCard(AnalyzeModel resp) {
    String? disclaimer = resp.disclaimer;
    if (disclaimer == null) return const SizedBox.shrink();

    return Card(
      color: Colors.yellow[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Disclaimer',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(disclaimer),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String? description) {
    if (description == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: Colors.blue),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                if (description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(description),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_a_photo),
            SizedBox(width: 8),
            Text('Add to My Pets'),
          ],
        ),
      ),
    );
  }
}
