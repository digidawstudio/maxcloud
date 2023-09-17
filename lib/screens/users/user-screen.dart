import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:maxcloud/bloc/product/product.bloc.dart';

import '../../bloc/user/user.bloc.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final productBloc = BlocProvider.of<ProductBloc>(context);

    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is LoadingUserState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is LoadedUserState) {
                final user = state.user;
                return ListView.builder(
                  itemCount: user.length,
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return Text(user[i]["username"]);
                  },
                );
              } else if (state is ErrorUserState) {
                return Center(child: Text(state.error));
              } else {
                return Center(
                  child: Text("nothing here"),
                );
              }
            },
          ),
          SizedBox(height: 50,),
          BlocBuilder<ProductBloc, ProductState>(builder: (context, thisState) {
            if (thisState is LoadingProductState) {
              return Center(
                child: Text("Product Loading"),
              );
            } else if (thisState is LoadedProductState) {
              final products = thisState.products;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: products.map((e) => Text(e["title"])).toList(),
              );
            } else if (thisState is ErrorProductState) {
              return Center(child: Text(thisState.error));
            } else {
              return Center(child: Text("Nothing here"));
            }
          })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          userBloc.add(FetchUserEvent());
          productBloc.add(FetchProductEvent());
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
