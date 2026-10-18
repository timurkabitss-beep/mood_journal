import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mood_journal/core/data/daily_task_helper.dart';
import 'package:mood_journal/core/database/repositories/mood_repository.dart';
import 'package:mood_journal/core/state/global_state.dart';
import 'package:mood_journal/ui/fonts/all_fonts.dart';
import 'package:provider/provider.dart';

class DailyTaskScreen extends StatefulWidget {
  const DailyTaskScreen({super.key});

  @override
  State<DailyTaskScreen> createState() => _DailyTaskScreenState();
}

class _DailyTaskScreenState extends State<DailyTaskScreen> {
  final TextEditingController _controller = TextEditingController();
  late final AppState _appState;

  DateTime? _loadedDate;
  bool _canSave = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _appState = context.read<AppState>();

    _loadAnswer(_appState.selectedTaskDate);
    _canSave = _controller.text.trim().isNotEmpty;

    _controller.addListener(() {
      final canSave = _controller.text.trim().isNotEmpty;
      if (canSave != _canSave && mounted) {
        setState(() => _canSave = canSave);
      }
    });

    // Экран живёт в IndexedStack и создаётся один раз,
    // поэтому следим за сменой выбранной даты сами
    _appState.addListener(_onAppStateChanged);
  }

  @override
  void dispose() {
    _appState.removeListener(_onAppStateChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onAppStateChanged() {
    final date = _appState.selectedTaskDate;
    if (_loadedDate != date) {
      _loadAnswer(date);
    }
  }

  /// Подставляем уже сохранённый ответ за этот день (если он есть)
  void _loadAnswer(DateTime date) {
    _loadedDate = date;
    String? saved;
    try {
      saved = MoodRepository.instance.getDailyAnswer(date);
    } catch (_) {
      saved = null;
    }
    _controller.text = saved ?? '';
  }

  void _close() {
    FocusScope.of(context).unfocus();
    context.read<AppState>().setCurrentIndex(0);
  }

  Future<void> _save() async {
    if (!_canSave || _isSaving) return;

    setState(() => _isSaving = true);
    final date = _appState.selectedTaskDate;

    try {
      await MoodRepository.instance.saveDailyAnswer(
        date: date,
        task: getTaskForDate(date),
        answer: _controller.text.trim(),
      );
      if (!mounted) return;

      FocusScope.of(context).unfocus();
      _appState.setCurrentIndex(0);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Task completed'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Could not save the answer. Please try again.'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final date = appState.selectedTaskDate;
    final themeColors = appState.selectedTheme.colors;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            // Контент: вопрос + поле ответа
            Positioned.fill(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.fromLTRB(24, 210, 24, 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        getTaskForDate(date),
                        key: ValueKey(date.toIso8601String()),
                        style: daily_question,
                      ),
                    ),
                    const SizedBox(height: 28),
                    TextField(
                      controller: _controller,
                      minLines: 6,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                      style: daily_answer, // Тёмный текст
                      cursorColor: Colors.black, // Видимый курсор
                      decoration: InputDecoration(
                        hintText: 'Write your answer...',
                        hintStyle: daily_answer_hint, // Серая подсказка
                        filled: true,
                        fillColor: Colors.grey.shade100, // Лёгкий серый фон поля
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Кнопка сохранения: появляется, когда в поле есть текст
                    Align(
                      alignment: Alignment.centerRight,
                      child: IgnorePointer(
                        ignoring: !_canSave,
                        child: AnimatedScale(
                          scale: _canSave ? 1.0 : 0.6,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutBack,
                          child: AnimatedOpacity(
                            opacity: _canSave ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 250),
                            child: _SaveButton(
                              colors: themeColors,
                              isSaving: _isSaving,
                              onTap: _save,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Заголовок и дата
            Positioned(
              top: 90,
              left: 0,
              right: 0,
              height: 70,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Daily Task', style: daily_screen_title),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('EEEE, MMMM d').format(date).toUpperCase(),
                      style: daily_screen_date,
                    ),
                  ],
                ),
              ),
            ),

            // Кнопка «закрыть» справа сверху
            Positioned(
              top: 90,
              left: 20,
              child: _CloseButton(onTap: _close),
            ),

          ],
        ),
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CloseButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(Icons.close, color: Colors.grey, size: 30),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final List<Color> colors;
  final bool isSaving;
  final VoidCallback onTap;

  const _SaveButton({
    required this.colors,
    required this.isSaving,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: Colors.green,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: isSaving
              ? const SizedBox(
            height: 26,
            width: 26,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
              : const Icon(Icons.check, color: Colors.white, size: 32),
        ),
      ),
    );
  }
}