class TagModel {
  String id;
  String title;

  TagModel({
    required this.id,
    required this.title,
  });
}

final List<TagModel> tagsToSelect = [
  TagModel(id: '1', title: 'JavaScript'),
  TagModel(id: '2', title: 'Python'),
  TagModel(id: '3', title: 'Java'),
  TagModel(id: '4', title: 'PHP'),
  TagModel(id: '5', title: 'C#'),
  TagModel(id: '6', title: 'C++'),
  TagModel(id: '7', title: 'Dart'),
  TagModel(id: '8', title: 'DataFlex'),
  TagModel(id: '9', title: 'Flutter'),
  TagModel(id: '10', title: 'Flutter Selectable Tags'),
  TagModel(id: '11', title: 'Android Studio developer'),
];