import 'dart:convert';

class WaterSale {
  WaterSale({required this.id, required this.customer, required this.quantity, required this.unit, required this.unitPrice, required this.paid, required this.paymentMode, required this.createdAt});
  final String id, customer, unit, paymentMode;
  final double quantity, unitPrice, paid;
  final DateTime createdAt;
  double get total => quantity * unitPrice;
  double get balance => total - paid;
  Map<String,dynamic> toJson()=>{'id':id,'customer':customer,'quantity':quantity,'unit':unit,'unitPrice':unitPrice,'paid':paid,'paymentMode':paymentMode,'createdAt':createdAt.toIso8601String()};
  factory WaterSale.fromJson(Map<String,dynamic> j)=>WaterSale(id:j['id'],customer:j['customer'],quantity:(j['quantity'] as num).toDouble(),unit:j['unit'],unitPrice:(j['unitPrice'] as num).toDouble(),paid:(j['paid'] as num).toDouble(),paymentMode:j['paymentMode'],createdAt:DateTime.parse(j['createdAt']));
}
class Refill {
  Refill({required this.id,required this.source,required this.liters,required this.cost,required this.createdAt, this.note=''});
  final String id,source,note; final double liters,cost; final DateTime createdAt;
  Map<String,dynamic> toJson()=>{'id':id,'source':source,'liters':liters,'cost':cost,'createdAt':createdAt.toIso8601String(),'note':note};
  factory Refill.fromJson(Map<String,dynamic> j)=>Refill(id:j['id'],source:j['source'],liters:(j['liters'] as num).toDouble(),cost:(j['cost'] as num).toDouble(),createdAt:DateTime.parse(j['createdAt']),note:j['note']??'');
}
class FaultTicket {
  FaultTicket({required this.id,required this.location,required this.issue,required this.severity,required this.status,required this.createdAt,this.notes='',this.repairNotes=''});
  final String id,location,issue,severity,status,notes,repairNotes; final DateTime createdAt;
  Map<String,dynamic> toJson()=>{'id':id,'location':location,'issue':issue,'severity':severity,'status':status,'createdAt':createdAt.toIso8601String(),'notes':notes,'repairNotes':repairNotes};
  factory FaultTicket.fromJson(Map<String,dynamic> j)=>FaultTicket(id:j['id'],location:j['location'],issue:j['issue'],severity:j['severity'],status:j['status'],createdAt:DateTime.parse(j['createdAt']),notes:j['notes']??'',repairNotes:j['repairNotes']??'');
}
String encodeRows<T>(List<T> rows, Map<String,dynamic> Function(T) encode)=>jsonEncode(rows.map(encode).toList());
