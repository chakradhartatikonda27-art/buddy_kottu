import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../cart/presentation/cart_provider.dart';
import '../../orders/presentation/order_provider.dart';
import '../../addresses/domain/address_model.dart';
import '../../../../core/constants/app_colors.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  String _selectedPaymentMethod = 'UPI'; // UPI, COD, CARD
  final TextEditingController _notesController = TextEditingController();

  final List<AddressModel> _addresses = const [
    AddressModel(
      id: 'addr_hostel',
      type: 'Hostel',
      title: 'Hostel Block B',
      fullAddress: 'GSL Medical College Hostel Campus, Rajahmundry',
      blockOrRoom: 'Room 304, Block B',
      landmark: 'Near Main Boys Mess',
      recipientName: 'Rahul V',
      recipientPhone: '+91 98765 43210',
      isDefault: true,
    ),
    AddressModel(
      id: 'addr_hospital',
      type: 'Hospital',
      title: 'GSL Hospital OPD Ward',
      fullAddress: 'GSL General Hospital 2nd Floor, NH-16, Rajahmundry',
      blockOrRoom: 'OPD Waiting Lounge',
      landmark: 'Near Pharmacy Desk',
      recipientName: 'Rahul V',
      recipientPhone: '+91 98765 43210',
    ),
  ];

  late AddressModel _selectedAddress;

  @override
  void initState() {
    super.initState();
    _selectedAddress = _addresses.first;
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Delivery Location Selection
                    Text(
                      'DELIVERY ADDRESS',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ..._addresses.map((addr) {
                      final isSelected = addr.id == _selectedAddress.id;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? AppColors.primary : AppColors.cardBorder,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: RadioListTile<AddressModel>(
                          value: addr,
                          groupValue: _selectedAddress,
                          onChanged: (val) {
                            if (val != null) setState(() => _selectedAddress = val);
                          },
                          activeColor: AppColors.primary,
                          title: Text(addr.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          subtitle: Text('${addr.blockOrRoom} • ${addr.landmark}',
                              style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 20),

                    // Payment Method Selection
                    Text(
                      'PAYMENT METHOD',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _paymentOptionTile('UPI (GPay / PhonePe / Paytm)', 'UPI', LucideIcons.smartphone),
                    _paymentOptionTile('Cash on Delivery (COD)', 'COD', LucideIcons.banknote),
                    _paymentOptionTile('Razorpay (Cards / Netbanking)', 'CARD', LucideIcons.creditCard),
                    const SizedBox(height: 20),

                    // Special Instructions
                    Text(
                      'DELIVERY INSTRUCTIONS',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _notesController,
                      decoration: InputDecoration(
                        hintText: 'e.g. Leave at hostel reception or OPD counter...',
                        hintStyle: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.cardBorder),
                        ),
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Confirm Order Bar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -4)),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  final newOrder = ref.read(orderProvider.notifier).createOrder(
                        items: cartState.items,
                        subtotal: cartState.subtotal,
                        deliveryFee: cartState.deliveryFee,
                        discount: cartState.couponDiscount,
                        total: cartState.grandTotal,
                        paymentMethod: _selectedPaymentMethod,
                        address: _selectedAddress,
                        notes: _notesController.text,
                      );

                  ref.read(cartProvider.notifier).clearCart();
                  context.go('/order/${newOrder.id}');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'PAY ₹${cartState.grandTotal.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                    Row(
                      children: const [
                        Text('PLACE ORDER', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
                        SizedBox(width: 6),
                        Icon(LucideIcons.check, size: 18),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentOptionTile(String label, String value, IconData icon) {
    final isSelected = _selectedPaymentMethod == value;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.cardBorder,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: RadioListTile<String>(
        value: value,
        groupValue: _selectedPaymentMethod,
        onChanged: (val) {
          if (val != null) setState(() => _selectedPaymentMethod = val);
        },
        activeColor: AppColors.primary,
        secondary: Icon(icon, color: isSelected ? AppColors.primary : AppColors.textMuted),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
      ),
    );
  }
}
