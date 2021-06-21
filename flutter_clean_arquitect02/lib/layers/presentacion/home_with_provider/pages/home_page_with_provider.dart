
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_arquitect02/layers/domain/entities/character.dart';
import 'package:provider/provider.dart';

import 'package:flutter_clean_arquitect02/layers/presentacion/home_with_provider/notifiers/home_notifier.dart';

class HomePageWithProvider extends StatefulWidget {
  const HomePageWithProvider({Key? key}) : super(key: key);

  @override
  _HomePageWithProviderState createState() => _HomePageWithProviderState();
}

class _HomePageWithProviderState extends State<HomePageWithProvider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider"),
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
    final isLoading = context.select((HomeNotifier n) => n.isLoading);
    final error = context.select((HomeNotifier n) => n.error);
    final list = context.select((HomeNotifier n) => n.characterList);

    if(!isLoading && list == null) {
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
      onPressed: () => context.read<HomeNotifier>().loadCharacters(),
      child: Text(
        "Load data",
        style: TextStyle(
          color: Colors.white
        ),
      ),
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