void main() {
  TrainingCourse trainingCourse = TrainingCourse("Mathematics around us", true);
  PracticalTask test = PracticalTask(DateTime.now(), "Geometry in life", 10);

  Future<void> addTask() {
    return Future.delayed(Duration(seconds: 3), () => trainingCourse.addTask(test));
  }

  Future<int> getStudentsN() {
    return Future(() => test.numberOfStudents);
  }

  Future<void> doWork() async {
    print("Початок функції doWork");
    try {
      await addTask();
      trainingCourse.ShowData();
    }
    catch (e) {
      print("Недопистиме значення: $e");
    }
    try {
      int studentsN = await getStudentsN();
      if (studentsN == 0) {
        throw Exception("Кількість студентів неможе дорівнювати 0");
      }
      print("Кількість студентів: $studentsN");
    }
    catch (e) {
      print("Сталася помилка: $e");
    }
    print("Кінець функції doWork");
  }

  doWork();
  trainingCourse.addTask(PracticalTask(DateTime(1000,2,10), "Algebra in life", 5));
  trainingCourse.addTask(TheoreticalTask(DateTime(1500,4,11), "Geometry in life 2", 15));
  trainingCourse.addTask(TheoreticalTask(DateTime(2000,6,30), "Linear algebra in life", 30));

  trainingCourse.ShowData();
  print("\nAverage students number: ${trainingCourse.studentsAvg()}");
  print("Max students: ${trainingCourse.maxStudents()}\n");
  print("Tasks with geomtry:");
  
  List<Task> taskWithGeometry = trainingCourse.findTasksByKeyword("Geometry");
  for(var task in taskWithGeometry) {
    task.ShowData();
  }

  print("\nTask with date 2000, 6, 30:");
  trainingCourse.findTaskByDate(DateTime(2000,6,30)).ShowData();
  print("\nTask with 15 students:");
  trainingCourse.findTaskBySutdentsN(15).ShowData();
}

class Task {
  DateTime _date;
  String _topic;
  int _numberOfStudents;

  Task(this._date, this._topic, this._numberOfStudents);

  set date(DateTime date) => this._date = date;

  DateTime get date => this._date;

  set topic(String topic) => this._topic = topic;

  String get topic => this._topic;

  set numberOfStudents(int numberOfStudents) => this._numberOfStudents = numberOfStudents;

  int get numberOfStudents => this._numberOfStudents;

  void ShowData() {
    print("$_date ($_topic) $_numberOfStudents");
  }
}

class PracticalTask extends Task {
  
  PracticalTask(super.date, super.topic, super.numberOfStudents);

  void ShowData() {
    print("Practical |$_date| ($_topic) $_numberOfStudents");
  }
}

class TheoreticalTask extends Task {
  
  TheoreticalTask(super.date, super.topic, super.numberOfStudents);

  void ShowData() {
    print("Teoretical |$_date| ($_topic) $_numberOfStudents");
  }
}

class TrainingCourse<T extends Task> {
  String _name;
  bool _isExam;
  Set<T> _tasks = Set();

  TrainingCourse(this._name, this._isExam);

  TrainingCourse.WithTasks(this._name, this._isExam, this._tasks);

  set name(String name) => this._name = name;

  String get name => _name;

  set isExam(bool isExam) => this._isExam = isExam;

  bool get isExam => _isExam;

  void addTask(T task) {
    _tasks.add(task);
  }

  void ShowData() {
    print("Information about course");
    print("Name: $_name, Exam: $isExam");
    print("\nTasks (type, date, topic, number of students): ");
    for (var task in _tasks){
      task.ShowData();
    }
  }

  int studentsAvg() {
    int allStudents = 0;
    
    for(var task in _tasks) {
      allStudents += task.numberOfStudents;
    }

    return (allStudents / _tasks.length).toInt();
  }

  int maxStudents() {
    T maxTask = _tasks.first;
    
    for(var task in _tasks) {
      if (task.numberOfStudents > maxTask.numberOfStudents) {
        maxTask = task;
      }
    }

    return maxTask.numberOfStudents;
  }

  List<T> findTasksByKeyword(String keyword) {
    return _tasks
      .where((task) => task.topic.toLowerCase().contains(keyword.toLowerCase()))
      .toList();
  }

  T findTaskByDate(DateTime date) {
    return _tasks.where((task) => task._date == date).first;
  }

  T findTaskBySutdentsN(int number) {
    return _tasks.where((task) => task._numberOfStudents == number).first;
  }
}