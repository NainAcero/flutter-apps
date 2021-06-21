
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_arquitect02/layers/presentacion/home_with_state_notifier/state/home_state.dart';
import 'package:provider/provider.dart';
import 'package:flutter_clean_arquitect02/layers/domain/entities/character.dart';
import 'package:flutter_clean_arquitect02/layers/presentacion/home_with_state_notifier/state/home_state_notifier.dart';

class HomePageWithStateNotifier extends StatefulWidget {
  
  const HomePageWithStateNotifier({Key? key}) : super(key: key);

  @override
  _HomePageWithStateNotifierState createState() => _HomePageWithStateNotifierState();
}

class _HomePageWithStateNotifierState extends State<HomePageWithStateNotifier> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StateNotifier"),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: _showBody(),
        ),
      ),
    );
  }

  Widget _showBody() {
    final isLoading = context.select((HomeState state) => state.isLoading);
    final error = context.select((HomeState state) => state.errorMessage);
    final list = context.select((HomeState state) => state.charactersList);

    if (!isLoading && list == null) {
      return _showLoadButton();
    } else if (isLoading) {
      return CircularProgressIndicator();
    } else if (!isLoading && list != null) {
      return _showCharactersList(list);
    } else if (error != null) {
      return Container();
    } else {
      return Container();
    }
  }

  Widget _showLoadButton() {
    return MaterialButton(
      onPressed: () => context.read<HomeStateNotifier>().loadAllCharacters(),
      child: Text("Load data"),
      color: Colors.blue,
    );
  }

  Widget _showCharactersList(List<Character> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final character = list[index];
        return ListTile(
          leading: Image.network(
            character.image,
            errorBuilder: (context, error, stackTrace) => Text('😢\noffline'),
          ),
          title: Text('${character.name}'),
          subtitle: Text('${character.status}'),
        );
      },
    );
  }
}