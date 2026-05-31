import 'package:flutter/material.dart';

class DashboardCard extends StatefulWidget {

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {

  bool isHovered = false;

  @override
  Widget build(BuildContext context) {

    return MouseRegion(

      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },

      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },

      child: GestureDetector(

        onTap: widget.onTap,

        child: AnimatedContainer(

          duration: const Duration(milliseconds: 300),

          transform: Matrix4.identity()
            ..scale(isHovered ? 1.03 : 1.0),

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(24),

            boxShadow: [

              BoxShadow(
                color: Colors.black.withOpacity(
                  isHovered ? 0.15 : 0.05,
                ),
                blurRadius: isHovered ? 20 : 10,
                offset: const Offset(0, 8),
              ),
            ],
          ),

          child: Card(

            elevation: 0,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),

            child: Padding(

              padding: const EdgeInsets.all(18),

              child: Row(

                children: [

                  Container(

                    padding: const EdgeInsets.all(14),

                    decoration: BoxDecoration(
                      color: widget.color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Icon(
                      widget.icon,
                      color: widget.color,
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 20),

                  Expanded(

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [

                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          widget.subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}