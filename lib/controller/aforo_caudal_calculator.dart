import 'package:get/state_manager.dart';

class CalculatoreController extends GetxController {
  var volumen = '0'.obs;
  var tiempo1 = '0'.obs;
  var tiempo2 = '0'.obs;
  var tiempo3 = '0'.obs;
  var tiempo4 = '0'.obs;

  var tiempoPromedio = '0'.obs;

  var resultado = '0'.obs;

  var tiempoRecarga = '0'.obs;
  var volumTanque = '0'.obs;
  var cloroResidual = '0'.obs;
  var coloroComercial = '0'.obs;

  addVolumRecipiente(String number) {
    volumen.value = number.substring(0, number.length - 6).replaceAll(' ', '');

    return volumen.value;
  }

  addTiempo1(String number) {
    tiempo1.value = number;
    return tiempo1.value;
  }

  addTiempo2(String number) {
    tiempo2.value = number;
    return tiempo2.value;
  }

  addTiempo3(String number) {
    tiempo3.value = number;

    return tiempo3.value;
  }

  addTiempo4(String number) {
    tiempo4.value = number;
    return tiempo4.value;
  }

  tiempoProme() {
    double t1;
    double t2;
    double t3;
    double t4;

    tiempo1.value != '' ? t1 = double.parse(tiempo1.value) : t1 = 0;
    tiempo2.value != '' ? t2 = double.parse(tiempo2.value) : t2 = 0;
    tiempo3.value != '' ? t3 = double.parse(tiempo3.value) : t3 = 0;
    tiempo4.value != '' ? t4 = double.parse(tiempo4.value) : t4 = 0;

    double resu = (t1 + t2 + t3 + t4) / 4;

    return resu;
  }

  caudal() {
    double t1;
    double t2;
    double t3;
    double t4;
    double volume;
    double caudalResult;

    tiempo1.value != '' ? t1 = double.parse(tiempo1.value) : t1 = 0;
    tiempo2.value != '' ? t2 = double.parse(tiempo2.value) : t2 = 0;
    tiempo3.value != '' ? t3 = double.parse(tiempo3.value) : t3 = 0;
    tiempo4.value != '' ? t4 = double.parse(tiempo4.value) : t4 = 0;
    volumen.value != '' ? volume = double.parse(volumen.value) : volume = 0;

    double result = (t1 + t2 + t3 + t4) / 4;

    result > 0.1 ? caudalResult = (volume / result) : caudalResult = 0;

    caudalResult = double.parse(caudalResult.toStringAsFixed(2));
    print(caudalResult);
    return caudalResult;
  }

  //////////CALCULAR LA CLORACION
  ///
  timepoRecarga(String number) {
    tiempoRecarga.value =
        number.substring(0, number.length - 4).replaceAll(' ', '');
    return tiempoRecarga.value;
  }

  volumenTanque(String number) {
    if (number.contains(RegExp(r'[^0-9]'))) {
      volumTanque.value =
          number.substring(0, number.length - 2).replaceAll(' ', '');
      return volumTanque.value;
    } else {}
  }

  cloroResid(String number) {
    cloroResidual.value =
        number.substring(0, number.length - 3).replaceAll(' ', '');
    return cloroResidual.value;
  }

  cloroComerc(String number) {
    coloroComercial.value =
        number.substring(0, number.length - 2).replaceAll(' ', '');
    return coloroComercial.value;
  }

  gramos() {
    double t1;
    double t2;
    double t3;
    double gramos;
    double result;

    tiempoRecarga.value != '' ? t1 = double.parse(tiempoRecarga.value) : t1 = 0;
    cloroResidual.value != '' ? t2 = double.parse(cloroResidual.value) : t2 = 0;
    coloroComercial.value != ''
        ? t3 = double.parse(coloroComercial.value)
        : t3 = 0;
    result = (caudal() * (t1 * 1440) * t2) / t3 / 100 * 10;
    gramos = double.parse(result.toStringAsFixed(2));
    return gramos;
  }

  qg() {
    double t1;
    double t2;
    double qg;
    double result;

    volumTanque.value != '' ? t1 = double.parse(volumTanque.value) : t1 = 0;
    tiempoRecarga.value != '' ? t2 = double.parse(tiempoRecarga.value) : t2 = 0;

    result = (t1 * 1000) / (t2 * 1440);
    qg = double.parse(result.toStringAsFixed(2));

    return qg;
  }
}
