
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todoapidemo/utils/notification.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;

  const AddTodoPage({Key? key, this.todo}) : super(key: key);

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;
  Notifications notifications = Notifications();
  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  Future<void> updateData() async {
    if (_formKey.currentState!.validate()) {
      final todo = widget.todo;
      if (todo == null) {
        print('you can not call update without data');
        return;
      }
      final id = todo['_id'];
      final title = titleController.text;
      final description = descriptionController.text;
      final body = {
        "title": title,
        "description": description,
        "is_completed": false
      };

      final url = 'https://api.nstack.in/v1/todos/$id';
      final uri = Uri.parse(url);

      final response = await http.put(
        uri,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        showSuccessMessage('Update success');
      } else {
        showErrorMessage('Updation Failed');
        print(response.body);
      }
    }
  }

  Future<void> submitData() async {
    if (_formKey.currentState!.validate()) {
      final title = titleController.text;
      final description = descriptionController.text;
      final body = {
        "title": title,
        "description": description,
        "is_completed": false
      };

      final url = 'https://api.nstack.in/v1/todos';
      final uri = Uri.parse(url);

      final response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        titleController.text = '';
        descriptionController.text = '';
        Notifications.showNotification();
        showSuccessMessage('Creation success');
      } else {
        showErrorMessage('Creation Failed');
        print(response.body);
      }
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(99.0),
          child: Text(isEdit ? 'Edit Todo' : 'Add Todo',style: TextStyle(fontFamily: 'Poppins'),),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          // Dismiss the keyboard when tapping outside the TextField
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  textCapitalization: TextCapitalization.sentences,
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Title',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.grey), // Border color when not focused
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.white), // Border color when focused
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.red), // Border color when in error state
                    ),

                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  textCapitalization: TextCapitalization.sentences,
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description is required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.multiline,
                  minLines: 5,
                  maxLines: 8,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.grey), // Border color when not focused
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.white), // Border color when focused
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.red), // Border color when in error state
                    ),
                ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isEdit ? updateData : submitData,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.all(18.0),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  child: Text(isEdit ? 'Update' : 'Submit',style: TextStyle(fontFamily: 'Poppins',fontSize: 17)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
