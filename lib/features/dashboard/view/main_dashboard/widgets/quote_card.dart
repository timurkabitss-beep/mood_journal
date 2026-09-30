import 'package:flutter/material.dart';
import 'package:mood_journal/core/database/repositories/quotes_repository.dart';
import 'package:mood_journal/core/state/quotes_state.dart';
import 'package:mood_journal/features/dashboard/view/main_dashboard/view/models/quotes_text_model.dart';
import 'package:provider/provider.dart';
import '../../../../../core/state/global_state.dart';

class QuoteCard extends StatelessWidget {
  final DateTime selectedDate;
  const QuoteCard({super.key, required this.selectedDate});

  QuotesTextModel _getQuoteForDate(DateTime date){
    final daysSinceEpoch = date.millisecondsSinceEpoch ~/ (1000 * 60 * 60 * 24);
    final quotesList = QuotesRepository.instance.getAllQuotes();



    final quoteIndex = daysSinceEpoch % quotesList.length;
    return quotesList[quoteIndex];
  }

  bool _isFutureDate(DateTime date){
    final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final target = DateTime(date.year, date.month, date.day);
    return target.isAfter(today);
  }

  @override
  Widget build(BuildContext context) {
    final currentQuote = _getQuoteForDate(selectedDate);
    final isFuture = _isFutureDate(selectedDate);

    return AnimatedOpacity(
        opacity: isFuture ? 0.7 : 1.0,
        duration: const Duration(milliseconds: 500),
        child: GestureDetector(
         onTap: isFuture ? null : (){
           context.read<AppState>().setCurrentIndex(1);
         },
         child: Container(
          height: 180,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFE6D2A0), Color(0xFFC29B60)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                 top: 16,
                  left: 16,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isFuture ?  '' : 'Quote of the day',
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF5E4D38),
                        )
                      )
                    ],
                  )
              ),

              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      final offsetAnimation = Tween<Offset>(
                        begin: const Offset(0, 0.2),
                        end: Offset.zero,
                      ).animate(animation);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                    child:   Stack(
                     key: ValueKey(selectedDate.toIso8601String()),
                     children: [
                  // Текст цитаты по центру (с небольшим отступом снизу, чтобы не наезжать на автора)
                     Center(
                     child:  Text(
                        isFuture
                            ? 'The quote has not been selected yet\n please come back later'
                            : currentQuote.textQuotes,
                        style: TextStyle(
                          color: const Color(0xFF5E4D38),
                          fontSize: isFuture ? 16 : 16,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        ),
                      ),


                  // Автор внизу справа
                     if (!isFuture)
                       Positioned(
                        bottom: 16,
                        right: 24,
                        child: Text(
                          '— ${currentQuote.authorQuotes ?? 'Неизвестный автор'}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF5E4D38),
                          fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              )
             )
            )
            ],
          ),
        )
      )
    );
  }
}
