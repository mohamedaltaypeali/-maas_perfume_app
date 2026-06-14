class Perfume {
  final String id, name, brand, description, category, family, gender;
  final List<String> topNotes, heartNotes, baseNotes;
  Perfume({required this.id, required this.name, required this.brand,
    required this.description, required this.category, required this.family,
    required this.gender, required this.topNotes, required this.heartNotes,
    required this.baseNotes});
  List<String> get allNotes => [...topNotes, ...heartNotes, ...baseNotes];
}

class Ingredient {
  final String id, nameAr, nameEn, category, description, origin;
  Ingredient({required this.id, required this.nameAr, required this.nameEn,
    required this.category, required this.description, required this.origin});
}

class ShopProduct {
  final String id;
  String name, description, category;
  double price;
  double? discountPrice;
  bool isAvailable;
  String? offerLabel;
  List<String> notes;
  ShopProduct({required this.id, required this.name, required this.description,
    required this.price, this.discountPrice, required this.category,
    this.isAvailable = true, this.offerLabel, this.notes = const []});
  bool get hasDiscount => discountPrice != null && discountPrice! < price;
  double get discountPercent =>
      hasDiscount ? ((price - discountPrice!) / price * 100) : 0;
}

final List<Perfume> worldPerfumes = [
  Perfume(id:'p001', name:'بلو دي شانيل', brand:'Chanel', description:'عطر خشبي منعش فاخر', category:'فاخر', gender:'رجالي', family:'خشبي عطري', topNotes:['ليمون','نعناع','جريب فروت'], heartNotes:['زنجبيل','جاسمين'], baseNotes:['خشب صندل','عنبر','باتشولي']),
  Perfume(id:'p002', name:'سافاج', brand:'Dior', description:'عطر قوي من دار ديور', category:'فاخر', gender:'رجالي', family:'خشبي عطري', topNotes:['فلفل كالابريا','برغموت'], heartNotes:['لافندر','ورد'], baseNotes:['خشب صندل','لبان']),
  Perfume(id:'p003', name:'أنفكتوس', brand:'Paco Rabanne', description:'عطر رياضي بحري', category:'رياضي', gender:'رجالي', family:'بحري خشبي', topNotes:['جريب فروت','بحر'], heartNotes:['ورد البحر'], baseNotes:['خشب الأرز']),
  Perfume(id:'p004', name:'ون مليون', brand:'Paco Rabanne', description:'عطر حلو فاخر', category:'فاخر', gender:'رجالي', family:'شرقي حلو', topNotes:['دم التنين','نعناع'], heartNotes:['ورد','قرفة'], baseNotes:['جلد','خشب صندل']),
  Perfume(id:'p005', name:'أور دي هيرمس', brand:'Hermès', description:'عطر خشبي دافئ', category:'فاخر', gender:'رجالي', family:'خشبي', topNotes:['برتقال','ليمون'], heartNotes:['ورد'], baseNotes:['خشب صندل','مسك']),
  Perfume(id:'p006', name:'لا نيت دي لهوم', brand:'YSL', description:'عطر ليلي فاخر', category:'فاخر', gender:'رجالي', family:'فوجير شرقي', topNotes:['حمضيات','لافندر'], heartNotes:['قرفة'], baseNotes:['فانيليا','خشب صندل']),
  Perfume(id:'p007', name:'أليور هوم سبورت', brand:'Chanel', description:'عطر رياضي منعش', category:'رياضي', gender:'رجالي', family:'منعش خشبي', topNotes:['نعناع','برتقال'], heartNotes:['شيح'], baseNotes:['مسك أبيض','خشب صندل']),
  Perfume(id:'p008', name:'بلاك أوبيوم', brand:'YSL', description:'عطر مثير للنساء', category:'فاخر', gender:'نسائي', family:'شرقي فانيليا', topNotes:['كمثرى'], heartNotes:['قهوة','ياسمين'], baseNotes:['فانيليا','باتشولي']),
  Perfume(id:'p009', name:'جود جيرل', brand:'YSL', description:'عطر زهري فاكهي', category:'فاخر', gender:'نسائي', family:'زهري فاكهي', topNotes:['كمثرى','توت'], heartNotes:['ورد','ياسمين'], baseNotes:['فانيليا','مسك']),
  Perfume(id:'p010', name:'أكوا دي جيو', brand:'Giorgio Armani', description:'عطر بحري كلاسيكي', category:'كلاسيكي', gender:'رجالي', family:'بحري', topNotes:['برغموت','ليمون'], heartNotes:['ياسمين','لافندر'], baseNotes:['سيدار','مسك']),
  Perfume(id:'p011', name:'عود الليل', brand:'عربي', description:'عطر عودي شرقي', category:'عربي', gender:'مختلط', family:'عودي شرقي', topNotes:['عود','ورد'], heartNotes:['مسك','عنبر'], baseNotes:['صندل','بخور']),
  Perfume(id:'p012', name:'شيخ الشيوخ', brand:'عربي', description:'عطر ملكي فاخر', category:'عربي', gender:'رجالي', family:'عودي مسكي', topNotes:['عود','زعفران'], heartNotes:['ورد الطائف'], baseNotes:['عنبر','بخور']),
  Perfume(id:'p013', name:'كريد أفنتوس', brand:'Creed', description:'عطر فاكهي أسطوري', category:'فاخر', gender:'رجالي', family:'فاكهي خشبي', topNotes:['أناناس','كاسيس','برغموت'], heartNotes:['باتشولي','ياسمين'], baseNotes:['مسك','عنبر','عود']),
  Perfume(id:'p014', name:'توم فورد أود وود', brand:'Tom Ford', description:'عطر عودي خشبي', category:'فاخر', gender:'مختلط', family:'عودي خشبي', topNotes:['فلفل ورد'], heartNotes:['عود','خشب صندل'], baseNotes:['فانيليا']),
  Perfume(id:'p015', name:'بيفري هيلز', brand:'Giorgio Armani', description:'عطر زهري كلاسيكي', category:'فاخر', gender:'نسائي', family:'زهري', topNotes:['برغموت','ليمون'], heartNotes:['ورد','ياسمين'], baseNotes:['مسك','خشب صندل']),
];

