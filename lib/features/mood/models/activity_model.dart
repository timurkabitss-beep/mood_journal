import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

enum ActivityModel {

  relationship(LucideIcons.heart, 'Relationship'),
  friends(LucideIcons.users, 'Friends'),
  travel(LucideIcons.plane, 'Travel'),
  food(LucideIcons.utensils, 'Food'),
  sport(LucideIcons.dumbbell, 'Sport'),
  health(LucideIcons.heartPulse, 'Health'),
  family(LucideIcons.home, 'Family'),
  work(LucideIcons.briefcase, 'Work'),
  school(LucideIcons.graduationCap, 'School');

  final IconData icon;
  final String label;

  const ActivityModel(this.icon, this.label);
}
