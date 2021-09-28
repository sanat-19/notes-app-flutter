import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/service/database.dart';

abstract class NotesEvent extends Equatable {}

class NoteCreatedEvent extends NotesEvent {
  String title, desc;
  NoteCreatedEvent({this.title, this.desc});
  @override
  List<Object> get props => throw UnimplementedError();
}

abstract class NotesState {}

class NoteCreatedState extends NotesState {}

class CreateNoteBloc extends Bloc<NoteCreatedEvent, NotesState> {
  CreateNoteBloc() : super(NoteCreatedState());

  @override
  Stream<NotesState> mapEventToState(NoteCreatedEvent event) async* {
    try {
      yield Database.instance.addNote(event.title, event.desc);
      print("${event.title}");
    } catch (e) {
      print(e);
    }
  }
}
