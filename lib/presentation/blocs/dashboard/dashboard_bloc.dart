import 'package:bloc/bloc.dart';
import 'package:hash_micro_test/presentation/blocs/dashboard/dashboard_event.dart';
import 'package:hash_micro_test/presentation/blocs/dashboard/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {

  int index = 0;

  DashboardBloc(): super(InitDashboardState()) {
    on<ChangeMenuDashboardEvent>((event, emit) {
      index = event.index;

      switch(index) {
        case 0: {
          emit(InitDashboardState());
          break;
        }
        case 1: {
          emit(LocationMenuState());
          break;
        }
      }
    });
  }
}