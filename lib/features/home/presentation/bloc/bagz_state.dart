part of 'bagz_bloc.dart';

@immutable
sealed class BagzState {}

class BagzInitial extends BagzState{}

class BagzLoading extends BagzState{
  List<Object?> get props=>[];
}
class LoadedOneBag extends BagzState{
  final BagzModel oneBag;
  LoadedOneBag(this.oneBag);
}
class LoadedBagz extends BagzState{
  final List<BagzModel> myData;

  LoadedBagz(this.myData);
  List<Object?> get props=>[myData];
}
class BagzOperationSuccess extends BagzState{
  final String message;

  BagzOperationSuccess(this.message);
}
class BagzError extends BagzState{
  final String errorMessage;

  BagzError(this.errorMessage);
  @override
  List<Object?>get props=>[errorMessage];
}