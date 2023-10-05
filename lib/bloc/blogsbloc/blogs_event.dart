
import 'package:equatable/equatable.dart';

abstract class BlogsEvents extends Equatable {
  const BlogsEvents();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class StartEvent extends BlogsEvents {
  // ignore: non_constant_identifier_names
  late bool Connectivity ;
  StartEvent(this.Connectivity);
}