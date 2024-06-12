import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/components/new_bottomsheet.dart';
import 'package:task/components/task_card.dart';
import 'package:task/components/task_overview.dart';
import 'calendar_header.dart';
import 'checklist_bottom_sheet.dart';

class TaskDashboard extends StatefulWidget {
  @override
  _TaskDashboardState createState() => _TaskDashboardState();
}

class _TaskDashboardState extends State<TaskDashboard> {
  String selectedFilter = 'All';

  List<Task> allTasks = [
    Task(
      taskName: 'Room 303 Set Up',
      category: 'Housekeeping',
      assignee: 'Garima Bhatia',
      progress: 0.8,
      dueDate: '14 July 2024, 05:00 PM',
      priority: 'High',
      priorityColor: Colors.red,
      status: 'In-progress',
      categoryColor: Colors.blue,
    ),
    Task(
      taskName: 'Fire Place Check...',
      category: 'Maintenance &...',
      assignee: 'Ranganathan',
      progress: 0.0,
      dueDate: '14 July 2024, 05:00 PM',
      priority: 'Low',
      priorityColor: Colors.green,
      status: 'To Do',
      categoryColor: Colors.blue,
    ),
    Task(
      taskName: 'Room 303 Set Up',
      category: 'Housekeeping',
      assignee: 'Garima Bhatia',
      progress: 0.6,
      dueDate: '14 July 2024, 05:00 PM',
      priority: 'High',
      priorityColor: Colors.red,
      status: 'In-progress',
      categoryColor: Colors.blue,
    ),
    Task(
      taskName: 'Fire Place Check...',
      category: 'Maintenance &...',
      assignee: 'Ranganathan',
      progress: 0.0,
      dueDate: '14 July 2024, 05:00 PM',
      priority: 'Low',
      priorityColor: Colors.green,
      status: 'To Do',
      categoryColor: Colors.blue,
    ),
    Task(
      taskName: 'Room 303 Set Up',
      category: 'Housekeeping',
      assignee: 'Garima Bhatia',
      progress: 1.3,
      dueDate: '14 July 2024, 05:00 PM',
      priority: 'High',
      priorityColor: Colors.red,
      status: 'Completed',
      categoryColor: Colors.blue,
    ),
    Task(
      taskName: 'Fire Place Check...',
      category: 'Maintenance &...',
      assignee: 'Ranganathan',
      progress: 0.2,
      dueDate: '14 July 2024, 05:00 PM',
      priority: 'Low',
      priorityColor: Colors.green,
      status: 'Overdue',
      categoryColor: Colors.blue,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<Task> filteredTasks = allTasks.where((task) {
      if (selectedFilter == 'All') return true;
      return task.status == selectedFilter;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {
            // Add your back button action here
          },
        ),
        title: Row(
          children: [
            Text(
              'Manage Tasks',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.info_outline, color: Colors.green, size: 20,),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              // Add your incident log action here
            },
            icon: Icon(Icons.warning, color: Colors.white, size: 15,),
            label: Text(
              'Incident Logs',
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.green),
            onPressed: () {
              // Add your search action here
            },
          ),
          SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CalendarHeader(),
            TaskOverview(
              selectedFilter: selectedFilter,
              onFilterSelected: (filter) {
                setState(() {
                  selectedFilter = filter;
                });
              },
            ),
            ...filteredTasks.map((task) => TaskCard(task: task)).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) => ChecklistBottomSheet1(),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
      ),
    );
  }
}
