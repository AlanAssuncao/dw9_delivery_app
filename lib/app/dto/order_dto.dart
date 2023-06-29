import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';

class OrderDto {
  //DateTime date;
  //String status;
  List<OrderProductDto> products;
  String address;
  String document;
  int paymentMethodId;

  OrderDto({
    //required this.date,
    //required this.status,
    required this.products,
    required this.address,
    required this.document,
    required this.paymentMethodId,
  });
}
