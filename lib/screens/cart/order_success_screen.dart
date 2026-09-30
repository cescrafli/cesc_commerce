import 'package:flutter/material.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/core/globals.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check_circle, size: 80, color: Theme.of(context).primaryColor),
              ),
              const SizedBox(height: 30),
              const Text(
                'Yay! Order Placed! \u{1F389}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Your order has been placed successfully and will be processed soon.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (globalOrders.value.isNotEmpty) {
                      final orderData = globalOrders.value.first;
                      final orderId = orderData['id'];
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => OrderTrackingScreen(orderId: orderId, orderData: orderData)));
                    } else {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OrderTrackingScreen()));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Track Order', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
                  (route) => false,
                ),
                child: Text(
                  'Back to Home',
                  style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
