import 'package:flutter/material.dart';
import 'package:learning_udemy/provider_materi/cart_state.dart';
import 'package:learning_udemy/provider_materi/saldo_state.dart';
import 'package:learning_udemy/provider_materi/state_example.dart';
import 'package:provider/provider.dart';

class ProviderMain extends StatelessWidget {
  const ProviderMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => StateColor())),
        ChangeNotifierProvider(create: ((context) => SaldoState())),
        ChangeNotifierProvider(create: ((context) => CartState()))
      ],
      child: MaterialApp(
        theme: ThemeData(brightness: Brightness.dark),
        home: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back)),
              backgroundColor: Colors.black,
              title: Consumer<StateColor>(
                builder: (context, statecolor, child) =>
                    AnimatedDefaultTextStyle(
                  duration: (Duration(milliseconds: 500)),
                  child: Text('Example State'),
                  style:
                      TextStyle(color: statecolor.getThisColor, fontSize: 20),
                ),
              )),
          body: Center(
              child: Column(
            children: [
              Text('Merubah warna menggunakan state provider'),
              Consumer2<StateColor, SaldoState>(
                builder: (context, color, saldo, child) => AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  margin: EdgeInsets.all(10),
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(100.0),
                      ),
                      color: color.getThisColor),
                  child: Center(
                    child: Text(
                      saldo.getSaldo.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
              ),
              Text('Change Color'),
              Consumer<StateColor>(
                builder: (context, color, child) => Switch(
                  activeColor: color.getThisColor,
                  inactiveThumbColor: color.getThisColor,
                  value: color.getIsColor,
                  onChanged: ((value) {
                    color.setIsColor = value;
                  }),
                ),
              ),
              Consumer2<StateColor, CartState>(
                builder: (context, color, cart, child) => Card(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: 80,
                    width: 300,
                    decoration: BoxDecoration(
                      color: color.getThisColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Kentang [500] x${cart.getQuantity.toString()} - ${(cart.getQuantity * 500).toString()}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
          floatingActionButton: Consumer3<StateColor, SaldoState, CartState>(
            builder: (context, color, saldo, cart, child) =>
                FloatingActionButton(
              backgroundColor: color.getThisColor,
              onPressed: () {
                if (saldo.getSaldo > 0) {
                  saldo.minusSaldo(500);
                  cart.addKeranjang();
                }
              },
              child: Icon(Icons.abc),
            ),
          ),
        ),
      ),
    );
  }
}
