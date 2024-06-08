import 'package:flutter/material.dart';

class ChecklistBottomSheet extends StatefulWidget {
  @override
  _ChecklistBottomSheetState createState() => _ChecklistBottomSheetState();
}

class _ChecklistBottomSheetState extends State<ChecklistBottomSheet> {
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskDetailsController = TextEditingController();
  final TextEditingController _scheduleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priorityController = TextEditingController();
  final TextEditingController _reminderController = TextEditingController();
  final TextEditingController _checklistController = TextEditingController();
  final List<String> _checklistItems = [];

  bool _isTaskDetailsExpanded = false;
  bool _isTaskAllotmentExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the bottom sheet
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Text(
                  'Task',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    _saveTask();
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
            Divider(height: 20, color: Colors.grey),
            _buildExpandableSection(
              title: 'Task Details',
              isExpanded: _isTaskDetailsExpanded,
              onTap: () {
                setState(() {
                  _isTaskDetailsExpanded = !_isTaskDetailsExpanded;
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Task Category'),
                    items: ['Category 1', 'Category 2', 'Category 3']
                        .map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      // Handle dropdown value change
                    },
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _taskTitleController,
                    decoration: InputDecoration(labelText: 'Task Title'),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _taskDetailsController,
                    decoration: InputDecoration(labelText: 'Task Details'),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            _buildExpandableSection(
              title: 'Task Allotment',
              isExpanded: _isTaskAllotmentExpanded,
              onTap: () {
                setState(() {
                  _isTaskAllotmentExpanded = !_isTaskAllotmentExpanded;
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _scheduleController,
                    decoration: InputDecoration(labelText: 'Schedule'),
                    onTap: () async {
                      // Show Date picker and assign selected date to the schedule field
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null) {
                        setState(() {
                          _scheduleController.text =
                          "${picked.month}/${picked.day}/${picked.year}";
                        });
                      }
                    },
                  ),
                  TextFormField(
                    controller: _locationController,
                    decoration: InputDecoration(labelText: 'Location'),
                  ),
                  TextFormField(
                    controller: _priorityController,
                    decoration: InputDecoration(labelText: 'Priority'),
                    onTap: () {
                      // Show Priority dialog
                      _showPriorityDialog();
                    },
                  ),
                  TextFormField(
                    controller: _reminderController,
                    decoration: InputDecoration(labelText: 'Reminder'),
                    onTap: () async {
                      // Show Time picker and assign selected time to the reminder field
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        setState(() {
                          _reminderController.text = picked.format(context);
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _checklistController,
              decoration: InputDecoration(
                labelText: 'Type here & Add Checklist',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      if (_checklistController.text.isNotEmpty) {
                        _checklistItems.add(_checklistController.text);
                        _checklistController.clear();
                      }
                    });
                  },
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _checklistItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.circle_outlined),
                  title: Text(_checklistItems[index]),
                );
              },
            ),
            SizedBox(height: 16.0), // Added spacing
            ElevatedButton(
              // Save button
              onPressed: () {
                _saveTask();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
              ),
              child: Text('Save Checklist'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Icon(
                isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: Colors.blue,
              ),
            ],
          ),
        ),
        if (isExpanded) SizedBox(height: 8),
        if (isExpanded) child,
        SizedBox(height: 16),
        Divider(height: 1, color: Colors.grey),
      ],
    );
  }

  void _saveTask() {
    // Handle save action
    Navigator.pop(context); // Close the bottom sheet after saving
  }

  void _showPriorityDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Simple dialog with priority options
        return AlertDialog(
          title: Text('Select Priority'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPriorityOption('Low'),
              _buildPriorityOption('Medium'),
              _buildPriorityOption('High'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPriorityOption(String priority) {
    return ListTile(
      title: Text(priority),
      onTap: () {
        setState(() {
          _priorityController.text = priority;
        });
        Navigator.pop(context); // Close the dialog
      },
    );
  }
}
