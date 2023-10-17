import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todoapidemo/screens/add_page.dart';
import 'package:http/http.dart' as http;
import 'package:todoapidemo/services/todo_service.dart';

import '../utils/Snackbar_helper.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  bool isLoading = true;
  List items = [];

  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(child: Text('Todo List')),
      ),
      body: Visibility(
        visible: isLoading,
        child: Center(child: CircularProgressIndicator(),),
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement:Center(child: Text('No Todo Item',style: Theme.of(context).textTheme.headline3,),) ,
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index] as Map;
                  final id = item['_id'] as String;
                  return Card(
                    child: ListTile(
                      leading:CircleAvatar(child: Text('${index + 1}'),) ,
                      title: Text(item['title']),
                      subtitle: Text(item['description']),
                      trailing: PopupMenuButton(
                        onSelected: (value) {
                          if (value == 'edit') {
                             navigateToEditPage(item);
                          }else if (value == 'delete') {
                            deleteById(id);
                          }
                        },
                        itemBuilder: (context) {
                          return[
                            PopupMenuItem(child: Text('Edit'),value: 'edit',
                            ),
                            PopupMenuItem(child: Text('Delete'),value: 'delete',),
                          ];
                        },
                      ),


                    ),
                  );
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: navigateTodoAddPage, label: Text('Add Todo')),
    );
  }
  Future<void> deleteById(String id ) async {
//Delete the item
//   final url ='https://api.nstack.in/v1/todos/$id';
//   final uri = Uri.parse(url);
//   final response = await http.delete(uri);
  final isSuccess = await TodoServices.deletedById(id);
  if (isSuccess) {
    // Remove item From the list
    final filtered = items.where((element) => element['_id'] != id).toList();
    setState(() {
      items =filtered;
    });
  }else{
    //Show error
    showErrorMessage(context,message: 'Deletaion Failed');
  }

  }
 Future <void> navigateTodoAddPage() async{
    final route = MaterialPageRoute(builder: (context) => AddTodoPage());
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }
  Future <void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(builder: (context) => AddTodoPage(todo: item,));
     await Navigator.push(context, route);
setState(() {
  isLoading =true;
});
    fetchTodo();
  }

  Future<void> fetchTodo() async {

    // final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    // final uri = Uri.parse(url);
    // final response = await http.get(uri);
    final response = await TodoServices.fetchTodos();
    if (response != null) {
      // final json = jsonDecode(response.body) as Map;
      // final result = json['items'] as List;
      setState(() {
        items = response;
      });
    } else
      {
        showErrorMessage(context,message: 'Something went Wrong');
      }
    setState(() {
      isLoading = false;
    });
  }


  // void showErrorMessage(String message) {
  //   final snackBar = SnackBar(
  //     content: Text(
  //       message,
  //       style: TextStyle(color: Colors.white),
  //     ),backgroundColor: Colors.red,);
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }
}

