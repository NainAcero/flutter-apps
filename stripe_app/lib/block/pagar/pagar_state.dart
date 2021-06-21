part of 'pagar_bloc.dart';

@immutable
class PagarState{

  final double montoaPagar;
  final String moneda;
  final bool tarjetaActiva;
  final TarjetaCredito tarjeta;

  String get montoPagarString => '${ (this.montoaPagar * 100).floor() }';

  PagarState({
    this.montoaPagar = 375.55,
    this.moneda = 'USD',
    this.tarjetaActiva = false,
    this.tarjeta
  });

  PagarState copyWith({
    double montoaPagar,
    String moneda,
    bool tarjetaActiva,
    TarjetaCredito tarjeta,
  }) => PagarState(
    montoaPagar   : montoaPagar ?? this.montoaPagar,
    moneda        : moneda ?? this.moneda,
    tarjetaActiva : tarjetaActiva ?? this.tarjetaActiva,
    tarjeta       : tarjeta ?? this.tarjeta,
    
  );

}