final List<Ingredient> worldIngredients = [
  Ingredient(id:'i001', nameAr:'برغموت', nameEn:'Bergamot', category:'حمضيات', description:'حمضي منعش', origin:'إيطاليا'),
  Ingredient(id:'i002', nameAr:'ليمون', nameEn:'Lemon', category:'حمضيات', description:'حمضي نضر', origin:'البحر المتوسط'),
  Ingredient(id:'i003', nameAr:'جريب فروت', nameEn:'Grapefruit', category:'حمضيات', description:'حمضي مر منعش', origin:'أمريكا'),
  Ingredient(id:'i004', nameAr:'برتقال', nameEn:'Orange', category:'حمضيات', description:'حلو حمضي', origin:'البحر المتوسط'),
  Ingredient(id:'i005', nameAr:'مانداران', nameEn:'Mandarin', category:'حمضيات', description:'حلو خفيف', origin:'الصين'),
  Ingredient(id:'i006', nameAr:'يوزو', nameEn:'Yuzu', category:'حمضيات', description:'حمضي ياباني', origin:'اليابان'),
  Ingredient(id:'i007', nameAr:'ورد', nameEn:'Rose', category:'أزهار', description:'زهري رومانسي', origin:'بلغاريا'),
  Ingredient(id:'i008', nameAr:'ياسمين', nameEn:'Jasmine', category:'أزهار', description:'زهري حلو', origin:'الهند'),
  Ingredient(id:'i009', nameAr:'لافندر', nameEn:'Lavender', category:'أزهار', description:'عطري مهدئ', origin:'فرنسا'),
  Ingredient(id:'i010', nameAr:'زهر البرتقال', nameEn:'Orange Blossom', category:'أزهار', description:'زهري حلو', origin:'تونس'),
  Ingredient(id:'i011', nameAr:'إيلانج إيلانج', nameEn:'Ylang Ylang', category:'أزهار', description:'زهري استوائي', origin:'جزر القمر'),
  Ingredient(id:'i012', nameAr:'زنبق الوادي', nameEn:'Lily of the Valley', category:'أزهار', description:'زهري ربيعي', origin:'أوروبا'),
  Ingredient(id:'i013', nameAr:'توليب', nameEn:'Tuberose', category:'أزهار', description:'زهري كريمي', origin:'المكسيك'),
  Ingredient(id:'i014', nameAr:'خشب الصندل', nameEn:'Sandalwood', category:'خشبيات', description:'خشبي دافئ', origin:'الهند'),
  Ingredient(id:'i015', nameAr:'خشب الأرز', nameEn:'Cedarwood', category:'خشبيات', description:'خشبي جاف', origin:'المغرب'),
  Ingredient(id:'i016', nameAr:'باتشولي', nameEn:'Patchouli', category:'خشبيات', description:'ترابي عميق', origin:'إندونيسيا'),
  Ingredient(id:'i017', nameAr:'فيتيفر', nameEn:'Vetiver', category:'خشبيات', description:'ترابي دخاني', origin:'هايتي'),
  Ingredient(id:'i018', nameAr:'عود', nameEn:'Oud', category:'خشبيات', description:'خشبي دخاني', origin:'جنوب شرق آسيا'),
  Ingredient(id:'i019', nameAr:'خشب الورد', nameEn:'Rosewood', category:'خشبيات', description:'خشبي وردي', origin:'البرازيل'),
  Ingredient(id:'i020', nameAr:'مسك أبيض', nameEn:'White Musk', category:'مسكيات', description:'ناعم نظيف', origin:'تخليقي'),
  Ingredient(id:'i021', nameAr:'مسك طبيعي', nameEn:'Natural Musk', category:'مسكيات', description:'دافئ حيواني', origin:'تخليقي'),
  Ingredient(id:'i022', nameAr:'عنبر', nameEn:'Ambergris', category:'عنبريات', description:'دافئ بحري', origin:'حوت العنبر'),
  Ingredient(id:'i023', nameAr:'عنبر رمادي', nameEn:'Ambroxan', category:'عنبريات', description:'عنبري قوي', origin:'تخليقي'),
  Ingredient(id:'i024', nameAr:'قرفة', nameEn:'Cinnamon', category:'توابل', description:'حار حلو', origin:'سريلانكا'),
  Ingredient(id:'i025', nameAr:'كارداموم', nameEn:'Cardamom', category:'توابل', description:'حار عطري', origin:'الهند'),
  Ingredient(id:'i026', nameAr:'فلفل أسود', nameEn:'Black Pepper', category:'توابل', description:'حار جاف', origin:'الهند'),
  Ingredient(id:'i027', nameAr:'زعفران', nameEn:'Saffron', category:'توابل', description:'ذهبي دافئ', origin:'إيران'),
  Ingredient(id:'i028', nameAr:'زنجبيل', nameEn:'Ginger', category:'توابل', description:'حار منعش', origin:'الصين'),
  Ingredient(id:'i029', nameAr:'فانيليا', nameEn:'Vanilla', category:'توابل', description:'حلو كريمي', origin:'مدغشقر'),
  Ingredient(id:'i030', nameAr:'لبان', nameEn:'Frankincense', category:'راتنجات', description:'دخاني روحاني', origin:'عُمان'),
  Ingredient(id:'i031', nameAr:'مر', nameEn:'Myrrh', category:'راتنجات', description:'راتنجي دافئ', origin:'الصومال'),
  Ingredient(id:'i032', nameAr:'بنزوين', nameEn:'Benzoin', category:'راتنجات', description:'حلو دافئ', origin:'تايلاند'),
  Ingredient(id:'i033', nameAr:'لبدانوم', nameEn:'Labdanum', category:'راتنجات', description:'عنبري جلدي', origin:'البحر المتوسط'),
  Ingredient(id:'i034', nameAr:'أناناس', nameEn:'Pineapple', category:'فواكه', description:'فاكهي استوائي', origin:'استوائي'),
  Ingredient(id:'i035', nameAr:'تفاح', nameEn:'Apple', category:'فواكه', description:'فاكهي طازج', origin:'أوروبا'),
  Ingredient(id:'i036', nameAr:'كاسيس', nameEn:'Blackcurrant', category:'فواكه', description:'حلو حامض', origin:'أوروبا'),
  Ingredient(id:'i037', nameAr:'خوخ', nameEn:'Peach', category:'فواكه', description:'فاكهي ناعم', origin:'الصين'),
  Ingredient(id:'i038', nameAr:'نوت بحري', nameEn:'Marine Note', category:'بحريات', description:'بحري أوزوني', origin:'تخليقي'),
  Ingredient(id:'i039', nameAr:'أوزون', nameEn:'Ozone', category:'بحريات', description:'هوائي نظيف', origin:'تخليقي'),
  Ingredient(id:'i040', nameAr:'نعناع', nameEn:'Mint', category:'أعشاب', description:'منعش بارد', origin:'عالمي'),
  Ingredient(id:'i041', nameAr:'بازيليكا', nameEn:'Basil', category:'أعشاب', description:'عشبي منعش', origin:'البحر المتوسط'),
  Ingredient(id:'i042', nameAr:'شيح', nameEn:'Artemisia', category:'أعشاب', description:'عشبي مر', origin:'أوروبا'),
];

List<ShopProduct> shopProducts = [
  ShopProduct(id:'s001', name:'بلو دي شانيل - نسخة MAAS', description:'نسخة فاخرة مستوحاة من Blue de Chanel', price:150, discountPrice:120, category:'رجالي', offerLabel:'خصم 20%', notes:['خشب صندل','حمضيات','عنبر']),
  ShopProduct(id:'s002', name:'أنفكتوس الرياضي', description:'عطر بحري منعش للرياضيين', price:120, category:'رياضي', notes:['بحري','حمضي','مسك']),
  ShopProduct(id:'s003', name:'عود الملوك', description:'عطر عودي فاخر خاص بـ MAAS', price:250, discountPrice:200, category:'عربي', offerLabel:'عرض VIP', notes:['عود','زعفران','مسك']),
  ShopProduct(id:'s004', name:'ون مليون - إصدار خاص', description:'نسخة مستوحاة من 1 Million', price:130, category:'رجالي', notes:['حلو','دم التنين','خشب']),
];
