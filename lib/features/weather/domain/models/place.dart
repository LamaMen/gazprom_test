import 'package:flutter/foundation.dart';

@immutable
class Place {
  const Place(this.id, this.title);

  final int id;
  final String title;
}
