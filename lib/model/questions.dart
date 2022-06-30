class Question{
  final String text;
  final List<Option> options;
  bool isMarked;
  Option? selectedOption;

  Question({required this.text,
    required this.options,
    this.isMarked = false,
    this.selectedOption
  });
}

class Option {
  final String text;

  Option({required this.text});
}