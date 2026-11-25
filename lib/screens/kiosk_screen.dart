import 'package:flutter/material.dart';
import '../models/records.dart';
import '../widgets/glass_card.dart';
class KioskScreen extends StatelessWidget {
 const KioskScreen({super.key,required this.sales,required this.onAdd,required this.onDelete,required this.admin});
 final List<WaterSale> sales; final VoidCallback onAdd; final ValueChanged<WaterSale> onDelete; final bool admin;
 @override Widget build(BuildContext context){final total=sales.fold<double>(0,(s,e)=>s+e.total);final balance=sales.fold<double>(0,(s,e)=>s+e.balance);return ListView(padding:const EdgeInsets.all(18),children:[
 Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[const Text('Kiosk ledger',style:TextStyle(fontSize:24,fontWeight:FontWeight.w800)),FilledButton.icon(onPressed:onAdd,icon:const Icon(Icons.add),label:const Text('Record sale'))]),
 const SizedBox(height:16),Row(children:[Expanded(child:_metric('Dispensed value','KES ${total.toStringAsFixed(0)}',Icons.water_drop)),const SizedBox(width:10),Expanded(child:_metric('Outstanding','KES ${balance.toStringAsFixed(0)}',Icons.account_balance_wallet))]),const SizedBox(height:18),
 const Text('Recent transactions',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),const SizedBox(height:8),
 if(sales.isEmpty) const GlassCard(child:Text('No dispensing entries yet. Record your first kiosk sale.')),
 ...sales.reversed.map((s)=>Padding(padding:const EdgeInsets.only(bottom:9),child:GlassCard(child:Row(children:[CircleAvatar(backgroundColor:Colors.teal.withValues(alpha:.16),child:const Icon(Icons.water_drop,color:Colors.teal)),const SizedBox(width:12),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(s.customer,style:const TextStyle(fontWeight:FontWeight.bold)),Text('${s.quantity} ${s.unit} • ${s.paymentMode}',style:Theme.of(context).textTheme.bodySmall)])),Column(crossAxisAlignment:CrossAxisAlignment.end,children:[Text('KES ${s.total.toStringAsFixed(0)}',style:const TextStyle(fontWeight:FontWeight.bold)),Text(s.balance>0?'Due ${s.balance.toStringAsFixed(0)}':'Paid',style:TextStyle(color:s.balance>0?Colors.orange:Colors.green))]),if(admin)IconButton(onPressed:()=>onDelete(s),icon:const Icon(Icons.delete_outline))]))))
 ]);}
 Widget _metric(String label,String value,IconData icon)=>GlassCard(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Icon(icon,color:Colors.teal),const SizedBox(height:12),Text(value,style:const TextStyle(fontSize:19,fontWeight:FontWeight.w800)),Text(label,style:const TextStyle(fontSize:12))]));
}
