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

      // Check if the entire response is null or empty
      if (response.define == null &&
          response.check == null &&
          response.conclusion == null) {
        // Show error dialog and navigate back
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.back();
          Get.defaultDialog(
            title: 'Something went wrong',
            middleText: 'Failed to generate pet analysis. Please try again.',
            textConfirm: 'OK',
            confirmTextColor: Colors.white,
            onConfirm: () {
              Get.back();
            },
          );
        });
      }

      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Analysis Result • ${response.pet?.name ?? 'Unknown Name'}',
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (response.define?.breed != null) ...[
                    Text('Pet • ${response.define!.breed}',
                        style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 16),
                  ],

                  // Tags
                  if (response.define?.characteristics != null) ...[
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (response.define?.characteristics?.size != null)
                          _buildTag(Icons.pets,
                              response.define?.characteristics?.size),
                        if (response.define?.characteristics?.weight != null &&
                            response.define?.characteristics?.weight != 'null')
                          _buildTag(Icons.monitor_weight,
                              '${response.define?.characteristics?.weight} kg'),
                        if (response.define?.age != null)
                          _buildTag(Icons.calendar_today, response.define?.age),
                      ],
                    ),
                  ],

                  // if (response.check?.medicalConditions?[0] != 'null')
                  //   _buildAlertCard(),

                  const SizedBox(height: 16),

                  // About section
                  if (response.define?.characteristics?.uniqueFeatures !=
                          null &&
                      response.define!.characteristics!.uniqueFeatures!
                          .isNotEmpty &&
                      response.define!.characteristics!.uniqueFeatures![0] !=
                          'null')
                    _buildSectionCard(
                      'About',
                      '${response.define?.breed ?? 'This breed'} is known for its '
                          '${response.define!.characteristics!.uniqueFeatures!.join(', ')}.',
                    ),
                  const SizedBox(height: 16),

                  // Details section
                  if (response.check != null) _buildDetailsCard(response),
                  const SizedBox(height: 16),

                  // Characteristics section
                  if (response.define?.characteristics != null)
                    _buildCharacteristicsCard(response),
                  const SizedBox(height: 16),

                  // Health Issues section
                  if (response.check != null ||
                      response.define?.characteristics?.commonIssues != null)
                    _buildHealthIssuesCard(response),
                  const SizedBox(height: 16),

                  // Care Suggestions section
                  if (response.check?.careSuggestions != null)
                    _buildCareSuggestionsCard(response),
                  const SizedBox(height: 16),

                  // Conclusion section
                  if (response.conclusion != null)
                    _buildConclusionCard(response),
                  const SizedBox(height: 16),

                  // Disclaimer
                  if (response.disclaimer != null)
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
    if (text == null || text == 'null') return const SizedBox.shrink();
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
    if (content.isEmpty) return const SizedBox.shrink();
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
    if (resp.check == null) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            if (resp.check?.temperatureFit != null &&
                resp.check?.temperatureFit != 'null')
              _buildDetailRow(
                  Icons.thermostat, 'Temperature', resp.check!.temperatureFit!),
            if (resp.define?.breed != null && resp.define?.breed != 'null')
              _buildDetailRow(Icons.pets, 'Breed', resp.define!.breed!),
            if (resp.define?.characteristics?.furColor != null &&
                resp.define?.characteristics?.furColor != 'null')
              _buildDetailRow(Icons.color_lens, 'Fur Color',
                  resp.define!.characteristics!.furColor!),
            if (resp.check?.toys != null && resp.check?.toys != 'null')
              _buildDetailRow(Icons.toys, 'Toys', resp.check!.toys!),
            if (resp.check?.nutritionAndDiet != null &&
                resp.check?.nutritionAndDiet != 'null')
              _buildDetailRow(
                  Icons.restaurant, 'Nutrition', resp.check!.nutritionAndDiet!),
            if (resp.check?.environment != null &&
                resp.check?.environment != 'null')
              _buildDetailRow(
                  Icons.home, 'Environment', resp.check!.environment!),
          ],
        ),
      ),
    );
  }

  Widget _buildCharacteristicsCard(AnalyzeModel resp) {
    final features = resp.define?.characteristics;
    if (features == null) return const SizedBox.shrink();

    final Map<String, dynamic> characteristics = {
      'Fur Color': features.furColor,
      'Size': features.size,
      'Weight': features.weight,
      'Unique Features': features.uniqueFeatures?.join(', ') ?? '',
    };
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Characteristics',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...characteristics.entries
                .map((entry) =>
                    _buildDetailRow(Icons.check_circle, entry.key, entry.value))
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthIssuesCard(AnalyzeModel resp) {
    if ((resp.check?.medicalConditions == null ||
            resp.check!.medicalConditions![0] == 'null') &&
        (resp.check?.psychologicalBehaviors == null ||
            resp.check!.psychologicalBehaviors![0] == 'null') &&
        (resp.define?.characteristics?.commonIssues == null ||
            resp.define!.characteristics!.commonIssues![0] == 'null')) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Health Issues',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            if (resp.check?.medicalConditions != null &&
                resp.check!.medicalConditions![0] != 'null')
              _buildDetailRow(Icons.medical_services, 'Medical Conditions',
                  resp.check!.medicalConditions!.join(', ')),
            if (resp.check?.psychologicalBehaviors != null &&
                resp.check!.psychologicalBehaviors![0] != 'null')
              _buildDetailRow(Icons.psychology, 'Psychological Behaviors',
                  resp.check!.psychologicalBehaviors!.join(', ')),
            if (resp.define?.characteristics?.commonIssues != null &&
                resp.define!.characteristics!.commonIssues![0] != 'null')
              _buildDetailRow(Icons.warning, 'Common Issues',
                  resp.define!.characteristics!.commonIssues!.join(', ')),
          ],
        ),
      ),
    );
  }

  Widget _buildCareSuggestionsCard(AnalyzeModel resp) {
    List<dynamic>? suggestions = resp.check?.careSuggestions;
    if (suggestions == null ||
        suggestions.isEmpty ||
        suggestions[0] == 'null') {
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
            ...suggestions
                .map((suggestion) =>
                    _buildDetailRow(Icons.lightbulb, suggestion, ''))
                .toList(),
            if (resp.check?.entertainment != null &&
                resp.check?.entertainment != 'null')
              _buildDetailRow(Icons.sports_esports, 'Entertainment',
                  resp.check!.entertainment!),
          ],
        ),
      ),
    );
  }

  Widget _buildConclusionCard(AnalyzeModel resp) {
    if (resp.conclusion == null || resp.conclusion!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Conclusion',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(resp.conclusion!),
          ],
        ),
      ),
    );
  }

  Widget _buildDisclaimerCard(AnalyzeModel resp) {
    if (resp.disclaimer == null || resp.disclaimer!.isEmpty) {
      return const SizedBox.shrink();
    }

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
            Text(resp.disclaimer!),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String? description) {
    if (description == null ||
        title.isEmpty ||
        description.isEmpty ||
        description == 'null') {
      return const SizedBox.shrink();
    }

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
