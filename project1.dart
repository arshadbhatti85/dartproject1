import 'dart:io';
import 'dart:convert';

void main() {
  bool wrong = false; 
  String managerEmail = "Manager@gmail.com";
  String managerPassword = "Manager000";
  String staffEmail = "Staff@gmail.com";
  String staffPassword = "Staff000";
  // Display welcome message and login options
  print("\n===== WELCOME TO HR MANAGEMENT SYSTEM  =====");
  print("Login please");
  print("1:Manager");
  print("2:Staff");
  stdout.write("Enter your choice: ");
  var choice = stdin.readLineSync()!;
/*==========================(MANAGER LOGIN)============================== */

  // Manager and studnents login branches
  switch (choice) {
    case '1':
      // Manager Login
      while (!(wrong)) {
        print("Enter your Email:");
        String inputEmail = stdin.readLineSync()!;
        print("Enter your Password:");
        String inputPassword = stdin.readLineSync()!;
        if ((inputEmail == managerEmail) &&
            (managerPassword == inputPassword)) {
          while (true) {
            print("\n===== WELCOME TO HR MANAGEMENT SYSTEM  =====");
            print("1.Add Tasks domains ");
            print("2.Add task Timetable ");
            print("3.Add Task");
            print("4. Exit");
            stdout.write("Enter your choice: ");
            var choice = stdin.readLineSync();

            switch (choice) {
              case '1':
                while (true) {
                  print('\n============Tasks Information=============');
                  runTaskManagement();
                  break;
                }

              case '2':
                print('\n============Tasks Timetable=============');
                generateTimetable();
                print('=============END===========');
                break;
              case '3':
                print('\n============Task=============');
                bool a = true;
                while (a) {
                  print("\nTasks Dashboard");
                  print("1. Add Tasks");
                  print("2. View Tasks");
                  print("3. Exit");

                  print("Enter your choice (1/2/3):");
                  String choice = stdin.readLineSync()!;

                  switch (choice) {
                    case '1':
                      addTasks();
                      break;
                    case '2':
                      viewTasks();
                      break;
                    case '3':
                      print("Exiting...");
                      a = false;

                    default:
                      print("Invalid choice. Please try again.");
                  }
                  break;
                }
              
              case '4':
                print('Thank you so much using HR Management system');
                print("Exiting...");

                break;
              default:
                print("Invalid choice. Please try again.");
            }
          }
        } else {
          print("Wrong input");
          wrong = true;
        }
      }
      break;
/*========================(STAFF LOGIN)============================== */

    case '2':
      while (!(wrong)) {
        print("Enter your Email:");
        String inputEmail = stdin.readLineSync()!;
        print("Enter your Password:");
        String inputPassword = stdin.readLineSync()!;
        if ((inputEmail == staffEmail) && (staffPassword == inputPassword)) {
          while (true) {
            print("\n===== WELCOME TO HR MANAGEMENT SYSTEM  =====");
            print("1.Tasks information ");
            print("2.Tasks Timetable ");
            print("3.Assigned Tasks");
            print("4. Exit");
            stdout.write("Enter your choice: ");
            var choice = stdin.readLineSync();

            switch (choice) {
              case '1':
                print('\n============Tasks Information=============');
                loadTasks();
                displayTasks();
              case '2':
                print('\n============Tasks Timetable=============');
                generateTimetable();
                print('=============END===========');
                break;
              case '3':
                print('\n============Tasks=============');
                bool a = true;
                while (a) {
                  print("\nTasks Dashboard");
                  print("1. Submit Tasks");
                  print("2. View Tasks");
                  print("3. Exit");

                  print("Enter your choice (1/2/3):");
                  String choice = stdin.readLineSync()!;

                  switch (choice) {
                    case '1':
                      addTasks();
                      break;
                    case '2':
                      viewTasks();
                      break;
                    case '3':
                      print("Exiting...");
                      a = false;

                    default:
                      print("Invalid choice. Please try again.");
                  }
                  break;
                }
              
              case '4':
                print('Thank you so much using HR Management system');
                print("Exiting...");

                return;
              default:
                print("Invalid choice. Please try again.");
            }
          }
        } else {
          print("Wrong input");
          wrong = true;
        }
      }
      break;
  }
}
/*============================= (FUNCTIONs ) =========================== */

/*========================(MANAGER)  Case 1 ============================= */
//Here we add Tasks domain

class task {
  String name;
  List<domain> domains;

  task(this.name, this.domains);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'domains': domains.map((domain) => domain.toJson()).toList(),
    };
  }

  factory task.fromJson(Map<String, dynamic> json) {
    return task(
      json['name'],
      (json['domains'] as List<dynamic>)
          .map((domainJson) => domain.fromJson(domainJson))
          .toList(),
    );
  }

  void display() {
    print('task: $name');
    print('domains:');
    domains.forEach((domain) {
      print('  - ${domain.title}: ${domain.description}');
    });
  }
}

class domain {
  String title;
  String description;

  domain(this.title, this.description);

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }

  factory domain.fromJson(Map<String, dynamic> json) {
    return domain(json['title'], json['description']);
  }
}

List<task> tasks = []; // Global list to store tasks

