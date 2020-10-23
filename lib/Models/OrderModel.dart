enum OrderStatus { inProgress, delivered, waiting }

enum ShippingPlan { standard, nextDay }

class OrderModel {
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
}

List<OrderModel> orders = [
  OrderModel(
    status: OrderStatus.inProgress,
    timeOrdered: "May 13, 2016 5:08 PM",
    orderNumber: 1947034,
    trackingNumber: "IW3475453455",
    valueOfItems: 80.55,
    quantity: 20,
    shippingPlan: ShippingPlan.standard,
    progress: 3,
    progressText: "Order on its way",
  ),
  OrderModel(
    status: OrderStatus.delivered,
    timeOrdered: "August 17, 2016 3:58 PM",
    orderNumber: 1245634,
    trackingNumber: "IW3475453455",
    valueOfItems: 56.00,
    quantity: 13,
    shippingPlan: ShippingPlan.nextDay,
    progress: 4,
    progressText: "Order delivered",
  ),
  OrderModel(
    status: OrderStatus.waiting,
    timeOrdered: "January 10, 2016 5:08 PM",
    orderNumber: 2963534,
    trackingNumber: "IW3475453455",
    valueOfItems: 25.99,
    quantity: 2,
    shippingPlan: ShippingPlan.standard,
    progress: 0,
    progressText: "Order is being prepared",
  ),
];
