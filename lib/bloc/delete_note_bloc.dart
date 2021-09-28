import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/service/database.dart';

abstract class DeleteEvent extends Equatable {}

class DeleteNoteEvent extends DeleteEvent {
  String id;
  DeleteNoteEvent({this.id});
  @override
  List<Object> get props => throw UnimplementedError();
}

abstract class DeleteState {}

class DeleteNoteState extends DeleteState {}

class DeleteNoteBloc extends Bloc<DeleteNoteEvent, DeleteState> {
  DeleteNoteBloc() : super(DeleteNoteState());
  @override
  Stream<DeleteState> mapEventToState(DeleteNoteEvent event) async* {
    try {
      yield Database.instance.deleteNote(event.id);
    } catch (e) {}
  }
}
