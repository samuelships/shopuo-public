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
  final ShippingPlan shippingPlan;
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
      // timeOrdered: data["time_ordered"],
      // orderNumber: data["order_number"],
      // trackingNumber: data["tracking_number"],
      // valueOfItems: data["value_of_items"],
      // quantity: data["quantity"],
      // shippingPlan: ShippingPlan(name: "fake", price: 20),
      // progress: 1,
      // progressText: data["progress_text"],
    );
  }

  toString() {
    return "transactionStatus : $transactionStatus, status : $status, timeOrdered : $timeOrdered, orderNumber : $orderNumber, trackingNumber : $trackingNumber, valueOfItems : $valueOfItems, quantity : $quantity, shippingPlan : $shippingPlan, progress : $progress, progressText : $progressText";
  }
}

// List<OrderModel> orders = [
//   OrderModel(
//     status: OrderStatus.inProgress,
//     timeOrdered: "May 13, 2016 5:08 PM",
//     orderNumber: 1947034,
//     trackingNumber: "IW3475453455",
//     valueOfItems: 80.55,
//     quantity: 20,
//     shippingPlan: ShippingPlan.standard,
//     progress: 3,
//     progressText: "Order on its way",
//   ),
//   OrderModel(
//     status: OrderStatus.delivered,
//     timeOrdered: "August 17, 2016 3:58 PM",
//     orderNumber: 1245634,
//     trackingNumber: "IW3475453455",
//     valueOfItems: 56.00,
//     quantity: 13,
//     shippingPlan: ShippingPlan.nextDay,
//     progress: 4,
//     progressText: "Order delivered",
//   ),
//   OrderModel(
//     status: OrderStatus.waiting,
//     timeOrdered: "January 10, 2016 5:08 PM",
//     orderNumber: 2963534,
//     trackingNumber: "IW3475453455",
//     valueOfItems: 25.99,
//     quantity: 2,
//     shippingPlan: ShippingPlan.standard,
//     progress: 0,
//     progressText: "Order is being prepared",
//   ),
// ];
