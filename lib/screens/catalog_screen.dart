import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../providers/cart_provider.dart';
import '../providers/theme_provider.dart';
import 'cart_screen.dart';

const List<Book> books = [
  Book(
    id: 1,
    title: 'Laut Bercerita',
    author: 'Leila S. Chudori',
    price: '95000',
    imageUrl: 'https://covers.openlibrary.org/b/isbn/9786024246945-L.jpg',
  ),
  Book(
    id: 2,
    title: 'Bumi',
    author: 'Tere Liye',
    price: '89000',
    imageUrl: 'https://covers.openlibrary.org/b/isbn/9786020332956-L.jpg',
  ),
  Book(
    id: 3,
    title: 'Atomic Habits',
    author: 'James Clear',
    price: '120000',
    imageUrl: 'https://covers.openlibrary.org/b/isbn/9786020633178-L.jpg',
  ),
  Book(
    id: 4,
    title: 'Filosofi Teras',
    author: 'Henry Manampiring',
    price: '98000',
    imageUrl: 'https://covers.openlibrary.org/b/isbn/9786233463034-L.jpg',
  ),
  Book(
    id: 5,
    title: 'Laskar Pelangi',
    author: 'Andrea Hirata',
    price: '85000',
    imageUrl: 'https://covers.openlibrary.org/b/isbn/9789793062792-L.jpg',
  ),
  Book(
    id: 6,
    title: 'Bumi Manusia',
    author: 'Pramoedya Ananta Toer',
    price: '110000',
    imageUrl: 'https://covers.openlibrary.org/b/isbn/9789799731234-L.jpg',
  ),
  Book(
    id: 7,
    title: 'Negeri 5 Menara',
    author: 'Ahmad Fuadi',
    price: '79000',
    imageUrl: 'https://covers.openlibrary.org/b/isbn/9789792248616-L.jpg',
  ),
  Book(
    id: 8,
    title: 'Perahu Kertas',
    author: 'Dee Lestari',
    price: '92000',
    imageUrl: 'https://covers.openlibrary.org/b/isbn/9786028811790-L.jpg',
  ),
  Book(
    id: 9,
    title: 'Hujan',
    author: 'Tere Liye',
    price: '85000',
    imageUrl: 'https://covers.openlibrary.org/b/isbn/9786020324784-L.jpg',
  ),
  Book(
    id: 10,
    title: 'The Psychology of Money',
    author: 'Morgan Housel',
    price: '105000',
    imageUrl: 'https://covers.openlibrary.org/b/isbn/9786026486579-L.jpg',
  ),
  Book(
    id: 11,
    title: 'Rich Dad Poor Dad',
    author: 'Robert T. Kiyosaki',
    price: '99000',
    imageUrl: 'https://covers.openlibrary.org/b/isbn/9786020333175-L.jpg',
  ),
  Book(
    id: 12,
    title: 'Cantik Itu Luka',
    author: 'Eka Kurniawan',
    price: '115000',
    imageUrl: 'https://covers.openlibrary.org/b/isbn/9786020312583-L.jpg',
  ),
];

String formatRupiah(num value) {
  final digits = value.round().toString();
  final formatted = digits.replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => '.',
  );
  return 'Rp$formatted';
}

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NusaBookstore',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: 'Ganti tema',
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme();
            },
            icon: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            ),
          ),
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: IconButton(
                  tooltip: 'Keranjang',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CartScreen()),
                    );
                  },
                  icon: Badge(
                    label: Text('${cart.totalItems}'),
                    isLabelVisible: cart.totalItems > 0,
                    child: const Icon(Icons.shopping_bag_outlined),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final columns = width >= 900
              ? 4
              : width >= 600
              ? 3
              : 2;

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF293B2E)
                      : const Color(0xFFE4EBDD),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'YOUR NEXT CHAPTER',
                      style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Cerita baru,\nsemangat baru.',
                      style: TextStyle(
                        fontSize: 29,
                        height: 1.15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Temukan buku yang menemani perjalananmu.',
                      style: TextStyle(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.75,
                        ),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.auto_stories_rounded, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          '${books.length} pilihan buku untukmu',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Jelajahi Buku',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 5),
              Text(
                'Pilihan bacaan untuk mengisi harimu.',
                style: TextStyle(color: theme.hintColor),
              ),
              const SizedBox(height: 18),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: books.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  mainAxisExtent: 340,
                ),
                itemBuilder: (context, index) {
                  final book = books[index];

                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: Image.network(
                              book.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    color: theme
                                        .colorScheme
                                        .surfaceContainerHighest,
                                    child: const Center(
                                      child: Icon(
                                        Icons.menu_book_rounded,
                                        size: 54,
                                      ),
                                    ),
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                book.author,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: theme.hintColor,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                formatRupiah(
                                  double.parse(book.price.toString()),
                                ),
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: FilledButton(
                                  onPressed: () {
                                    context.read<CartProvider>().addItem(book);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '${book.title} ditambahkan ke keranjang',
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                  style: FilledButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 10,
                                    ),
                                    textStyle: const TextStyle(fontSize: 12),
                                  ),
                                  child: const Text('Tambah ke Keranjang'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
