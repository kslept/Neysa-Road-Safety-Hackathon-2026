import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../analytics_data.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xfff5f5f5),

      appBar: AppBar(
        title: const Text('Analytics'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      body: Center(

        child: ConstrainedBox(

          constraints: const BoxConstraints(
            maxWidth: 1200,
          ),

          child: SingleChildScrollView(

            padding: const EdgeInsets.all(24),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                const Text(
                  'Emergency Response Analytics 🚨',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  'Live emergency-response monitoring insights and system intelligence.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade700,
                  ),
                ),

                const SizedBox(height: 40),

                Container(

                  height: 400,
                  padding: const EdgeInsets.all(24),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),

                  child: LineChart(

                    LineChartData(

                      gridData: FlGridData(
                        show: true,
                      ),

                      borderData: FlBorderData(
                        show: false,
                      ),

                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                          ),
                        ),

                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 32,
                          ),
                        ),
                      ),

                      lineBarsData: [

                        LineChartBarData(

                          isCurved: true,

                          gradient: const LinearGradient(

                            colors: [

                              Colors.green,

                              Colors.orange,

                              Colors.red,
                            ],
                          ),

                          barWidth: 4,

                          spots:  [

                            FlSpot(
                              0,
                              AnalyticsData.monitoringSessions.toDouble(),
                            ),

                            FlSpot(
                              1,
                              AnalyticsData.accidentsDetected.toDouble(),
                            ),

                            FlSpot(
                              2,
                              AnalyticsData.emergencyAlerts.toDouble(),
                            ),

                            FlSpot(
                              3,
                              AnalyticsData.falsePositives.toDouble(),
                            ),

                            FlSpot(
                              4,
                              (
                                  AnalyticsData.accidentsDetected +
                                      AnalyticsData.emergencyAlerts
                              ).toDouble(),
                            ),

                            FlSpot(
                              5,
                              (
                                  AnalyticsData.monitoringSessions +
                                      AnalyticsData.falsePositives
                              ).toDouble(),
                            ),

                            FlSpot(
                              6,
                              (
                                  AnalyticsData.monitoringSessions +
                                      AnalyticsData.accidentsDetected +
                                      AnalyticsData.emergencyAlerts
                              ).toDouble(),
                            ),
                          ],

                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.deepPurple.withOpacity(0.15),
                          ),

                          dotData: FlDotData(
                            show: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                Row(

                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,

                  children: [

                    buildLegendItem(
                      Colors.green,
                      'Monitoring',
                    ),

                    buildLegendItem(
                      Colors.red,
                      'Accidents',
                    ),

                    buildLegendItem(
                      Colors.blue,
                      'Alerts',
                    ),

                    buildLegendItem(
                      Colors.orange,
                      'False Positives',
                    ),
                  ],
                ),

                Column(

                  children: [

                    Row(

                      children: [

                        Expanded(
                          child: buildMetricCard(
                            title: 'Accidents Detected',
                            value:
                            '${AnalyticsData.accidentsDetected}',
                            color: Colors.red,
                            icon: Icons.warning,
                          ),
                        ),

                        const SizedBox(width: 20),

                        Expanded(
                          child: buildMetricCard(
                            title: 'Emergency Alerts',
                            value:
                            '${AnalyticsData.emergencyAlerts}',
                            color: Colors.blue,
                            icon: Icons.notifications_active,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Row(

                      children: [

                        Expanded(
                          child: buildMetricCard(
                            title: 'Monitoring Sessions',
                            value:
                            '${AnalyticsData.monitoringSessions}',
                            color: Colors.green,
                            icon: Icons.analytics,
                          ),
                        ),

                        const SizedBox(width: 20),

                        Expanded(
                          child: buildMetricCard(
                            title: 'False Positives',
                            value:
                            '${AnalyticsData.falsePositives}',
                            color: Colors.orange,
                            icon: Icons.check_circle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMetricCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {

    return Container(

      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        children: [

          Container(
            padding: const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),

            child: Icon(
              icon,
              color: color,
              size: 30,
            ),
          ),

          const SizedBox(width: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                value,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget buildLegendItem(
      Color color,
      String label) {

    return Row(

      children: [

        Container(

          width: 16,
          height: 16,

          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),

        const SizedBox(width: 8),

        Text(

          label,

          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}