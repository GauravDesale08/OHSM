import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({required this.task});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'overdue':
        return Colors.red;
      case 'to do':
        return Colors.yellow;
      case 'in-progress':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color statusColor = _getStatusColor(task.status);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.warning, // Adjust icon based on task category
                      color: task.categoryColor,
                      size: 24,
                    ),
                    SizedBox(width: 8),
                    Text(
                      task.taskName,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: task.priorityColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.signal_cellular_alt,
                            color: task.priorityColor,
                            size: 12,
                          ),
                          SizedBox(width: 4),
                          Text(
                            task.priority,
                            style: TextStyle(
                              color: task.priorityColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        // Add action for View More
                      },
                      child: Text(
                        'View More',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            TaskDetailRow(
              icon: Icons.label,
              text: task.category,
              iconColor: task.categoryColor,
            ),
            SizedBox(height: 8),
            TaskDetailRow(
              icon: Icons.person,
              text: task.assignee,
              iconColor: Colors.green,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Progress status: ${(task.progress * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    color: task.progress == 1.0 ? Colors.green : Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  task.dueDate,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 4,
                    color: Colors.grey[200],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 4,
                    width: MediaQuery.of(context).size.width * 0.7 * task.progress,
                    color: statusColor,
                  ),
                ),
                Row(
                  children: List.generate(
                    5,
                        (index) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: index < (task.progress * 5).ceil()
                              ? statusColor
                              : Colors.grey[200],
                          child: Icon(
                            Icons.check,
                            color: index < (task.progress * 5).ceil()
                                ? Colors.white
                                : Colors.grey,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  task.status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Add action for Done button
                  },
                  icon: Icon(Icons.check, size: 14),
                  label: Text('Done'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.grey, // foreground
                    textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
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

class TaskDetailRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  TaskDetailRow({
    required this.icon,
    required this.text,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 14),
        SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}

class Task {
  final String taskName;
  final String category;
  final String assignee;
  final double progress;
  final String dueDate;
  final String priority;
  final Color priorityColor;
  final Color categoryColor;
  final String status;

  Task({
    required this.taskName,
    required this.category,
    required this.assignee,
    required this.progress,
    required this.dueDate,
    required this.priority,
    required this.priorityColor,
    required this.categoryColor,
    required this.status,
  });
}
