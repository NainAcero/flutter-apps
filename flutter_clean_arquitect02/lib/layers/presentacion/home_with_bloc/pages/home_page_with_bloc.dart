
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arquitect02/injection_container.dart' as di;
import 'package:flutter_clean_arquitect02/layers/presentacion/home_with_bloc/bloc/home_bloc.dart';
import 'package:flutter_clean_arquitect02/layers/presentacion/home_with_bloc/bloc/home_state.dart';

class HomePageWithBloc extends StatefulWidget {
  const HomePageWithBloc({Key? key}) : super(key: key);

  @override
  _HomePageWithBlocState createState() => _HomePageWithBlocState();
}

class _HomePageWithBlocState extends State<HomePageWithBloc> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (BuildContext context) =>  di.sl<HomeCubit>(),
        ),
      ],
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Bloc"),
            ),
            body: Center(
              child: Container(
                color: Colors.white,
                child: BlocConsumer<HomeCubit, HomeState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if(state is Initial) {
                      return _showLoadButton(context);
                    } else if(state is Loading) {
                      return CircularProgressIndicator();
                    } else if(state is Error) {
                      return Container();
                    } else if(state is Success) {
                      return _showCharactersList(state);
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _showLoadButton(BuildContext context) {
    return MaterialButton(
      onPressed: (){
        _loadData(context);
      },
      child: Text(
        "Load Data",
        style: TextStyle(
          color: Colors.white
        ),
      ),
      color: Colors.blue, 
    );
  }

  Widget _showCharactersList(Success state) {
    return ListView.builder(
      itemCount: state.characterList.length,
      itemBuilder: (BuildContext context, int index) { 
        final character = state.characterList[index];
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

  void _loadData(BuildContext context){
    final cubit = context.read<HomeCubit>();
    cubit.showLoadingAndFetchCharacters();
  }
}