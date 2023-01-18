import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit({this.data = 0}) : super(data);

  int data;

  void tambah() {
    emit(state + 1);
  }

  void kurang() {
    emit(state - 1);
  }

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print(change);
  }
}

class CubitExample extends StatelessWidget {
  CubitExample({super.key});

  CounterCubit myCounter = CounterCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Bloc'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
              initialData: myCounter.data,
              stream: myCounter.stream,
              builder: (context, snapshot) {
                return Text(
                  "${snapshot.data}",
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      myCounter.kurang();
                    },
                    icon: Icon(Icons.remove)),
                IconButton(
                    onPressed: () {
                      myCounter.tambah();
                    },
                    icon: Icon(Icons.add)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// Stream Example
// class StreamBody extends StatelessWidget {
//   StreamBody({super.key});

//   Stream<List> dtb() async* {
//     List<String> result = [];
//     for (int i = 0; i < 10; i++) {
//       await Future.delayed(Duration(seconds: 1));
//       result.add("User${i}");
//       yield result;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: StreamBuilder(
//         stream: dtb(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Text("Loading");
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) => ListTile(
//                 title: Text("${snapshot.data![index]}"),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
