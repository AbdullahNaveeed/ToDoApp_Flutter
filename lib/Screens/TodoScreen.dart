import 'package:flutter/material.dart';
import 'package:todolist_app/contraints/Colors.dart';

class ToDoAppScreen extends StatefulWidget {
  const ToDoAppScreen({super.key});

  @override
  State<ToDoAppScreen> createState() => _ToDoAppScreenState();
}

class _ToDoAppScreenState extends State<ToDoAppScreen> {
  List<String> tasksList = [
    'Dinner with Jenny',
    'Meeting with Bob',
    'Buy groceries',
    'Complete Flutter project Complete Flutter project ',
    'Call mom'
  ];

  List<String> filteredTasksLists = [];
  List<bool> _isCompleted = List<bool>.filled(5, false);
  final TextEditingController _addNewTaskController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    // Initially, show all tasks
    filteredTasksLists = List.from(tasksList);
  }

  void filterTask(String query) {
    List<String> resultTasks = [];
    if (query.isEmpty) {
      resultTasks = List.from(tasksList);
    } else {
      resultTasks = tasksList
          .where((task) => task.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {
      searchQuery = query;
      filteredTasksLists = resultTasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(
      //   elevation: 10,
      //   width: 250,
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       UserAccountsDrawerHeader(
      //         accountName: Text("Abdullah"),
      //         accountEmail: Text("abdullahnaveed5547@gmail.com"),
      //       ),
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: tdBGColor,
        elevation: 0,
        title: Row(
          children: [
            const Spacer(),
            Center(
              child: Title(
                color: Colors.black,
                child: const Text("Todo"),
              ),
            ),
            const Spacer(),
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.jpeg'),
            ),
          ],
        ),
      ),
      backgroundColor: tdBGColor,
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              height: 45,
              width: double.infinity,
              child: TextFormField(
                onChanged: (value) {
                  filterTask(value);
                },
                controller: _searchController,
                cursorColor: const Color.fromARGB(255, 18, 84, 139),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 20,
                  ),
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.black54),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "All ToDos",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTasksLists.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 60,
                    child: Card(
                      color: Colors.white,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 60,
                            height: double.infinity,
                            child: Checkbox(
                              activeColor: tdBlue,
                              value: _isCompleted[index],
                              onChanged: (value) {
                                setState(() {
                                  _isCompleted[index] = value!;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: Tooltip(
                              message: filteredTasksLists[index]
                                  .toString(), // Show full text in a tooltip
                              child: Text(
                                filteredTasksLists[index].toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  decoration: _isCompleted[index]
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                                overflow: TextOverflow
                                    .ellipsis, // Show ellipsis for long text
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              filteredTasksLists.removeAt(index);
                              setState(() {});
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color.fromARGB(255, 217, 27, 13),
                              ),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 17,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.only(
                          bottom: 20, left: 10, right: 12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 10.0,
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            spreadRadius: 0.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: _addNewTaskController,
                        decoration: const InputDecoration(
                          hintText: "Add a new todo item",
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 10,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        filteredTasksLists.insert(
                          0,
                          _addNewTaskController.text.toString(),
                        );
                        setState(() {
                          _addNewTaskController.clear();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tdBlue,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.zero, // Removes default padding
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
