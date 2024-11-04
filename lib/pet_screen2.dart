import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PetScreen2 extends StatelessWidget {
  const PetScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111214), // Dark background color
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.upload, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Walking Steps Section
            Row(
              children: [
                const Icon(Icons.directions_walk, color: Colors.orangeAccent),
                const SizedBox(width: 8),
                const Text(
                  'Walking Steps',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'Today',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(Icons.keyboard_arrow_down, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Walking Steps Bar Graph
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment:
                  CrossAxisAlignment.end, // Align bars to the bottom
              children: [
                _buildStepBar('1000', 0.3, Colors.grey[800]!),
                _buildStepBar('1300', 0.5, Colors.grey[800]!),
                _buildStepBar(
                    '2100', 0.7, Colors.amber), // Active bar in purple
                _buildStepBar('900', 0.2, Colors.grey[800]!),
                _buildStepBar('1200', 0.4, Colors.grey[800]!),
              ],
            ),
            const SizedBox(height: 20),
            // Heart Rate Section
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1C1D21),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Center items vertically
                    children: [
                      const Text(
                        'Heart rate',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const Spacer(),
                      Center(
                          child:
                              _buildHeartRateGraph()), // Center the graph vertically
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '150 bpm',
                    style: TextStyle(color: Colors.orange, fontSize: 24),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // My Goals Section
            // My Goals Section
Container(
  width: double.infinity,
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.amber,
    borderRadius: BorderRadius.circular(10),
  ),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start, // Align text to the top
    children: [
      // Column for text
      const Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
          children: [
            Text(
              'My Goals',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Keep it up, you can achieve your goals.',
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.left, // Align text to the left
            ),
          ],
        ),
      ),
      // Circular progress indicator
      Stack(
        alignment: Alignment.center,
        children: [
          // Background arc
          CircularPercentIndicator(
            radius: 40.0, // Outer radius for the background arc
            lineWidth: 15.0, // Same width for the background arc
            percent: 1.0, // Full arc for background
            center: const Text(
              "", // Empty center for background
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            progressColor: Colors.transparent, // No color for progress
            backgroundColor: Colors.purple[700]!, // Background arc color
          ),
          // Progress arc
          CircularPercentIndicator(
            radius: 40.0, // Inner radius for the progress arc
            lineWidth: 15.0, // Same width for the progress arc
            percent: 0.45, // Progress percentage
            center: const Text(
              "45%",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            progressColor: Colors.white, // Progress arc color
            backgroundColor: Colors.transparent, // No background for the progress arc
          ),
        ],
      ),
    ],
  ),
),

          ],
        ),
      ),
    );
  }

  Widget _buildStepBar(String label, double heightFactor, Color color) {
    const double baseHeight = 120.0;
    const double barWidth = 50.0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end, // Align text to bottom
      children: [
        Container(
          width: barWidth,
          height: baseHeight * heightFactor,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeartRateGraph() {
    return Row(
      mainAxisSize: MainAxisSize.min, // Only take as much space as needed
      children: List.generate(10, (index) {
        double height =
            (index % 2 == 0) ? 30.0 : 50.0; // Variable heights for effect
        return Container(
          width: 8, // Increased width for better visibility
          height: height,
          margin: const EdgeInsets.symmetric(horizontal: 4), // Increase spacing
          color: Colors.orange,
        );
      }),
    );
  }
}
