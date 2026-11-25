import 'package:flutter_test/flutter_test.dart';
import 'package:maji_trace/models/records.dart';

void main() {
  test('sale computes total and outstanding balance', () {
    final sale = WaterSale(id: '1', customer: 'Sample', quantity: 20, unit: 'L', unitPrice: 2.5, paid: 30, paymentMode: 'Cash', createdAt: DateTime(2026));
    expect(sale.total, 50);
    expect(sale.balance, 20);
  });
}
