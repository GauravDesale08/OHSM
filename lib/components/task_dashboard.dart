import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      progress: 0.3,
      dueDate: '14 July 2024, 05:00 PM',
      priority: 'High',
      priorityColor: Colors.red,
      status: 'In-progress',
    ),
    Task(
      taskName: 'Fire Place Check & Up...',
      category: 'Maintenance &...',
      assignee: 'Ranganathan',
      progress: 0.0,
      dueDate: '14 July 2024, 05:00 PM',
      priority: 'Low',
      priorityColor: Colors.green,
      status: 'To Do',
    ),
    Task(
      taskName: 'Room 303 Set Up',
      category: 'Housekeeping',
      assignee: 'Garima Bhatia',
      progress: 0.3,
      dueDate: '14 July 2024, 05:00 PM',
      priority: 'High',
      priorityColor: Colors.red,
      status: 'In-progress',
    ),
    Task(
      taskName: 'Fire Place Check & Up...',
      category: 'Maintenance &...',
      assignee: 'Ranganathan',
      progress: 0.0,
      dueDate: '14 July 2024, 05:00 PM',
      priority: 'Low',
      priorityColor: Colors.green,
      status: 'To Do',
    ),
    Task(
      taskName: 'Room 303 Set Up',
      category: 'Housekeeping',
      assignee: 'Garima Bhatia',
      progress: 0.3,
      dueDate: '14 July 2024, 05:00 PM',
      priority: 'High',
      priorityColor: Colors.red,
      status: 'Completed',
    ),
    Task(
      taskName: 'Fire Place Check & Up...',
      category: 'Maintenance &...',
      assignee: 'Ranganathan',
      progress: 0.0,
      dueDate: '14 July 2024, 05:00 PM',
      priority: 'Low',
      priorityColor: Colors.green,
      status: 'Overdue',
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Colors.green),
        title: Text(
          'Manage Tasks',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          Icon(Icons.search, color: Colors.green),
          SizedBox(width: 16),
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
            builder: (BuildContext context) => ChecklistBottomSheet(),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}