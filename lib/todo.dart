class Todo {

  int _id;
  String _title;
  String _description;
  String _date;
  String _hour;
  int _levelOfSugar;

  Todo(this._title, this._date, this._hour,this._levelOfSugar, [this._description]);

  Todo.withId(this._id, this._title, this._date, this._hour,this._levelOfSugar, [this._description]);

  int get id => _id;

  String get title => _title;

  String get description => _description;

  String get date => _date;

  int get levelOfSugar => _levelOfSugar;

  String get hour => _hour;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }
  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  set levelOfSugar(int newLevelOfSugar)
  {
    this._levelOfSugar=newLevelOfSugar;
  }

  set hour(String newHour)
  {
    this._hour=newHour;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['date'] = _date;
    map['levelOfSugar']=_levelOfSugar;
    map['hour']=_hour;
    return map;
  }

  // Extract a Note object from a Map object
  Todo.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._date = map['date'];
    this._levelOfSugar=map['levelOfSugar'];
    this._hour=map['hour'];
  }
}







