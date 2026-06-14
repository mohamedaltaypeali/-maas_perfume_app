import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/perfumes_data.dart';

class PerfumeDetailsScreen extends StatelessWidget {
  final Perfume perfume;
  const PerfumeDetailsScreen({super.key, required this.perfume});

  Future<void> _orderOnWhatsApp() async {
    const phone = '+249124855469';
    final message = 'مرحباً MAAS PERFUMES 🌺\nأريد الاستفسار عن: ${perfume.name} (${perfume.brand})';
    final url = Uri.parse('https://wa.me/$phone?text=${Uri.encodeComponent(message)}');
    if (await canLaunchUrl(url)) await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0B0B),
        iconTheme: const IconThemeData(color: Color(0xFFD4AF37)),
        title: Text(perfume.name, style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 16)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity, padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFD4AF37), width: 0.5)),
              child: Column(children: [
                const Text('🌸', style: TextStyle(fontSize: 50)),
                const SizedBox(height: 12),
                Text(perfume.name, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                Text(perfume.brand, style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 16)),
                const SizedBox(height: 12),
                Wrap(spacing: 8, children: [perfume.gender, perfume.family, perfume.category].map((t) =>
                  Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: const Color(0xFF0d0b06), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFD4AF37), width: 0.5)),
                    child: Text(t, style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 11)))
                ).toList()),
              ]),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFF2A2218))),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('🎵 هرم النوتات', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 14),
                _notesRow('🍋 نوتات القمة', perfume.topNotes, const Color(0xFFE8C97A)),
                const SizedBox(height: 10),
                _notesRow('🌸 نوتات القلب', perfume.heartNotes, const Color(0xFFD4AF37)),
                const SizedBox(height: 10),
                _notesRow('🌳 نوتات القاعدة', perfume.baseNotes, const Color(0xFF7A6230)),
              ]),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF25D366), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                onPressed: _orderOnWhatsApp,
                icon: const Icon(Icons.chat, color: Colors.white),
                label: const Text('اطلب عبر واتساب', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _notesRow(String title, List<String> notes, Color color) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
      const SizedBox(height: 6),
      Wrap(spacing: 6, runSpacing: 6, children: notes.map((n) =>
        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: const Color(0xFF0d0b06), borderRadius: BorderRadius.circular(20), border: Border.all(color: color.withOpacity(0.5))),
          child: Text(n, style: TextStyle(color: color, fontSize: 12)))
      ).toList()),
    ]);
  }
}
