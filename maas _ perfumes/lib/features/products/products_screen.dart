import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/perfumes_data.dart';
import '../search/smart_search.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String _query = '', _filterCategory = 'الكل';

  List<ShopProduct> get filtered {
    var r = smartSearchProducts(_query);
    if (_filterCategory != 'الكل') r = r.where((p) => p.category == _filterCategory).toList();
    return r;
  }

  List<String> get categories => ['الكل', ...shopProducts.map((p) => p.category).toSet()];

  Future<void> _order(ShopProduct p) async {
    const phone = '+249124855469';
    final price = p.hasDiscount ? '${p.discountPrice!.toStringAsFixed(0)} ريال' : '${p.price.toStringAsFixed(0)} ريال';
    final msg = 'مرحباً MAAS PERFUMES 🌺\nأريد طلب: ${p.name}\nالسعر: $price';
    final url = Uri.parse('https://wa.me/$phone?text=${Uri.encodeComponent(msg)}');
    if (await canLaunchUrl(url)) await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0B),
      appBar: AppBar(backgroundColor: const Color(0xFF0B0B0B), iconTheme: const IconThemeData(color: Color(0xFFD4AF37)),
        title: const Text('منتجات MAAS 🏪', style: TextStyle(color: Color(0xFFD4AF37)))),
      body: Column(children: [
        Padding(padding: const EdgeInsets.all(12),
          child: TextField(onChanged: (v) => setState(() => _query = v),
            style: const TextStyle(color: Colors.white), textDirection: TextDirection.rtl,
            decoration: InputDecoration(hintText: 'ابحث في منتجات MAAS...', hintStyle: const TextStyle(color: Colors.white38),
              filled: true, fillColor: const Color(0xFF1A1A1A), prefixIcon: const Icon(Icons.search, color: Color(0xFFD4AF37)),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)))),
        SizedBox(height: 38, child: ListView.builder(
          scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: categories.length,
          itemBuilder: (_, i) {
            final cat = categories[i]; final sel = _filterCategory == cat;
            return GestureDetector(onTap: () => setState(() => _filterCategory = cat),
              child: Container(margin: const EdgeInsets.only(left: 8), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(color: sel ? const Color(0xFFD4AF37) : const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFD4AF37), width: 0.5)),
                child: Text(cat, style: TextStyle(color: sel ? Colors.black : const Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 13))));
          })),
        const SizedBox(height: 12),
        Expanded(child: filtered.isEmpty
          ? const Center(child: Text('لا توجد منتجات', style: TextStyle(color: Colors.white38)))
          : GridView.builder(padding: const EdgeInsets.symmetric(horizontal: 12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.75),
              itemCount: filtered.length,
              itemBuilder: (_, i) {
                final p = filtered[i];
                return Container(
                  decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFF2A2218))),
                  child: Stack(children: [
                    Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Center(child: Container(width: 60, height: 60, decoration: BoxDecoration(color: const Color(0xFF0d0b06), borderRadius: BorderRadius.circular(12)),
                        child: const Center(child: Text('🌺', style: TextStyle(fontSize: 30))))),
                      const SizedBox(height: 10),
                      Text(p.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                      Text(p.category, style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 11)),
                      const Spacer(),
                      if (p.hasDiscount) ...[
                        Text('${p.price.toStringAsFixed(0)} ريال', style: const TextStyle(color: Colors.white38, fontSize: 11, decoration: TextDecoration.lineThrough)),
                        Text('${p.discountPrice!.toStringAsFixed(0)} ريال', style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 15)),
                      ] else Text('${p.price.toStringAsFixed(0)} ريال', style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 8),
                      SizedBox(width: double.infinity, child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF25D366), padding: const EdgeInsets.symmetric(vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        onPressed: () => _order(p),
                        child: const Text('اطلب الآن 💬', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)))),
                    ])),
                    if (p.offerLabel != null) Positioned(top: 8, left: 8, child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(8)), child: Text(p.offerLabel!, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))),
                    if (p.hasDiscount) Positioned(top: 8, right: 8, child: Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3), decoration: BoxDecoration(color: Colors.green.shade800, borderRadius: BorderRadius.circular(8)), child: Text('-${p.discountPercent.toStringAsFixed(0)}%', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))),
                  ]),
                );
              })),
      ]),
    );
  }
}
