class SubjectModel {
  final String icon;
  final String title;

  SubjectModel({
    required this.icon,
    required this.title,
  });
}

List<SubjectModel> subjectModel = [
  SubjectModel(
    title: "Maths",
    icon: 'assets/images/book.jpg',
  ),
  SubjectModel(
    title: "Physics",
    icon: 'assets/images/book.jpg',
  ),
  SubjectModel(
    title: "Chemistry",
    icon: 'assets/images/book.jpg',
  ),
  SubjectModel(
    title: "Biology",
    icon: 'assets/images/book.jpg',
  ),
];
