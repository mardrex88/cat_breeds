import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/cat_breed.dart';
import '../../data/datasources/cat_api_datasource.dart';

abstract class BreedsEvent {}
class LoadBreeds extends BreedsEvent {}
class LoadMoreBreeds extends BreedsEvent {}
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
  int _page = 0;
  final int _limit = 10;
  List<CatBreed> _breeds = [];

  BreedsBloc(this.datasource) : super(BreedsInitial()) {
    on<LoadBreeds>((event, emit) async {
      emit(BreedsLoading());
      _page = 0;
      _breeds = [];
      try {
        final breeds = await datasource.fetchBreeds(page: _page, limit: _limit);
        _breeds = breeds;
        emit(BreedsLoaded(_breeds));
      } catch (e) {
        emit(BreedsError(e.toString()));
      }
    });

    on<LoadMoreBreeds>((event, emit) async {
      _page++;
      try {
        final breeds = await datasource.fetchBreeds(page: _page, limit: _limit);
        _breeds.addAll(breeds);
        emit(BreedsLoaded(List.from(_breeds)));
      } catch (e) {
        emit(BreedsError(e.toString()));
      }
    });
  }
}