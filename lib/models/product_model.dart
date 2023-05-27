class ProductModel {
  String? name;
  String? cantidad;
  String? marca;
  String? precio;

  ProductModel({
    this.name,
    this.cantidad,
    this.marca,
    this.precio,
  });
  factory ProductModel.fromMap(map) {
    return ProductModel(
      name: map?['name'],
      cantidad: map?['cantidad'],
      marca: map?['marca'],
      precio: map?['precio'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cantidad': cantidad,
      'marca': marca,
      'precio': precio,
    };
  }

  static ProductModel fromJson(Map<String, dynamic> json) => ProductModel(
        name: json['name'],
        cantidad: json['cantidad'],
        marca: json['marca'],
        precio: json['precio'],
      );
}
