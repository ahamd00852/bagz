import 'package:bagz/features/home/data/data_source/firestore_service.dart';
import 'package:bagz/features/home/data/models/bagz_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'bagz_event.dart';
part 'bagz_state.dart';

class BagzBloc extends Bloc<BagzEvent, BagzState> {
  final FirestoreService firestoreService;
  BagzBloc({required this.firestoreService}) : super(BagzInitial()) {
    on<LoadBagz>((event, emit) async{
      emit(BagzLoading());
      try {
        await Future.delayed(const Duration(seconds: 5));
        final data = await firestoreService.getBagz();
        emit(LoadedBagz(data));
      } catch (e) {
        emit(BagzError(e.toString()));
      }

    });
    on<LoadOneBag>((event, emit) async{
      emit(BagzLoading());
      try {
        await Future.delayed(const Duration(seconds: 5));
        final data = await firestoreService.getOneBagz(event.id);
        emit(LoadedOneBag(data!));
      } catch (e) {
        emit(BagzError(e.toString()));
      }

    });
  }
}
