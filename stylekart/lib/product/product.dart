
import '../model/productmodel.dart';
final List<Product> allProducts = [
  // Men's Collection
  Product(
      id: 'm1',
      name: 'Men\'s Casual Shirt',
      price: 1800.00,
      imageUrl: 'https://unze.com.pk/cdn/shop/products/MC1611-2.jpg?v=1688638148',
      category: 'Men'),
  Product(
      id: 'm2',
      name: 'Stylish Denim Jeans',
      price: 2500.00,
      imageUrl: 'https://unze.com.pk/cdn/shop/files/kc480.jpg?v=1747824863',
      category: 'Men'),
  Product(
      id: 'm3',
      name: 'Formal Blazer',
      price: 5500.00,
      imageUrl: 'https://unze.com.pk/cdn/shop/files/wc465a_460x.jpg?v=1752727581',
      category: 'Men'),
  Product(
      id: 'm4',
      name: 'Sporty Tracksuit',
      price: 3200.00,
      imageUrl: 'https://unze.com.pk/cdn/shop/files/mc2035a_460x.jpg?v=1731262410',
      category: 'Men'),
  Product(
      id: 'm5',
      name: 'Classic Polo T-Shirt',
      price: 1500.00,
      imageUrl: 'https://unze.com.pk/cdn/shop/files/mc2342.jpg?v=1752726004',
      category: 'Men'),
  Product(
      id: 'm6',
      name: 'Leather Jacket',
      price: 7000.00,
      imageUrl: 'https://placehold.co/300x400/33A1FF/FFFFFF?text=Leather+Jacket',
      category: 'Men'),
  Product(
      id: 'm7',
      name: 'Comfortable Shorts',
      price: 1200.00,
      imageUrl: 'https://placehold.co/300x400/FF3333/FFFFFF?text=Shorts',
      category: 'Men'),
  Product(
      id: 'm8',
      name: 'Ethnic Kurta',
      price: 2800.00,
      imageUrl: 'https://placehold.co/300x400/33FF33/FFFFFF?text=Kurta',
      category: 'Men'),
  Product(
      id: 'm9',
      name: 'Workout Vest',
      price: 900.00,
      imageUrl: 'https://placehold.co/300x400/3333FF/FFFFFF?text=Workout+Vest',
      category: 'Men'),
  Product(
      id: 'm10',
      name: 'Formal Trousers',
      price: 2000.00,
      imageUrl: 'https://placehold.co/300x400/FF33C1/FFFFFF?text=Trousers',
      category: 'Men'),

  // Women's Collection
  Product(
      id: 'w1',
      name: 'Elegant Maxi Dress',
      price: 4500.00,
      imageUrl: 'https://placehold.co/300x400/C133FF/FFFFFF?text=Maxi+Dress',
      category: 'Women'),
  Product(
      id: 'w2',
      name: 'Chic Blouse',
      price: 1700.00,
      imageUrl: 'https://placehold.co/300x400/FFC133/FFFFFF?text=Blouse',
      category: 'Women'),
  Product(
      id: 'w3',
      name: 'High-Waist Skirt',
      price: 2100.00,
      imageUrl: 'https://placehold.co/300x400/33FFC1/FFFFFF?text=Skirt',
      category: 'Women'),
  Product(
      id: 'w4',
      name: 'Traditional Shalwar Kameez',
      price: 3800.00,
      imageUrl: 'https://placehold.co/300x400/C1FF33/FFFFFF?text=Shalwar+Kameez',
      category: 'Women'),
  Product(
      id: 'w5',
      name: 'Comfortable Leggings',
      price: 1000.00,
      imageUrl: 'https://placehold.co/300x400/33C1FF/FFFFFF?text=Leggings',
      category: 'Women'),
  Product(
      id: 'w6',
      name: 'Party Wear Gown',
      price: 8000.00,
      imageUrl: 'https://placehold.co/300x400/FF3333/FFFFFF?text=Party+Gown',
      category: 'Women'),
  Product(
      id: 'w7',
      name: 'Casual Jumpsuit',
      price: 3000.00,
      imageUrl: 'https://placehold.co/300x400/33FF33/FFFFFF?text=Jumpsuit',
      category: 'Women'),
  Product(
      id: 'w8',
      name: 'Knitted Cardigan',
      price: 2300.00,
      imageUrl: 'https://placehold.co/300x400/3333FF/FFFFFF?text=Cardigan',
      category: 'Women'),
  Product(
      id: 'w9',
      name: 'Summer Top',
      price: 1400.00,
      imageUrl: 'https://placehold.co/300x400/FF33C1/FFFFFF?text=Summer+Top',
      category: 'Women'),
  Product(
      id: 'w10',
      name: 'Office Wear Pants',
      price: 2600.00,
      imageUrl: 'https://placehold.co/300x400/C133FF/FFFFFF?text=Office+Pants',
      category: 'Women'),

  // Kids' Collection
  Product(
      id: 'k1',
      name: 'Kids\' Cartoon T-Shirt',
      price: 800.00,
      imageUrl: 'https://placehold.co/300x400/FF5733/FFFFFF?text=Kids+Tee',
      category: 'Kids'),
  Product(
      id: 'k2',
      name: 'Cute Denim Overalls',
      price: 1500.00,
      imageUrl: 'https://placehold.co/300x400/33FF57/FFFFFF?text=Kids+Overalls',
      category: 'Kids'),
  Product(
      id: 'k3',
      name: 'Girls\' Princess Dress',
      price: 2200.00,
      imageUrl: 'https://placehold.co/300x400/3357FF/FFFFFF?text=Princess+Dress',
      category: 'Kids'),
  Product(
      id: 'k4',
      name: 'Boys\' Superhero Costume',
      price: 1900.00,
      imageUrl: 'https://placehold.co/300x400/FF33A1/FFFFFF?text=Superhero+Costume',
      category: 'Kids'),
  Product(
      id: 'k5',
      name: 'Comfortable Pajamas',
      price: 1000.00,
      imageUrl: 'https://placehold.co/300x400/A1FF33/FFFFFF?text=Pajamas',
      category: 'Kids'),
  Product(
      id: 'k6',
      name: 'Warm Kids Jacket',
      price: 1800.00,
      imageUrl: 'https://placehold.co/300x400/33A1FF/FFFFFF?text=Kids+Jacket',
      category: 'Kids'),
  Product(
      id: 'k7',
      name: 'Toddler Romper',
      price: 950.00,
      imageUrl: 'https://placehold.co/300x400/FF3333/FFFFFF?text=Romper',
      category: 'Kids'),
  Product(
      id: 'k8',
      name: 'Kids Fancy Shirt',
      price: 1300.00,
      imageUrl: 'https://placehold.co/300x400/33FF33/FFFFFF?text=Kids+Fancy+Shirt',
      category: 'Kids'),
  Product(
      id: 'k9',
      name: 'Girls Skirt Set',
      price: 1600.00,
      imageUrl: 'https://placehold.co/300x400/3333FF/FFFFFF?text=Girls+Skirt+Set',
      category: 'Kids'),
  Product(
      id: 'k10',
      name: 'Boys Cargo Pants',
      price: 1400.00,
      imageUrl: 'https://placehold.co/300x400/FF33C1/FFFFFF?text=Boys+Cargo+Pants',
      category: 'Kids'),

  // Shoes Collection
  Product(
      id: 's1',
      name: 'Men\'s Running Shoes',
      price: 4000.00,
      imageUrl: 'https://placehold.co/300x400/5733FF/FFFFFF?text=Running+Shoes',
      category: 'Shoes'),
  Product(
      id: 's2',
      name: 'Women\'s Heels',
      price: 3500.00,
      imageUrl: 'https://placehold.co/300x400/33FF57/FFFFFF?text=Women+Heels',
      category: 'Shoes'),
  Product(
      id: 's3',
      name: 'Kids\' Sneakers',
      price: 2000.00,
      imageUrl: 'https://placehold.co/300x400/FF5733/FFFFFF?text=Kids+Sneakers',
      category: 'Shoes'),
  Product(
      id: 's4',
      name: 'Casual Loafers',
      price: 2800.00,
      imageUrl: 'https://placehold.co/300x400/3357FF/FFFFFF?text=Loafers',
      category: 'Shoes'),
  Product(
      id: 's5',
      name: 'Formal Dress Shoes',
      price: 5000.00,
      imageUrl: 'https://placehold.co/300x400/FF33A1/FFFFFF?text=Dress+Shoes',
      category: 'Shoes'),
  Product(
      id: 's6',
      name: 'Sport Sandals',
      price: 1800.00,
      imageUrl: 'https://placehold.co/300x400/A1FF33/FFFFFF?text=Sport+Sandals',
      category: 'Shoes'),
  Product(
      id: 's7',
      name: 'Athletic Trainers',
      price: 4200.00,
      imageUrl: 'https://placehold.co/300x400/33A1FF/FFFFFF?text=Trainers',
      category: 'Shoes'),
  Product(
      id: 's8',
      name: 'Winter Boots',
      price: 6000.00,
      imageUrl: 'https://placehold.co/300x400/FF3333/FFFFFF?text=Winter+Boots',
      category: 'Shoes'),
  Product(
      id: 's9',
      name: 'Comfortable Slippers',
      price: 1000.00,
      imageUrl: 'https://placehold.co/300x400/33FF33/FFFFFF?text=Slippers',
      category: 'Shoes'),
  Product(
      id: 's10',
      name: 'Stylish Espadrilles',
      price: 2500.00,
      imageUrl: 'https://placehold.co/300x400/3333FF/FFFFFF?text=Espadrilles',
      category: 'Shoes'),

  // Accessories Collection
  Product(
      id: 'a1',
      name: 'Leather Wallet',
      price: 1500.00,
      imageUrl: 'https://placehold.co/300x400/FFC133/FFFFFF?text=Wallet',
      category: 'Accessories'),
  Product(
      id: 'a2',
      name: 'Designer Handbag',
      price: 6000.00,
      imageUrl: 'https://placehold.co/300x400/C133FF/FFFFFF?text=Handbag',
      category: 'Accessories'),
  Product(
      id: 'a3',
      name: 'Fashion Sunglasses',
      price: 1200.00,
      imageUrl: 'https://placehold.co/300x400/33FFC1/FFFFFF?text=Sunglasses',
      category: 'Accessories'),
  Product(
      id: 'a4',
      name: 'Smartwatch',
      price: 10000.00,
      imageUrl: 'https://placehold.co/300x400/C1FF33/FFFFFF?text=Smartwatch',
      category: 'Accessories'),
  Product(
      id: 'a5',
      name: 'Elegant Scarf',
      price: 800.00,
      imageUrl: 'https://placehold.co/300x400/33C1FF/FFFFFF?text=Scarf',
      category: 'Accessories'),
  Product(
      id: 'a6',
      name: 'Necklace Set',
      price: 2500.00,
      imageUrl: 'https://placehold.co/300x400/FF3333/FFFFFF?text=Necklace',
      category: 'Accessories'),
  Product(
      id: 'a7',
      name: 'Baseball Cap',
      price: 700.00,
      imageUrl: 'https://placehold.co/300x400/33FF33/FFFFFF?text=Cap',
      category: 'Accessories'),
  Product(
      id: 'a8',
      name: 'Wrist Watch',
      price: 3000.00,
      imageUrl: 'https://placehold.co/300x400/3333FF/FFFFFF?text=Watch',
      category: 'Accessories'),
  Product(
      id: 'a9',
      name: 'Stylish Belt',
      price: 900.00,
      imageUrl: 'https://placehold.co/300x400/FF33C1/FFFFFF?text=Belt',
      category: 'Accessories'),
  Product(
      id: 'a10',
      name: 'Hair Accessories Pack',
      price: 500.00,
      imageUrl: 'https://placehold.co/300x400/C133FF/FFFFFF?text=Hair+Accessories',
      category: 'Accessories'),

  // Winter Collection
  Product(
      id: 'wint1',
      name: 'Warm Wool Sweater',
      price: 3500.00,
      imageUrl: 'https://placehold.co/300x400/FF5733/FFFFFF?text=Wool+Sweater',
      category: 'Winter Collection'),
  Product(
      id: 'wint2',
      name: 'Padded Winter Jacket',
      price: 6000.00,
      imageUrl: 'https://placehold.co/300x400/33FF57/FFFFFF?text=Winter+Jacket',
      category: 'Winter Collection'),
  Product(
      id: 'wint3',
      name: 'Thermal Innerwear Set',
      price: 2000.00,
      imageUrl: 'https://placehold.co/300x400/3357FF/FFFFFF?text=Thermal+Set',
      category: 'Winter Collection'),
  Product(
      id: 'wint4',
      name: 'Knitted Beanie',
      price: 700.00,
      imageUrl: 'https://placehold.co/300x400/FF33A1/FFFFFF?text=Beanie',
      category: 'Winter Collection'),
  Product(
      id: 'wint5',
      name: 'Gloves',
      price: 500.00,
      imageUrl: 'https://placehold.co/300x400/A1FF33/FFFFFF?text=Gloves',
      category: 'Winter Collection'),
  Product(
      id: 'wint6',
      name: 'Fleece Hoodie',
      price: 2800.00,
      imageUrl: 'https://placehold.co/300x400/33A1FF/FFFFFF?text=Fleece+Hoodie',
      category: 'Winter Collection'),
  Product(
      id: 'wint7',
      name: 'Long Winter Coat',
      price: 9000.00,
      imageUrl: 'https://placehold.co/300x400/FF3333/FFFFFF?text=Winter+Coat',
      category: 'Winter Collection'),
  Product(
      id: 'wint8',
      name: 'Sweater Dress',
      price: 4000.00,
      imageUrl: 'https://placehold.co/300x400/33FF33/FFFFFF?text=Sweater+Dress',
      category: 'Winter Collection'),
  Product(
      id: 'wint9',
      name: 'Warm Socks Pack',
      price: 600.00,
      imageUrl: 'https://placehold.co/300x400/3333FF/FFFFFF?text=Warm+Socks',
      category: 'Winter Collection'),
  Product(
      id: 'wint10',
      name: 'Quilted Vest',
      price: 3200.00,
      imageUrl: 'https://placehold.co/300x400/FF33C1/FFFFFF?text=Quilted+Vest',
      category: 'Winter Collection'),
];