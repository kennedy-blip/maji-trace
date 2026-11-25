import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/records.dart';

class LedgerStore {
  static final LedgerStore instance=LedgerStore._();
  LedgerStore._();
  final _uuid=const Uuid();
  late Box _box;
  Future<void> init() async { await Hive.initFlutter(); _box=await Hive.openBox('maji_trace_v1'); }
  String id()=>_uuid.v4();
  List<WaterSale> get sales => _read('sales',WaterSale.fromJson);
  List<Refill> get refills => _read('refills',Refill.fromJson);
  List<FaultTicket> get faults => _read('faults',FaultTicket.fromJson);
  List<T> _read<T>(String key,T Function(Map<String,dynamic>) parse) { final raw=_box.get(key,defaultValue:'[]') as String; return (jsonDecode(raw) as List).map((e)=>parse(Map<String,dynamic>.from(e))).toList(); }
  Future<void> saveSales(List<WaterSale> v)=>_box.put('sales',jsonEncode(v.map((e)=>e.toJson()).toList()));
  Future<void> saveRefills(List<Refill> v)=>_box.put('refills',jsonEncode(v.map((e)=>e.toJson()).toList()));
  Future<void> saveFaults(List<FaultTicket> v)=>_box.put('faults',jsonEncode(v.map((e)=>e.toJson()).toList()));
  double get tariff=>(_box.get('tariff',defaultValue:2.0) as num).toDouble();
  Future<void> setTariff(double value)=>_box.put('tariff',value);
  double get tankCapacity=>(_box.get('capacity',defaultValue:10000.0) as num).toDouble();
  double get tankBaseline=>(_box.get('baseline',defaultValue:7000.0) as num).toDouble();
  Future<void> setTank({required double capacity,required double baseline}) async { await _box.put('capacity',capacity); await _box.put('baseline',baseline); }
  String get theme=>_box.get('theme',defaultValue:'Aqua Obsidian') as String;
  Future<void> setTheme(String v)=>_box.put('theme',v);
  String get role=>_box.get('role',defaultValue:'Water Committee Admin') as String;
  Future<void> setRole(String v)=>_box.put('role',v);
  int get recordCount=>sales.length+refills.length+faults.length;
}
