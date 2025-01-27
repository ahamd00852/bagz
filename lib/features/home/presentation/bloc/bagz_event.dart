part of 'bagz_bloc.dart';

abstract class BagzEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadBagz extends BagzEvent {
  LoadBagz();
}
class LoadOneBag extends BagzEvent{
 final String id;
  LoadOneBag(this.id);
}