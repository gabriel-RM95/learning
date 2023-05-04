import 'package:bloc/bloc.dart';

class IndexCubit extends Cubit<int> {
  IndexCubit() : super(0);

  void tabPressed(int index) => emit(index);
}
