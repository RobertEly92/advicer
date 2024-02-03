import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'advicer_event.dart';
part 'advicer_state.dart';

class AdvicerBloc extends Bloc<AdvicerEvent, AdvicerState> {
  AdvicerBloc() : super(AdvicerInitial()) {
    Future sleep1() {
      
      return Future.delayed(Duration(seconds:2));
    }

    on<AdviceRequestedEvent>((event, emit) async {
          emit(AdvicerStateLoading());
        await sleep1();
      emit(AdvicerStateLoaded(advice: 'wurst'));
    });
  }
}
