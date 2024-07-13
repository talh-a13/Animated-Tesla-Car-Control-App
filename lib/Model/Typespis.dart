class Typepsi {
  final double psi;
  final int temp;
  final bool isLowpressure;
  Typepsi({required this.psi, required this.temp, required this.isLowpressure});
}
final List<Typepsi> demoPsiList=[
Typepsi(psi:23.6 , temp: 56, isLowpressure:true ),
Typepsi(psi:35.5 , temp: 42, isLowpressure:false ),
Typepsi(psi:34.6 , temp: 51, isLowpressure:false ),
Typepsi(psi:33.2 , temp: 49, isLowpressure:false )
];