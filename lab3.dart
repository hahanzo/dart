void main() {
  TrainingCourse trainingCourse = TrainingCourse("Mathematics around us", true);
  PracticalTask test = PracticalTask(DateTime.now(), "Geometry in life", 10);
  trainingCourse.addTask(test);
  trainingCourse.addTask(PracticalTask(DateTime(1000,2,10), "Algebra in life", 5));
  trainingCourse.addTask(PracticalTask(DateTime(1500,4,11), "Geometry in life 2", 15));
  trainingCourse.addTask(PracticalTask(DateTime(2000,6,30), "Linear algebra in life", 30));

  trainingCourse.ShowData();
  print("Average students number: ${trainingCourse.studentsAvg()}");
  print("Max students: ${trainingCourse.maxStudents()}");
  print("Tasks with geomtry:");
  
  List<PracticalTask> taskWithGeometry = trainingCourse.findTasksByKeyword("Geometry");
  for(var task in taskWithGeometry) {
    task.ShowData();
  }

  print("\t");
  print(test.date);
  test.date = DateTime(1907);
  print(test.date);

  print(test.topic);
  test.topic= "Algorithms";
  print(test.topic);

  print(test.numberOfStudents);
  test.numberOfStudents = 20;
  print(test.numberOfStudents);
}

class PracticalTask {
  DateTime _date;
  String _topic;
  int _numberOfStudents;

  PracticalTask(this._date, this._topic, this._numberOfStudents);

  set date(DateTime date) => this._date = date;

  DateTime get date => this._date;

  set topic(String topic) => this._topic = topic;

  String get topic => this._topic;

  set numberOfStudents(int numberOfStudents) => this._numberOfStudents = numberOfStudents;

  int get numberOfStudents => this._numberOfStudents;

  void ShowData() {
    print("$_date $_topic $_numberOfStudents");
  }
}

class TrainingCourse {
  String _name;
  bool _isExam;
  Set<PracticalTask> _tasks = Set();

  TrainingCourse(this._name, this._isExam);

  TrainingCourse.WithTasks(this._name, this._isExam, this._tasks);

  set name(String name) => this._name = name;

  String get name => _name;

  set isExam(bool isExam) => this._isExam = isExam;

  bool get isExam => _isExam;

  void addTask(PracticalTask task) {
    _tasks.add(task);
  }

  void ShowData() {
    print("Information about course");
    print("Name: $_name, Exam: $isExam");
    print("Tasks (date, topic, number of students): ");
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
    PracticalTask maxTask = _tasks.first;
    
    for(var task in _tasks) {
      if (task.numberOfStudents > maxTask.numberOfStudents) {
        maxTask = task;
      }
    }

    return maxTask.numberOfStudents;
  }

  List<PracticalTask> findTasksByKeyword(String keyword) {
    return _tasks
      .where((task) => task.topic.toLowerCase().contains(keyword.toLowerCase()))
      .toList();
  }
}