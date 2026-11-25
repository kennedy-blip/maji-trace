import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.role, required this.theme, required this.tariff, required this.records, required this.capacity, required this.baseline, required this.onRole, required this.onTheme, required this.onTariff, required this.onTankConfig, required this.onDownloadApk, required this.onExport});
  final String role, theme;
  final double tariff, capacity, baseline;
  final int records;
  final ValueChanged<String> onRole, onTheme;
  final ValueChanged<double> onTariff;
  final ValueChanged<(double, double)> onTankConfig;
  final VoidCallback onDownloadApk, onExport;

  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Settings & APK center', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
    const SizedBox(height: 16),
    GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Access role', style: TextStyle(fontWeight: FontWeight.bold)),
      DropdownButton<String>(isExpanded: true, value: role, items: const ['Water Committee Admin', 'Kiosk Attendant'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(), onChanged: (v) { if (v != null) onRole(v); }),
      const SizedBox(height: 12),
      const Text('Appearance', style: TextStyle(fontWeight: FontWeight.bold)),
      DropdownButton<String>(isExpanded: true, value: theme, items: const ['Aqua Obsidian', 'Daylight Spring', 'High-Contrast Kiosk'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(), onChanged: (v) { if (v != null) onTheme(v); }),
      if (role == 'Water Committee Admin') ...[
        const Divider(height: 26),
        Text('Tariff • KES ${tariff.toStringAsFixed(2)} / litre'),
        Slider(value: tariff.clamp(.1, 100), min: .1, max: 100, divisions: 999, onChanged: onTariff),
        const Divider(height: 20),
        Text('Tank baseline • ${baseline.toStringAsFixed(0)} L'),
        Text('Tank capacity • ${capacity.toStringAsFixed(0)} L'),
        TextButton.icon(onPressed: () => _editTank(context), icon: const Icon(Icons.tune), label: const Text('Adjust tank baseline & capacity')),
      ],
    ])),
    const SizedBox(height: 12),
    GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Local storage', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('$records saved records • stored on this device'),
      const SizedBox(height: 12),
      const Row(children: [Icon(Icons.offline_pin, color: Colors.green), SizedBox(width: 8), Text('Offline-ready • sync not required')]),
    ])),
    const SizedBox(height: 12),
    GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Android package', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      const Text('Open the latest GitHub Actions release to download the compiled APK.'),
      const SizedBox(height: 12),
      FilledButton.icon(onPressed: onDownloadApk, icon: const Icon(Icons.download), label: const Text('Download Android APK')),
    ])),
    const SizedBox(height: 10),
    OutlinedButton.icon(onPressed: onExport, icon: const Icon(Icons.copy), label: const Text('Copy CSV ledger summary')),
  ]);

  Future<void> _editTank(BuildContext context) async {
    final b = TextEditingController(text: baseline.toStringAsFixed(0));
    final c = TextEditingController(text: capacity.toStringAsFixed(0));
    final ok = await showDialog<bool>(context: context, builder: (ctx) => AlertDialog(
      title: const Text('Tank configuration'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: b, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Starting baseline (litres)')),
        TextField(controller: c, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Capacity (litres)')),
      ]),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
        FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Save')),
      ],
    ));
    final bv = double.tryParse(b.text), cv = double.tryParse(c.text);
    if (ok == true && bv != null && cv != null && bv >= 0 && cv > 0 && bv <= cv) onTankConfig((bv, cv));
  }
}
