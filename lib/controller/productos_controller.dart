import 'package:get/state_manager.dart';

class ProductosController extends GetxController {
  var cloro = '0'.obs;
  var reactivo = '0'.obs;
  var epp = '0'.obs;
  var balde5 = '0'.obs;
  var balde20 = '0'.obs;
  var mangera = '0'.obs;
  var carretilla = '0'.obs;
  var equiComparador = '0'.obs;
  var total = '0'.obs;

  addCloro(String value) {
    cloro.value = value;
    return cloro.value;
  }

  addReactivo(String value) {
    reactivo.value = value;
    return reactivo.value;
  }

  addEpp(String value) {
    epp.value = value;
    return epp.value;
  }

  addBalde5(String value) {
    balde5.value = value;
    return balde5.value;
  }

  addBalde20(String value) {
    balde20.value = value;
    return balde20.value;
  }

  addMangeras(String value) {
    mangera.value = value;
    return mangera.value;
  }

  addCarretilla(String value) {
    carretilla.value = value;
    return carretilla.value;
  }

  addEquiCompra(String value) {
    equiComparador.value = value;
    return equiComparador.value;
  }

  addTotalCloracion(String value) {
    total.value = value;
    return total.value;
  }
}
