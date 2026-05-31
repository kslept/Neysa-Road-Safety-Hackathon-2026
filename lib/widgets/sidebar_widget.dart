import 'package:flutter/material.dart';

class SidebarWidget extends StatelessWidget {

  final int selectedIndex;
  final Function(int) onItemSelected;

  const SidebarWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  Widget buildItem({
    required IconData icon,
    required String title,
    required int index,
  }) {

    final bool isSelected = selectedIndex == index;

    return GestureDetector(

      onTap: () => onItemSelected(index),

      child: Container(

        margin: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),

        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),

        decoration: BoxDecoration(
          color: isSelected
              ? Colors.deepPurple
              : Colors.transparent,

          borderRadius: BorderRadius.circular(14),
        ),

        child: Row(
          children: [

            Icon(
              icon,
              color: isSelected
                  ? Colors.white
                  : Colors.black87,
            ),

            const SizedBox(width: 14),

            Text(
              title,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : Colors.black87,

                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;

    return Container(

      width: screenWidth > 1400
          ? 280
          : screenWidth > 1000
          ? 240
          : 220,

      color: Colors.white,

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          const SizedBox(height: 40),

          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'NEYSA',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ),

          const SizedBox(height: 20),

          buildItem(
            icon: Icons.dashboard,
            title: 'Dashboard',
            index: 0,
          ),

          buildItem(
            icon: Icons.analytics,
            title: 'Analytics',
            index: 1,
          ),

          buildItem(
            icon: Icons.people,
            title: 'Users',
            index: 2,
          ),

          buildItem(
            icon: Icons.settings,
            title: 'Settings',
            index: 3,
          ),
        ],
      ),
    );
  }
}