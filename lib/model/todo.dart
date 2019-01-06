class Todo {
  bool done = false;
  String text;

  Todo(String name){
     this.text = name;
  }

  void toggle(){
    this.done = !this.done;
  }
}