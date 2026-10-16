import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//hello_screen textStyles
final style = TextStyle(
    color: Colors.white,
    fontSize: 40,
    fontFamily: GoogleFonts.comfortaa().fontFamily,
    fontWeight: FontWeight.w700
);
final style1 = TextStyle(
    color: Colors.white54,
    fontSize: 20,
    fontFamily: GoogleFonts.comfortaa().fontFamily,
    fontWeight: FontWeight.w600
);

final style2 = TextStyle(
    fontSize: 14,
    fontFamily: GoogleFonts.comfortaa().fontFamily,
    fontWeight: FontWeight.w800
);

final style2_1 = TextStyle(
    color: Colors.white54,
    fontSize: 14,
    fontFamily: GoogleFonts.comfortaa().fontFamily,
    fontWeight: FontWeight.w800
);

//name_screens textStyles
//backgr_screen textStyles
final style3 = TextStyle(
    color: Colors.white,
    fontSize: 26,
    fontFamily: GoogleFonts.comfortaa().fontFamily,
    fontWeight: FontWeight.w700
);
final style4 = TextStyle(
    color: Colors.white54,
    fontSize: 22,
    fontFamily: GoogleFonts.comfortaa().fontFamily,
    fontWeight: FontWeight.w700
);

final style5 =TextStyle(
    fontSize: 14,
    fontFamily: GoogleFonts.comfortaa().fontFamily,
    fontWeight: FontWeight.w800
);


//Styles for MAIN_DASHBOARD_SCREEN
final style_full_date = TextStyle(
    color: Colors.white,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    fontFamily: GoogleFonts.comfortaa().fontFamily,
);

final style_day_date = TextStyle(
  color: Colors.white.withOpacity(0.8),
  fontSize: 14,
  fontWeight: FontWeight.bold,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
);  //and use in Challenge_card

final week_calebdar_day_label = TextStyle(
  color: Colors.white70,
  fontSize: 12,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
  fontWeight: FontWeight.bold
);

final week_calebdar_num_label = TextStyle(
  color: Colors.white,
  fontSize: 18,
  fontWeight: FontWeight.bold,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
);

final challenge_card_label = TextStyle(
  color: Colors.white,
  fontSize: 24,
  fontWeight: FontWeight.bold,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
);

final daily_task_access = TextStyle(
    color: Colors.grey.shade600,
    fontSize: 12,
    fontWeight: FontWeight.bold,
    fontFamily: GoogleFonts.comfortaa().fontFamily,
); //and use for Container Open&Locked


final daily_task_text = TextStyle(
  color: Colors.black87,
  fontSize: 16,
  fontWeight: FontWeight.bold,
  height: 1.4,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
); //AND use in first and second dashboards!!!

final first_and_second_dashboards_FTxt =TextStyle(
  color: Color(0xFF2E3E5C),
  fontSize: 18,
  fontWeight: FontWeight.bold,
  height: 1.3,
);

final quote_card_text = TextStyle(
  color: const Color(0xFF5E4D38),
  fontSize:  16,
  fontWeight: FontWeight.bold,
  height: 1.4,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
);

final quote_card_author = TextStyle(
  fontSize: 15,
  fontStyle: FontStyle.italic,
  color: Color(0xFF5E4D38),
  fontWeight: FontWeight.bold,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
);

final status_quote = TextStyle(
  fontSize: 14,
  color: Color(0xFF5E4D38),
  fontFamily: GoogleFonts.comfortaa().fontFamily,
);

//quotes step
final quotes =TextStyle(
  color: Colors.white,
  fontSize: 22,
  fontWeight: FontWeight.bold,
  height: 1.4,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
);

final quotes_author = TextStyle(
  color: Colors.white70,
  fontSize: 16,
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.bold,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
);



//Styles for SETTINGS SCREEN
final style_for_cards_name =TextStyle(fontSize: 18, color: Colors.grey.shade600);

final settings_widgets_style = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.bold,);

final style_cursor = TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold);


//Styles for JOURNAL SCREEN (+ mood_entry_widget)
const journal_text_color = Color(0xFF3E4A63);
const journal_muted_color = Color(0xFFA9B4C6);

final journal_title = TextStyle(
  color: Colors.grey.shade400,
  fontSize: 40,
  fontWeight: FontWeight.w700,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
);

final journal_empty_text = TextStyle(
  color: Colors.grey.shade400,
  fontSize: 16,
  fontWeight: FontWeight.w600,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
);

final journal_date_day = TextStyle(
  color: journal_text_color,
  fontSize: 24,
  fontWeight: FontWeight.w800,
  height: 1.1,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
);

final journal_date_month = TextStyle(
  color: journal_muted_color,
  fontSize: 12,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.5,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
);

final journal_weekday = TextStyle(
  color: journal_text_color,
  fontSize: 24,
  fontWeight: FontWeight.w700,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
);

final journal_days_ago = TextStyle(
  color: journal_muted_color,
  fontSize: 13,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.3,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
);

final journal_mood_title = TextStyle(
  color: journal_text_color,
  fontSize: 19,
  fontWeight: FontWeight.w700,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
);

final journal_time = TextStyle(
  color: journal_muted_color,
  fontSize: 13,
  fontWeight: FontWeight.w600,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
);

final journal_tag = TextStyle(
  color: journal_muted_color,
  fontSize: 13,
  fontWeight: FontWeight.w600,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
);