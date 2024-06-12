import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TaskOverview extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterSelected;

  TaskOverview({
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    'Task Overview',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.pink,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Text(
                      'My SOP\'s',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TaskStatusCard(
                  label: 'To Do',
                  count: 16,
                  color: Colors.yellow,
                  isSelected: selectedFilter == 'To Do',
                  onTap: () => onFilterSelected('To Do'),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: TaskStatusCard(
                  label: 'Overdue',
                  count: 16,
                  color: Colors.red,
                  isSelected: selectedFilter == 'Overdue',
                  onTap: () => onFilterSelected('Overdue'),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TaskStatusCard(
                  label: 'In-progress',
                  count: 16,
                  color: Colors.orange,
                  isSelected: selectedFilter == 'In-progress',
                  onTap: () => onFilterSelected('In-progress'),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: TaskStatusCard(
                  label: 'Completed',
                  count: 16,
                  color: Colors.green,
                  isSelected: selectedFilter == 'Completed',
                  onTap: () => onFilterSelected('Completed'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class TaskStatusCard extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  TaskStatusCard({
    required this.label,
    required this.count,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.circle,
                  color: color,
                  size: 12,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    label,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Text(
                  count.toString(),
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}