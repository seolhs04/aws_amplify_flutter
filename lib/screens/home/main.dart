import 'package:aws_amplify_flutter/stores/counter_cubit.dart';
import 'package:aws_amplify_flutter/stores/counter_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterStore c1 = Get.put(CounterStore());
    final CounterStore c2 = Get.put(CounterStore());
    return Scaffold(
      body: BlocBuilder<CounterCubit, int>(
        builder: (ctx, count) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('bloc counter : $count'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      ctx.read<CounterCubit>().increment();
                    },
                    icon: const Icon(Icons.add),
                  ),
                  IconButton(
                      onPressed: () {
                        ctx.read<CounterCubit>().decrement();
                      },
                      icon: const Icon(Icons.remove)),
                ],
              ),
              Obx(() => Text('getX counter : ${c1.count}')),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: c1.increment,
                    icon: const Icon(Icons.add),
                  ),
                  IconButton(
                    onPressed: c1.decrement,
                    icon: const Icon(Icons.remove),
                  ),
                ],
              ),
              TextButton(
                  onPressed: () {
                    print(Scaffold.of(context));
                  },
                  child: const Text('context test')),
            ],
          ),
        ),
      ),
    );
  }
}
