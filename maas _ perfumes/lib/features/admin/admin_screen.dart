import 'package:flutter/material.dart';
import '../../data/perfumes_data.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  Widget _field(String label, TextEditingController ctrl, {TextInputType type = TextInputType.text}) {
    return Padding(padding: const EdgeInsets.only(bottom: 10),
      child: TextField(controller: ctrl, keyboardType: type, style: const TextStyle(color: Colors.white), textDirection: TextDirection.rtl,
        decoration: InputDecoration(labelText: label, labelStyle: const TextStyle(color: Color(0xFFD4AF37), fontSize: 13),
          filled: true, fillColor: const Color(0xFF0d0d0d), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none))));
  }

  void _editProduct(ShopProduct p) {
    final nc = TextEditingController(text: p.name);
    final dc = TextEditingController(text: p.description);
    final pc = TextEditingController(text: p.price.toStringAsFixed(0));
    final dsc = TextEditingController(text: p.discountPrice?.toStringAsFixed(0) ?? '');
    final oc = TextEditingController(text: p.offerLabel ?? '');
    bool avail = p.isAvailable;
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => StatefulBuilder(builder: (ctx, set) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom, left: 16, right: 16, top: 20),
        child: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('✏️ تعديل المنتج', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _field('اسم المنتج', nc), _field('الوصف', dc),
          _field('السعر', pc, type: TextInputType.number), _field('سعر الخصم', dsc, type: TextInputType.number),
          _field('تسمية العرض', oc),
          Row(children: [const Text('متوفر:', style: TextStyle(color: Colors.white70)), const Spacer(),
            Switch(value: avail, activeColor: const Color(0xFFD4AF37), onChanged: (v) => set(() => avail = v))]),
          const SizedBox(height: 12),
          SizedBox(width: double.infinity, child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            onPressed: () {
              setState(() { p.name = nc.text; p.description = dc.text; p.price = double.tryParse(pc.text) ?? p.price; p.discountPrice = dsc.text.isEmpty ? null : double.tryParse(dsc.text); p.offerLabel = oc.text.isEmpty ? null : oc.text; p.isAvailable = avail; });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('✅ تم الحفظ'), backgroundColor: Color(0xFF1a3a1a)));
            },
            child: const Text('💾 حفظ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))),
          const SizedBox(height: 20),
        ])))));
  }

  void _addProduct() {
    final nc = TextEditingController(); final dc = TextEditingController();
    final pc = TextEditingController(); final dsc = TextEditingController(); final oc = TextEditingController();
    String cat = 'رجالي';
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => StatefulBuilder(builder: (ctx, set) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom, left: 16, right: 16, top: 20),
        child: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('➕ إضافة منتج', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _field('اسم المنتج *', nc), _field('الوصف', dc),
          _field('السعر *', pc, type: TextInputType.number), _field('سعر الخصم', dsc, type: TextInputType.number),
          _field('تسمية العرض', oc),
          DropdownButtonFormField<String>(value: cat, dropdownColor: const Color(0xFF1A1A1A), style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(labelText: 'الفئة', labelStyle: const TextStyle(color: Color(0xFFD4AF37)), filled: true, fillColor: const Color(0xFF0d0d0d), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none)),
            items: ['رجالي','نسائي','رياضي','عربي','مختلط','فاخر'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (v) => set(() => cat = v ?? cat)),
          const SizedBox(height: 12),
          SizedBox(width: double.infinity, child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            onPressed: () {
              if (nc.text.isEmpty || pc.text.isEmpty) { ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(content: Text('ملء الاسم والسعر مطلوب'), backgroundColor: Colors.red)); return; }
              setState(() => shopProducts.add(ShopProduct(id: 's${DateTime.now().millisecondsSinceEpoch}', name: nc.text, description: dc.text, price: double.tryParse(pc.text) ?? 0, discountPrice: dsc.text.isEmpty ? null : double.tryParse(dsc.text), offerLabel: oc.text.isEmpty ? null : oc.text, category: cat)));
              Navigator.pop(context);
            },
            child: const Text('➕ إضافة', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))),
          const SizedBox(height: 20),
        ])))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0B),
      appBar: AppBar(backgroundColor: const Color(0xFF0B0B0B), iconTheme: const IconThemeData(color: Color(0xFFD4AF37)),
        title: const Text('⚙️ إدارة MAAS', style: TextStyle(color: Color(0xFFD4AF37)))),
      floatingActionButton: FloatingActionButton.extended(backgroundColor: const Color(0xFFD4AF37), onPressed: _addProduct,
        icon: const Icon(Icons.add, color: Colors.black), label: const Text('منتج جديد', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      body: ListView.builder(padding: const EdgeInsets.all(12), itemCount: shopProducts.length,
        itemBuilder: (_, i) {
          final p = shopProducts[i];
          return Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12), border: Border.all(color: p.isAvailable ? const Color(0xFF2A2218) : Colors.red.shade900)),
            child: Row(children: [
              const Text('🌺', style: TextStyle(fontSize: 28)), const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(p.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text('${p.price.toStringAsFixed(0)} ريال', style: TextStyle(color: p.hasDiscount ? Colors.white38 : const Color(0xFFD4AF37), fontSize: 12, decoration: p.hasDiscount ? TextDecoration.lineThrough : null)),
                Text(p.isAvailable ? '✅ متوفر' : '❌ غير متوفر', style: TextStyle(color: p.isAvailable ? Colors.green : Colors.red, fontSize: 11)),
              ])),
              IconButton(icon: const Icon(Icons.edit, color: Color(0xFFD4AF37), size: 20), onPressed: () => _editProduct(p)),
              IconButton(icon: const Icon(Icons.delete, color: Colors.red, size: 20), onPressed: () => setState(() => shopProducts.removeAt(i))),
            ]));
        }),
    );
  }
}
