
import 'package:flutter/material.dart';
import 'package:flutter_clean_arquitect02/layers/domain/entities/character.dart';
import 'package:flutter_clean_arquitect02/layers/presentacion/home_with_states_rebuilder/model/home_view_model.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import '../../../../injection_container.dart' as di;

class HomePageWithStatesRebuilder extends StatefulWidget {
  const HomePageWithStatesRebuilder({ Key? key }) : super(key: key);

  @override
  _HomePageWithStatesRebuilderState createState() => _HomePageWithStatesRebuilderState();
}

class _HomePageWithStatesRebuilderState extends State<HomePageWithStatesRebuilder> {
  @override
  Widget build(BuildContext context) {
    return Injector(
      inject: [
        Inject<HomeViewModel>(
          () => di.sl<HomeViewModel>()
        )
      ],
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text("StateRebuilder"),
        ),
        body: Center(
          child: Container(
            color: Colors.white,
            child: WhenRebuilder<HomeViewModel>(
              observe: () => RM.get<HomeViewModel>(),
              onIdle: () => _showLoadButton(),
              onWaiting: () => CircularProgressIndicator(),
              onError: (error) => Text('Future completes with error $error'),
              onData: (HomeViewModel data) => _showCharactersList(data.charList!),
            ),
          ),
        ),
      ),
    );
  }

  Widget _showLoadButton() {
    final model = RM.get<HomeViewModel>();
    return MaterialButton(
      onPressed: () => model.setState((vm) => vm.loadAllCharacters()),
      child: Text(
        "Load Data",
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