import 'package:flutter/material.dart';

class ChecklistBottomSheet1 extends StatefulWidget {
  @override
  _ChecklistBottomSheet1State createState() => _ChecklistBottomSheet1State();
}

class _ChecklistBottomSheet1State extends State<ChecklistBottomSheet1> {
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskDetailsController = TextEditingController();
  final TextEditingController _scheduleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _assigneeController = TextEditingController();
  final TextEditingController _priorityController = TextEditingController();
  final TextEditingController _reminderController = TextEditingController();
  final TextEditingController _checklistController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController(text: '1000');
  final List<String> _checklistItems = [
    'Door mat & entrance to be cleaned',
    'Fan blades to be cleaned and no noise',
    'Working AC with remote',
    'Clean ceiling and floor',
    'Working bedside lights',
    'Pillows as per number of guests',
    'Clean blankets and duvets',
    'Fresh linen',
    'Tidy curtains & blinds',
    'Clean balcony, furniture & floor',
    'Stocked, clean dustbin',
  ];

  bool _isTaskDetailsExpanded = false;
  bool _isTaskAllotmentExpanded = false;
  bool _saveTemplate = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside of text fields
        FocusScope.of(context).unfocus();
      },
      child: DraggableScrollableSheet(
        initialChildSize: 1.0, // Initial size of the bottom sheet
        minChildSize: 0.9, // Minimum size of the bottom sheet
        maxChildSize: 1.0, // Maximum size of the bottom sheet
        builder: (BuildContext context, ScrollController scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
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
                        'New Task',
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
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _locationController,
                          decoration: InputDecoration(labelText: 'Location'),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _assigneeController,
                          decoration: InputDecoration(labelText: 'Assign To'),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _priorityController,
                          decoration: InputDecoration(labelText: 'Priority'),
                          onTap: () {
                            // Show Priority dialog
                            _showPriorityDialog();
                          },
                        ),
                        SizedBox(height: 8),
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
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.black),
                      SizedBox(width: 8),
                      Text(
                        'POINTS',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _pointsController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
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
                  SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _checklistItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.remove_circle, color: Colors.red),
                        title: Text(_checklistItems[index]),
                        trailing: Icon(Icons.warning_amber_rounded, color: Colors.grey),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Save this template',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Switch(
                        value: _saveTemplate,
                        onChanged: (value) {
                          setState(() {
                            _saveTemplate = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _saveTask();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Create Task',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded) child,
      ],
    );
  }

  void _saveTask() {
    // Implement your save task logic here
    Navigator.pop(context);
  }

  void _showPriorityDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Priority'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('High'),
                onTap: () {
                  setState(() {
                    _priorityController.text = 'High';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Medium'),
                onTap: () {
                  setState(() {
                    _priorityController.text = 'Medium';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Low'),
                onTap: () {
                  setState(() {
                    _priorityController.text = 'Low';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Checklist Bottom Sheet')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            var context;
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => ChecklistBottomSheet1(),
            );
          },
          child: Text('Show Bottom Sheet'),
        ),
      ),
    ),
  ));
}
