import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/perfumes_data.dart';
import 'smart_search.dart';
import '../perfume_details/perfume_details_screen.dart';
import '../products/products_screen.dart';
import '../admin/admin_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchCtrl = TextEditingController();
  String _query = '';

  List<Perfume> get perfumeResults => smartSearchPerfumes(_query);
  List<Ingredient> get ingredientResults => smartSearchIngredients(_query);

  Future<void> _openWhatsApp() async {
    const phone = '+249124855469';
    const message = 'مرحباً، أريد الاستفسار عن العطور في MAAS PERFUMES 🌺';
    final url = Uri.parse('https://wa.me/$phone?text=${Uri.encodeComponent(message)}');
    if (await canLaunchUrl(url)) await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0B0B),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('MAAS PERFUMES', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 2)),
            Text('خبير العطور 🌺', style: TextStyle(color: Colors.white54, fontSize: 11)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.store, color: Color(0xFFD4AF37)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductsScreen()))),
          IconButton(icon: const Icon(Icons.admin_panel_settings, color: Color(0xFFD4AF37)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminScreen()))),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFD4AF37),
          labelColor: const Color(0xFFD4AF37),
          unselectedLabelColor: Colors.white38,
          tabs: const [Tab(text: '🌍 عطور عالمية'), Tab(text: '🧪 خامات')],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (v) => setState(() => _query = v),
              style: const TextStyle(color: Colors.white),
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: 'ابحث بالاسم أو النوتة أو العائلة...',
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true, fillColor: const Color(0xFF1A1A1A),
                prefixIcon: const Icon(Icons.search, color: Color(0xFFD4AF37)),
                suffixIcon: _query.isNotEmpty
                  ? IconButton(icon: const Icon(Icons.clear, color: Colors.white38),
                      onPressed: () => setState(() { _query = ''; _searchCtrl.clear(); }))
                  : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildPerfumeList(), _buildIngredientList()],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF25D366),
        onPressed: _openWhatsApp,
        icon: const Icon(Icons.chat, color: Colors.white),
        label: const Text('واتساب', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildPerfumeList() {
    final results = perfumeResults;
    if (results.isEmpty) return const Center(child: Text('لا نتائج', style: TextStyle(color: Colors.white38)));
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: results.length,
      itemBuilder: (context, i) {
        final p = results[i];
        return GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PerfumeDetailsScreen(perfume: p))),
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF2A2218))),
            child: Row(
              children: [
                Container(width: 46, height: 46,
                  decoration: BoxDecoration(color: const Color(0xFF0d0b06), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFD4AF37), width: 0.5)),
                  child: const Center(child: Text('🌸', style: TextStyle(fontSize: 22)))),
                const SizedBox(width: 12),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                    Text('${p.brand} • ${p.gender}', style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 12)),
                    Text(p.allNotes.take(3).join(' • '), style: const TextStyle(color: Colors.white38, fontSize: 11)),
                  ],
                )),
                const Icon(Icons.arrow_back_ios, color: Color(0xFFD4AF37), size: 14),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildIngredientList() {
    final results = ingredientResults;
    final categories = results.map((i) => i.category).toSet().toList();
    if (results.isEmpty) return const Center(child: Text('لا نتائج', style: TextStyle(color: Colors.white38)));
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: categories.length,
      itemBuilder: (context, ci) {
        final cat = categories[ci];
        final items = results.where((i) => i.category == cat).toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text('• $cat', style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 14))),
            ...items.map((ing) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF2A2218))),
              child: Row(children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(ing.nameAr, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text('${ing.nameEn} • ${ing.origin}', style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 11)),
                  Text(ing.description, style: const TextStyle(color: Colors.white38, fontSize: 11)),
                ])),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFF0d0b06), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFD4AF37), width: 0.5)),
                  child: Text(ing.category, style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 10))),
              ]),
            )),
          ],
        );
      },
    );
  }
}
