import 'package:cloud_firestore/cloud_firestore.dart';

import 'ShippingPlanModel.dart';

enum OrderStatus { inProgress, delivered, waiting }

class OrderModel {
  final bool transactionStatus;
  final OrderStatus status;
  final String timeOrdered;
  final int orderNumber;
  final String trackingNumber;
  final double valueOfItems;
  final int quantity;
  final String shippingPlan;
  final int progress;
  final String progressText;

  OrderModel({
    this.transactionStatus,
    this.status,
    this.timeOrdered,
    this.orderNumber,
    this.trackingNumber,
    this.valueOfItems,
    this.quantity,
    this.shippingPlan,
    this.progress,
    this.progressText,
  });

  factory OrderModel.fromMap({Map<String, dynamic> data, String documentId}) {
    return OrderModel(
      status: OrderStatus.inProgress,
      transactionStatus: data["transaction_status"],
      timeOrdered: (data["time_ordered"] as Timestamp).toDate().toString(),
      orderNumber: data["order_number"],
      trackingNumber: data["tracking_number"],
      valueOfItems: double.parse("${data["value_of_items"]}"),
      quantity: data["quantity"],
      shippingPlan: data["shipping_plan"],
      progress: data["progress"],
      progressText: data["progress_text"],
    );
  }

  toString() {
    return "transactionStatus : $transactionStatus, status : $status, timeOrdered : $timeOrdered, orderNumber : $orderNumber, trackingNumber : $trackingNumber, valueOfItems : $valueOfItems, quantity : $quantity, shippingPlan : $shippingPlan, progress : $progress, progressText : $progressText";
  }
}
