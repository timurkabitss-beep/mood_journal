import 'package:flutter/material.dart';
import 'package:mood_journal/core/state/global_state.dart';
import 'package:mood_journal/features/dashboard/view/main_dashboard/view/models/quotes_text_model.dart';
import 'package:provider/provider.dart';

class QuotesStep extends StatefulWidget {
  const QuotesStep({super.key});

  @override
  State<QuotesStep> createState() => _QuotesStepState();
}

class _QuotesStepState extends State<QuotesStep> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Image.asset("assets/images/image_for_quotes_step.png", fit: BoxFit.cover,)
        ),
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.3),
          )
        ),
        Positioned.fill(
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()
            ),
            padding: EdgeInsets.only(
              top: 400 ,
              left: 20,
              right: 20,
            ),
          ),
        )
      ],
    );
  }


}
