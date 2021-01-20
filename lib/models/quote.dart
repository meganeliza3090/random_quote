import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  final id;
  final String content;
  final String author;

  const Quote({this.id, this.content, this.author});

  @override
  List<Object> get props => [id, content, author];

  static Quote fromJson(dynamic json) {
    return Quote(
      id: json['_id'],
      content: json['content'],
      author: json['author'],
    );
  }

  @override
  String toString() => 'Quote { id: $id }';
}