void runTaskManagement() {
  while (true) {
    print('\nMenu:');
    print('1. Load existing data');
    print('2. Add a new task and its domains ');
    print('3. Display loaded tasks and domains');
    print('4. Save data and exit');
    print('Enter your choice (1/2/3/4):');

    String choice = stdin.readLineSync()?.trim() ?? '';

    switch (choice) {
      case '1':
        loadTasks();

        break;

      case '2':
        addtask();
        print('task and domains added successfully.\n');

        break;
      case '3':
        displayTasks();
        break;

      case '4':
        savetasks();
        print('Data saved to data.json.\n');
        break;

      default:
        print('Invalid choice. Please try again.\n');
        break;
    }
  }
}

void loadTasks() {
  String filePath = 'data.json';

  try {
    String jsonData = File(filePath).readAsStringSync();
    List<dynamic> jsonList = json.decode(jsonData);
    tasks = jsonList.map((json) => task.fromJson(json)).toList();
  } catch (e) {
    print('Error loading data from data.json: $e');
  }
}

void savetasks() {
  String filePath = 'data.json';
  List<Map<String, dynamic>> tasksJson =
      tasks.map((task) => task.toJson()).toList();

  String jsonString = json.encode(tasksJson);

  try {
    File(filePath).writeAsStringSync(jsonString);
  } catch (e) {
    print('Error saving data to data.json: $e');
  }
}

void addtask() {
  print('Enter the name of the task:');
  String taskName = stdin.readLineSync() ?? '';

  List<domain> domains = [];

  while (true) {
    print(
        'Enter the title of the domain (or type "done" to finish adding domains):');
    String title = stdin.readLineSync() ?? '';

    if (title.toLowerCase() == 'done') {
      break;
    }

    print('Enter the description of the domain:');
    String description = stdin.readLineSync() ?? '';

    domains.add(domain(title, description));
  }

  task newtask = task(taskName, domains);
  tasks.add(newtask);
}

void displayTasks() {
  if (tasks.isNotEmpty) {
    print('\nLoaded tasks and domains:');
    tasks.forEach((task) {
      task.display();
      print('\n');
    });
  } else {
    print('No data loaded yet.\n');
  }
}

/*========================= (MANAGER) Case 2 ============================= */
void generateTimetable() {
  // Define the starting date
  DateTime startDate = DateTime.now();

  // Set the current date to the beginning of the month
  startDate = startDate.subtract(Duration(days: startDate.day - 1));

  // Define the class days (Thursday and Saturday)
  final taskDays = [DateTime.thursday, DateTime.saturday];

  // Function to calculate the next class date
  DateTime getNextTaskDate(DateTime date, int week, int dayOfWeek) {
    DateTime taskDate = date.add(Duration(days: (week - 1) * 7));
    while (taskDate.weekday != dayOfWeek) {
      taskDate = taskDate.add(Duration(days: 1));
    }
    return taskDate;
  }

  // Generate the timetable for 6 months (24 weeks)
  for (var i = 0; i < 6; i++) {
    print("Month: ${startDate.month}");

    // Iterate over the weeks in the month
    for (var week = 1; week <= 4; week++) {
      print("Week $week:");

      // Iterate over the class days
      for (var day in taskDays) {
        DateTime taskDate = getNextTaskDate(startDate, week, day);
        // Print the class date
        print("${taskDate.toLocal()}");
      }
    }

    // Move to the next month
    startDate = startDate.add(Duration(days: 30));
    print("\n");
  }
}

/*============================ (MANAGER) Case 3 ========================= */
class Task {
  final String name;
  final String description;
  final DateTime dueDate;

  Task(this.name, this.description, this.dueDate);
}

List<Task> tasksDetail = [];

void addTasks() {
  print("Enter task name:");
  String name = stdin.readLineSync()!;

  print("Enter task description:");
  String description = stdin.readLineSync()!;

  print("Enter due date (YYYY-MM-DD):");
  String dueDateStr = stdin.readLineSync()!;
  DateTime dueDate = DateTime.parse(dueDateStr);

  tasksDetail.add(Task(name, description, dueDate));
  print("Task submitted successfully!");
}

void viewTasks() {
  if (tasksDetail.isEmpty) {
    print("No tasksDetail found.");
  } else {
    print("tasks:");
    for (var i = 0; i < tasksDetail.length; i++) {
      var task = tasksDetail[i];
      print("Task ${i + 1}:");
      print("Name: ${task.name}");
      print("Description: ${task.description}");
      print("Due Date: ${task.dueDate.toLocal()}");
      print("-------------");
    }
  }
}


/*============================= (FUNCTIONs ) ========================== */

/*======================= (STAFF)  Case 1 ============================= */

class Staff {
  String name;
  String staffId;
  // List<Map<String, dynamic>> quizResults = [];

  Staff(this.name, this.staffId);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'staffId': staffId,
          };
  }
}

Staff loadStaffDetails() {
  print('Enter your name:');
  String name = stdin.readLineSync()?.trim() ?? '';

  print('Enter your staff ID:');
  String staffId = stdin.readLineSync()?.trim() ?? '';

  return Staff(name, staffId);
}

void saveStaffDetails(Staff Staff) {
  String filePath = 'Staff_details.json';
  Map<String, dynamic> StaffJson = Staff.toJson();

  try {
    File(filePath).writeAsStringSync(json.encode(StaffJson));
    print('Staff details saved to Staff_details.json.');
  } catch (e) {
    print('Error saving Staff details to Staff_details.json: $e');
  }
}
