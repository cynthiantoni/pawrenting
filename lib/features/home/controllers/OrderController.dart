import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pawrentingreborn/data/repositories/OrderRepo.dart';
import 'package:pawrentingreborn/features/home/controllers/CartController.dart';
import 'package:pawrentingreborn/features/home/controllers/DeliveryController.dart';
import 'package:pawrentingreborn/features/home/controllers/LocationController.dart';
import 'package:pawrentingreborn/features/home/controllers/PaymentController.dart';
import 'package:pawrentingreborn/features/home/controllers/ProductController.dart';
import 'package:pawrentingreborn/features/home/controllers/VoucherController.dart';
import 'package:pawrentingreborn/features/home/models/cartItemModel.dart';
import 'package:pawrentingreborn/features/home/models/orderModel.dart';
import 'package:pawrentingreborn/features/profile/controllers/editDataController.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();
  CartController cartController = Get.find();
  DeliveryController deliveryController = Get.find();
  PaymentController paymentController = Get.find();
  ProductController productController = Get.find();
  LocationController locationController = Get.find();
  VoucherController voucherController = Get.find();
  final orderRepo = OrderRepo.instance;
  final _auth = FirebaseAuth.instance;
  final List<OrderModel> orderList = <OrderModel>[];
  final String payment = '';
  RxDouble deliveryPrice = 0.0.obs;
  RxDouble totalPrice = 0.0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchOrderById();
    updateTotalPrice();
    super.onInit();
  }

  void updateTotalPrice() {
    deliveryPrice.value = !voucherController.isSelected.value ? deliveryController
        .deliveryList[deliveryController.selectedIndex.value].price : 0.0;
    totalPrice.value = cartController.totalCartPrice.value +
        deliveryController
            .deliveryList[deliveryController.selectedIndex.value].price +
        1000;
  }

  void fetchUserOrders() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final orders = await orderRepo.getOrdersForUser(_auth.currentUser!.uid);
        orderList.assignAll(orders);
      }
    } catch (e) {
      print("Failed to fetch user orders: $e");
    }
  }

  void createOrderBuyNow(CartItemModel item) async {
    final uid = _auth.currentUser!.uid;
    final random =
        DateTime.now().millisecondsSinceEpoch.toString().substring(8);
    final id = '$uid-$random';
    final date = DateTime.now();
    final status = 'In Delivery';
    final totalprice =
        totalPrice.value + item.productModel.price * item.quantity.value;
    OrderModel order = OrderModel(
      id: id,
      uid: uid,
      items: item.toList(),
      date: date,
      status: status,
      delivery: deliveryController
          .deliveryList[deliveryController.selectedIndex.value],
      totalPrice: totalprice,
      payment:
          paymentController.paymentList[paymentController.selectedIndex].name,
      location: locationController
          .locationsList[locationController.selectedIndex.value],
    );
    print(order.delivery.name);
    await orderRepo.createOrder(order);
    cartController.removeCheckedItems();
    productController.updateProductStock(
        item.productModel.id, item.productModel.stock - item.quantity.value);
    productController.fetchProduct();
    fetchOrderById();
    EditDataController editDataController = Get.find();
    editDataController.subtractPawpay(order.totalPrice);
  }

  void createOrder() async {
    print('object');
    CartController cartController = Get.find();
    final uid = _auth.currentUser!.uid;
    final random =
        DateTime.now().millisecondsSinceEpoch.toString().substring(8);
    final id = '$uid-$random';
    final items = cartController.cartItems.value;
    final date = DateTime.now();
    final status = 'In Delivery';
    final totalprice = totalPrice.value;

    // Check if lists are empty before accessing indices
    if (deliveryController.deliveryList.isEmpty ||
        paymentController.paymentList.isEmpty ||
        locationController.locationsList.isEmpty) {
      print('Delivery List: ${deliveryController.deliveryList}');
      print('Payment List: ${paymentController.paymentList}');
      print('Location List: ${locationController.locationsList}');

      print("Error: One or more lists are empty!");
      return;
    }

    OrderModel order = OrderModel(
      id: id,
      uid: uid,
      items: items,
      date: date,
      status: status,
      delivery: deliveryController
          .deliveryList[deliveryController.selectedIndex.value],
      totalPrice: totalprice,
      payment:
          paymentController.paymentList[paymentController.selectedIndex].name,
      location: locationController
          .locationsList[locationController.selectedIndex.value],
    );

    print('Delivery: ' + order.delivery.name);
    await orderRepo.createOrder(order);

    for (var item in items) {
      productController.updateProductStock(
          item.productModel.id, item.productModel.stock - item.quantity.value);
    }
    cartController.removeCheckedItems();
    productController.fetchProduct();
    fetchOrderById();
    EditDataController editDataController = Get.find();
    editDataController.subtractPawpay(order.totalPrice);
  }

  void fetchOrderById() async {
    try {
      final orders = await orderRepo.getOrdersForUser(_auth.currentUser!.uid);
      if (orders != null) {
        print("Order fetched successfully");
        orderList.assignAll(orders);
      } else {
        print("Order not found");
      }
    } catch (e) {
      print("Failed to fetch order: $e");
    }
  }
}
