import 'package:url_launcher/url_launcher.dart';
import '../../features/orders/domain/models/order_model.dart';

class WhatsAppService {
  WhatsAppService._();

  static const String storeWhatsAppNumber = '+919876543210';

  static Future<bool> sendOrderNotification(OrderModel order) async {
    final itemsSummary = order.items
        .map((i) => '• ${i.product.name} × ${i.quantity} (₹${i.itemTotal.toStringAsFixed(0)})')
        .join('\n');

    final message = '''
🚨 *NEW BUDDY KOTTU ORDER*
*Order Number:* ${order.orderNumber}
*Customer:* ${order.deliveryAddress.recipientName}
*Phone:* ${order.deliveryAddress.recipientPhone}
*Delivery Address:* ${order.deliveryAddress.title} - ${order.deliveryAddress.blockOrRoom}

*Items Ordered:*
$itemsSummary

*Subtotal:* ₹${order.subtotal.toStringAsFixed(0)}
*Delivery Fee:* ₹${order.deliveryFee.toStringAsFixed(0)}
*Total Amount:* ₹${order.total.toStringAsFixed(0)} (${order.paymentMethod} — ${order.paymentStatus})

*Instructions:* ${order.customerNotes.isEmpty ? 'None' : order.customerNotes}

_Sent via Buddy Kottu App_
''';

    final encodedMessage = Uri.encodeComponent(message);
    final whatsappUrl = Uri.parse('https://wa.me/$storeWhatsAppNumber?text=$encodedMessage');

    if (await canLaunchUrl(whatsappUrl)) {
      return await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    }
    return false;
  }
}
