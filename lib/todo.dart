
class Todo {
  final String title;
  final String description;
  final bool done;
  final String id;

  Todo({
    required this.title,
    required this.description,
    required this.done,
    required this.id,
  });

  Todo.fromJson(Map<String, dynamic> json)
    : title = json["title"],
      description = json["description"],
      done = json["done"],
      id = json["id"];

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "done": done,
    "id": id,
  };

}

