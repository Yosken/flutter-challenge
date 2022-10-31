import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/chargespots.dart' as chargespots;
import 'package:riverpod/riverpod.dart';
import 'package:yosken_challenge1/component/card.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('build');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChargeSpotInfoPage(),
    );
  }
}

final chargespots.SwAndNeLatLng swAndNeLatLng = chargespots.SwAndNeLatLng(
    34.683331703634124,
    139.7657155055581,
    35.686849507072736,
    139.77340835691592);

class ChargeSpotInfoPage extends ConsumerWidget {
  const ChargeSpotInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    print('beforeWatch');
    final asyncValue =
        ref.watch(chargespots.chargerSpotsFutureProvider(swAndNeLatLng));

    return Scaffold(
      body: Container(
        child: asyncValue.when(data: (value){
          print('hello');
          return ListView.builder(
            itemCount: value.charger_spots!.length,
            itemBuilder: (BuildContext context, int index) {
              final spotData = value.charger_spots![index];
              return makeCard(spotData);
            },
          );
        },
          error: (error, stack) => Text('Error: $error'),
          loading: () => const CircularProgressIndicator(),),
      ),
    );
  }
}
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   List<chargespots.ChargerSpots> _chargerspots = [];
//   final spotName = 'hello';
//   final spot = '';
//   chargespots.ChargerSpots spots= chargespots.ChargerSpots(status: 'yes', charger_spots: []);
//   final chargespots.SwAndNeLatLng swAndNeLatLng = chargespots.SwAndNeLatLng(
//       34.683331703634124,
//       139.7657155055581,
//       35.686849507072736,
//       139.77340835691592);
//
//   Future<void> _test() async {
//     final spots = await chargespots.fetchChargerSpots(swAndNeLatLng);
//     for (final spot in spots.charger_spots!) {
//       print(spot.name);
//     }
//
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _test();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text(spotName),
//       ),
//     );
//   }
// }
