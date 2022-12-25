import 'package:bloc_cubit_demo/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(CounterApp());

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => CounterCubit(),
        child: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: BlocListener<CounterCubit, CounterState>(
          listener: ((context, state) {
            if (state.wasIncremented == true) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text(".Incremented!!")));
            } else if(state.wasIncremented == false){
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Drecremented!!")));
            }
          }),
          child: Container(
            child: BlocBuilder<CounterCubit, CounterState>(
            builder: (context, state) =>
              Center(child: Text('${state.counterValue}')),
                  ),
          ),
        ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => context.read<CounterCubit>().increment(),
            // onPressed: ()=> BlocProvider.of<CounterCubit>(context).increment(),
          ),
          const SizedBox(height: 4),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () => context.read<CounterCubit>().decrement(),
          ),
        ],
      ),
    );
  }
}


// ->blockProvider => create/provide only  instance of  bloc to  the subtree
// -> blocBuilder => regenerate ui components on state change