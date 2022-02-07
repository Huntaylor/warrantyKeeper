import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'home_view_state.dart';
part 'home_view_event.dart';

class HomeViewBloc extends Bloc<HomeViewEvent, HomeViewState> {
  HomeViewBloc() : super(InitialState()) {
    on<CurrentWarrsPressed>((event, emit) {});
    on<AddNewWarrPressed>((event, emit) {});
  }
}
