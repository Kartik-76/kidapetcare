import 'package:flutter/material.dart';

class PetScreen1 extends StatelessWidget {
  const PetScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              'https://images.pexels.com/photos/3715587/pexels-photo-3715587.jpeg?auto=compress&cs=tinysrgb&w=600'),
                        ),
                        const SizedBox(width: 10),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lunchiii',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Pro Account',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.menu, size: 30, color: Theme.of(context).iconTheme.color),
                  ],
                ),
                const SizedBox(height: 30),

                // Activity Summary Header
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Activity',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Summary',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Filter Tabs
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFilterTab(context, 'All', isActive: true),
                    _buildFilterTab(context, 'Activity'),
                    _buildFilterTab(context, 'Running'),
                    _buildFilterTab(context, 'Calories'),
                  ],
                ),
                const SizedBox(height: 30),

                // Summary Section with Circular Chart
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSummaryLabel('Target', '2350 Kcal', context),
                          _buildSummaryLabel('Consume', '1098 Kcal', context),
                          _buildSummaryLabel('Remaining', '234 Kcal', context),
                        ],
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: CustomPaint(
                          painter: CircularProgressPainter(),
                          child: const Center(
                            child: Text(
                              '75%',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Details Section with Calories and Exercise cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDetailCard(
                      context: context,
                      icon: Icons.local_fire_department,
                      label: 'Calories',
                      value: '234 Kcal',
                    ),
                    const SizedBox(width: 20),
                    _buildDetailCard(
                      context: context,
                      icon: Icons.fitness_center,
                      label: 'Exercise',
                      value: '120 Minutes',
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: _buildHamburgerIcon(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHamburgerIcon(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).cardColor,
        border: Border.all(color: Theme.of(context).iconTheme.color!, width: 2),
      ),
      child: Icon(Icons.menu, color: Theme.of(context).iconTheme.color),
    );
  }

  Widget _buildFilterTab(BuildContext context, String title, {bool isActive = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
    decoration: BoxDecoration(
      color: isActive ? Colors.amber : Colors.amber.shade200, // Amber color for active and inactive tabs
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      title,
      style: const TextStyle(
        color: Colors.white, // White text color for all tabs
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}


  Widget _buildSummaryLabel(String title, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(
      {required BuildContext context, required IconData icon, required String label, required String value}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.orange, size: 30),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value.split(' ')[0],
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  value.split(' ')[1],
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Painter for Circular Progress
// Custom Painter for Circular Progress
class CircularProgressPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24; // Further increase stroke width

    // Constants for data
    double totalValue = 2350;
    double consumeValue = 1098;
    double remainingValue = totalValue - consumeValue;
    double thirdValue = 234;

    // Calculated percentages
    double consumedPercentage = consumeValue / totalValue;
    double remainingPercentage = remainingValue / totalValue;
    double thirdPercentage = thirdValue / totalValue;

    // Small gap angle in radians
    const double gap = 6 * (3.14 / 180); // 6-degree gap between segments

    // Draw the consumed arc with a gap after it
    paint.color = Colors.orange;
    canvas.drawArc(
      Offset.zero & size,
      -90 * (3.14 / 180),
      (consumedPercentage * 360 - gap * (180 / 3.14)) * (3.14 / 180),
      false,
      paint,
    );

    // Draw the remaining arc with a gap after it
    paint.color = Colors.pink;
    canvas.drawArc(
      Offset.zero & size,
      (-90 + (consumedPercentage * 360) + gap) * (3.14 / 180),
      (remainingPercentage * 360 - gap * (180 / 3.14)) * (3.14 / 180),
      false,
      paint,
    );

    // Draw the third value arc with spacing
    paint.color = Colors.blue;
    canvas.drawArc(
      Offset.zero & size,
      (-90 + (consumedPercentage * 360) + (remainingPercentage * 360) + 2 * gap) * (3.14 / 180),
      (thirdPercentage * 360 - gap * (180 / 3.14)) * (3.14 / 180),
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

