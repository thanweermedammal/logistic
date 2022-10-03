class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/images/accept.jpg',
    title: 'Accept a Job',
    description:
        'Lorem ipsum dolor sit amet. Aut repudiandae ipsa eum eveniet quos quo inventore voluptatem. Et ducimus earum ut consequuntur fuga ea sunt numquam est voluptatum explicabo qui molestiae reiciendis.',
  ),
  Slide(
    imageUrl: 'assets/images/deliverytrack.jpg',
    title: 'Tracking Real time',
    description:
        'Lorem ipsum dolor sit amet. Aut repudiandae ipsa eum eveniet quos quo inventore voluptatem. Et ducimus earum ut consequuntur fuga ea sunt numquam est voluptatum explicabo qui molestiae reiciendis.',
  ),
  Slide(
    imageUrl: 'assets/images/ontime.jpg',
    title: 'Get On-Time Service',
    description:
        'Lorem ipsum dolor sit amet. Aut repudiandae ipsa eum eveniet quos quo inventore voluptatem. Et ducimus earum ut consequuntur fuga ea sunt numquam est voluptatum explicabo qui molestiae reiciendis.',
  ),
];
