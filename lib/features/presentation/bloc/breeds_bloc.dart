import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/cat_breed.dart';
import '../../data/datasources/cat_api_datasource.dart';

abstract class BreedsEvent {}
class LoadBreeds extends BreedsEvent {}

abstract class BreedsState {}
class BreedsInitial extends BreedsState {}
class BreedsLoading extends BreedsState {}
class BreedsLoaded extends BreedsState {
  final List<CatBreed> breeds;
  BreedsLoaded(this.breeds);
}
class BreedsError extends BreedsState {
  final String message;
  BreedsError(this.message);
}

class BreedsBloc extends Bloc<BreedsEvent, BreedsState> {
  final CatApiDatasource datasource;
  BreedsBloc(this.datasource) : super(BreedsInitial()) {
    on<LoadBreeds>((event, emit) async {
      emit(BreedsLoading());
      try {
        final breeds = await datasource.fetchBreeds();
        emit(BreedsLoaded(breeds));
      } catch (e) {
        emit(BreedsError(e.toString()));
      }
    });
  }
}