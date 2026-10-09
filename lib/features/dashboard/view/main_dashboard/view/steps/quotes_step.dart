import 'package:flutter/material.dart';
import 'package:mood_journal/core/state/quotes_state.dart';
import 'package:mood_journal/ui/fonts/all_fonts.dart';
import 'package:provider/provider.dart';

class QuotesStep extends StatefulWidget {
  const QuotesStep({super.key});

  @override
  State<QuotesStep> createState() => _QuotesStepState();
}

class _QuotesStepState extends State<QuotesStep> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Слой 1: Фон
        Positioned.fill(
          child: Image.asset(
            'assets/images/image_for_quotes_step.png',
            fit: BoxFit.cover,
          ),
        ),

        // Слой 2: Затемнение
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.4),
          ),
        ),

        // Слой 3: Контент с постраничным скроллом
        Positioned.fill(
          child: SafeArea(
            child: Consumer<QuotesState>(
              builder: (context, state, child) {
                if (!state.isLoaded) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }

                return PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical, // Вертикальный скролл
                  itemCount: state.quotesList.length,
                  itemBuilder: (context, index) {
                    final quote = state.quotesList[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 40,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            quote.textQuotes,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            quote.authorQuotes ?? 'Unknown author',
                            style: quotes_author,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}