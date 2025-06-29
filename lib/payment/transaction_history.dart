import 'package:flutter/material.dart';

/// Model representing each transaction entry
class TransactionEntry {
  final String transactionId;
  final String userId;
  final String packageType; // 'Monthly', 'Yearly', 'Lifetime'
  final double amount;
  final DateTime timestamp;
  final String paymentMethod; // 'UPI', 'Card', 'Bank Transfer'
  final String status; // 'Success', 'Pending', 'Failed'

  TransactionEntry({
    required this.transactionId,
    required this.userId,
    required this.packageType,
    required this.amount,
    required this.timestamp,
    required this.paymentMethod,
    required this.status,
  });
}

/// A sample list of dummy transactions
final List<TransactionEntry> dummyTransactions = [
  TransactionEntry(
    transactionId: 'TXN1001',
    userId: 'user_001',
    packageType: 'Monthly',
    amount: 99.00,
    timestamp: DateTime.now().subtract(Duration(days: 1)),
    paymentMethod: 'UPI',
    status: 'Success',
  ),
  TransactionEntry(
    transactionId: 'TXN1002',
    userId: 'user_002',
    packageType: 'Lifetime',
    amount: 999.00,
    timestamp: DateTime.now().subtract(Duration(days: 3)),
    paymentMethod: 'Card',
    status: 'Success',
  ),
  TransactionEntry(
    transactionId: 'TXN1003',
    userId: 'user_003',
    packageType: 'Yearly',
    amount: 499.00,
    timestamp: DateTime.now().subtract(Duration(days: 5)),
    paymentMethod: 'Bank Transfer',
    status: 'Pending',
  ),
];

/// UI Screen to display transaction history
class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  String formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$day/$month/$year $hour:$minute';
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'success':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
      ),
      body: ListView.builder(
        itemCount: dummyTransactions.length,
        itemBuilder: (context, index) {
          final tx = dummyTransactions[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 3,
            child: ListTile(
              leading: Icon(Icons.payment, color: getStatusColor(tx.status)),
              title: Text(
                '${tx.packageType} - ₹${tx.amount.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                'Method: ${tx.paymentMethod}\nDate: ${formatDate(tx.timestamp)}',
                style: const TextStyle(fontSize: 13),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    tx.status,
                    style: TextStyle(
                      color: getStatusColor(tx.status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ID: ${tx.transactionId}',
                    style: const TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}