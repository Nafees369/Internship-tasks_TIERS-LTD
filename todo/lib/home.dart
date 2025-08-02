import 'package:flutter/material.dart';
import 'helper.dart';
import 'model/task.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  final TextEditingController _searchController = TextEditingController();
  List<Task> _incompleteTasks = [];
  List<Task> _completedTasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshTasks();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _refreshTasks(); // Refresh tasks every time search query changes
  }

  Future<void> _refreshTasks() async {
    setState(() => _isLoading = true);
    List<Task> allTasks;
    if (_searchController.text.isEmpty) {
      allTasks = await _dbHelper.getTasks();
    } else {
      allTasks = await _dbHelper.searchTasks(_searchController.text);
    }
    setState(() {
      _incompleteTasks = allTasks.where((task) => !task.isCompleted).toList();
      _completedTasks = allTasks.where((task) => task.isCompleted).toList();
      _isLoading = false;
    });
  }

  Future<void> _showTaskDialog({Task? task}) async {
    final TextEditingController titleController = TextEditingController(text: task?.title);
    final TextEditingController descriptionController = TextEditingController(text: task?.description);
    final bool isEditing = task != null;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(isEditing ? 'Edit Task' : 'Add New Task', style: const TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    hintText: 'Task title',
                    prefixIcon: Icon(Icons.title),
                  ),
                  autofocus: true,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description (Optional)',
                    hintText: 'Task details',
                    prefixIcon: Icon(Icons.description),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (titleController.text.isNotEmpty) {
                  if (isEditing) {
                    task!.title = titleController.text;
                    task.description = descriptionController.text;
                    await _dbHelper.updateTask(task);
                  } else {
                    final newTask = Task(
                      title: titleController.text,
                      description: descriptionController.text,
                    );
                    await _dbHelper.insertTask(newTask);
                  }
                  _refreshTasks();
                  Navigator.of(context).pop();
                }
              },
              child: Text(isEditing ? 'Save' : 'Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteDialog(Task task) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete "${task.title}"? This cannot be undone.', style: const TextStyle(fontSize: 16)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _dbHelper.deleteTask(task.id!);
                _refreshTasks();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text('Delete', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _toggleTaskStatus(Task task) async {
    task.isCompleted = !task.isCompleted;
    await _dbHelper.updateTask(task);
    _refreshTasks();
  }

  void _showTaskDetails(Task task) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(task.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.description.isNotEmpty ? task.description : 'No description provided.',
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Status: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    task.isCompleted ? 'Completed 🎉' : 'Incomplete',
                    style: TextStyle(
                      color: task.isCompleted ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showTaskDialog(task: task);
              },
              child: const Text('Edit'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTaskList(List<Task> tasks, bool isCompletedList) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (tasks.isEmpty && _searchController.text.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isCompletedList ? Icons.check_circle_outline : Icons.sentiment_satisfied_alt,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 20),
            Text(
              isCompletedList ? 'No completed tasks yet!' : 'Add your first task! 🔥',
              style: TextStyle(fontSize: 18, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    if (tasks.isEmpty && _searchController.text.isNotEmpty) {
      return Center(
        child: Text(
          'No tasks found for "${_searchController.text}"',
          style: TextStyle(fontSize: 18, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return GestureDetector(
          onTap: () => _showTaskDetails(task),
          child: Hero(
            tag: 'task-${task.id}',
            child: Card(
              color: task.isCompleted ? const Color(0xFFE0E0E0) : Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (bool? newValue) {
                      _toggleTaskStatus(task);
                    },
                    activeColor: const Color(0xFFF06292),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: task.isCompleted ? Colors.grey.shade600 : Colors.black87,
                      decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                    tooltip: 'Delete Task',
                    onPressed: () => _showDeleteDialog(task),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO Vibe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Optional: Show app info or instructions
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 80), // Add padding for FAB
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Search Tasks...',
                  hintText: 'e.g., "Workout"',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.clear),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                  'Incomplete Tasks (${_incompleteTasks.length})',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87),
                ),
                children: [
                  _buildTaskList(_incompleteTasks, false),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ExpansionTile(
                title: Text(
                  'Completed Tasks (${_completedTasks.length})',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87),
                ),
                children: [
                  _buildTaskList(_completedTasks, true),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showTaskDialog(),
        label: const Text('Add Task'),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
