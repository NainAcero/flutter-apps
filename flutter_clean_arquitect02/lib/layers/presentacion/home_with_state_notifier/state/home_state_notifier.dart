
import 'package:flutter_clean_arquitect02/layers/domain/usecases/get_all_characters.dart';
import 'package:flutter_clean_arquitect02/layers/presentacion/home_with_state_notifier/state/home_state.dart';
import 'package:state_notifier/state_notifier.dart';

class HomeStateNotifier extends StateNotifier<HomeState> {

  final GetAllCharacters getAllCharacters;

  HomeStateNotifier({
    required  this.getAllCharacters
  }) : super(HomeState());

  void loadAllCharacters() async {
    state = state.copyWith(isLoading: true);

    final result = await getAllCharacters();

    state = result.fold(
      (e) => state.copyWith(errorMessage: 'fail', isLoading: false),
      (list) => state.copyWith(charactersList: list, isLoading: false)
    );
  }

}