
import 'package:flutter/material.dart';
import 'package:flutter_architect03/src/common/bloc/bloc_provider.dart';
import 'package:flutter_architect03/src/presentation/cart/cart_bloc.dart';
import 'package:flutter_architect03/src/presentation/cart/cart_state.dart';
import 'package:flutter_architect03/src/presentation/cart/widgets/cart_content_item.dart';

class CartContent extends StatelessWidget {
  const CartContent();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CartBloc>(context);
    
    return StreamBuilder<CartState>(
      initialData: bloc.state,
      stream: bloc.observableState,
      builder: (context, snapshot) {
        final state = snapshot.data;

        if (state is LoadingCartState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ErrorCartState) {
          return Center(child:Text(state.message));
        } else if(state is LoadedCartState){
          return _renderCartContent(context, state);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }

  Widget _renderCartContent(BuildContext context, LoadedCartState state){
    final totalPrice = () => Column(children: <Widget>[
      const Divider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Total Price',
            style: Theme.of(context).textTheme.title,
          ),
          Text(state.totalPrice,
              style: Theme.of(context).textTheme.title)
        ],
      )
    ]);

    final cartItems = () => ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: state.items.length + 1,
      itemBuilder: (context, index) {
        if (index < state.items.length) {
          final CartItemState cartItemState = state.items[index];
          return CartContentItem(cartItemState);
        } else {
          return totalPrice();
        }
      }
    );

    final emptyCartItems = () => Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        ' Empty Cart :(',
        style: Theme.of(context).textTheme.title,
      ));
    
    final content =
    state.items.isNotEmpty ? cartItems() : emptyCartItems();
    return content;
  }
}