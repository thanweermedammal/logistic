class MainmenuModel {
  final String icon;
  final String title;

  MainmenuModel({
    required this.icon,
    required this.title,
  });
}

List<MainmenuModel> mainmenuModel = [
  MainmenuModel(
    title: "Subject",
    icon: 'assets/images/subjecticon.jpg',
  ),
  MainmenuModel(
    title: "Question Paper \n& Answer Key",
    icon: 'assets/images/answer.jpg',
  ),
  MainmenuModel(
    title: "E-Books",
    icon: 'assets/images/ebook.jpg',
  ),
  MainmenuModel(
    title: "Exam Hall",
    icon: 'assets/images/exam.jpg',
  ),
  MainmenuModel(
    title: "Latest News & \nUpdates",
    icon: 'assets/images/news.jpg',
  ),
  MainmenuModel(
    title: "Clarify Yours \n Doubts",
    icon: 'assets/images/doubt.jpg',
  ),
];
