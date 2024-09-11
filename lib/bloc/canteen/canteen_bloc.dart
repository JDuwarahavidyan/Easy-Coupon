import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'canteen_event.dart';
part 'canteen_state.dart';

class CanteenBloc extends Bloc<CanteenEvent, CanteenState> {
  final FirebaseFirestore firestore;

  CanteenBloc(this.firestore) : super(CanteenInitial()) {
    on<FetchAuthorizedUsers>(_onFetchAuthorizedUsers);
  }

  Future<void> _onFetchAuthorizedUsers(
    FetchAuthorizedUsers event,
    Emitter<CanteenState> emit,
  ) async {
    emit(CanteenLoading());
    try {
      QuerySnapshot snapshot = await firestore.collection('Canteen').get();
      List<String> authorizedUsernames =
          snapshot.docs.map((doc) => doc['username'] as String).toList();
      emit(CanteenLoaded(authorizedUsernames));
    } catch (e) {
      emit(CanteenError(e.toString()));
    }
  }
}
