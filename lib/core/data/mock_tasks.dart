// Мок-данные для ежедневных заданий
// Вариант А: простой список строк, случайное задание при каждом открытии

const List<String> dailyTasks = [
  // Рефлексия и самопознание
  "What is one thing you're avoiding today, and what would happen if you just admitted it?",
  "If you could talk to your younger self, what would you say?",
  "What emotion are you feeling right now, and where do you feel it in your body?",
  "What's a belief you hold that you've never questioned?",
  "When do you feel most like yourself?",

  // Благодарность
  "What are three small things that made you smile today?",
  "Who is someone you're grateful for, and why?",
  "What's something you take for granted that others would love to have?",
  "What's a challenge you faced that made you stronger?",
  "What's something beautiful you noticed today?",

  // Рост и развитие
  "What's one thing you want to learn or improve this week?",
  "What would you do if you knew you couldn't fail?",
  "What's a habit you want to build, and what's the smallest step you can take today?",
  "What's something you've been putting off, and why?",
  "What does success look like to you?",

  // Отношения и связь
  "Who made a positive impact on your life recently, and have you told them?",
  "What's something kind you can do for someone today?",
  "What's a conversation you've been avoiding, and what's holding you back?",
  "How do you show love to the people around you?",
  "What's something you appreciate about a friend or family member?",

  // Эмоции и осознанность
  "What's weighing on your mind right now?",
  "What brings you peace when you're stressed?",
  "What's something that made you laugh recently?",
  "How are you really feeling today, beyond 'fine'?",
  "What's something you need to let go of?",

  // Цели и мечты
  "What's a dream you've never told anyone about?",
  "What would your ideal day look like?",
  "What's one thing you can do today to move closer to your goals?",
  "What does happiness mean to you?",
  "If you had unlimited time and money, what would you do?",
];

// Функция для получения случайного задания
String getRandomTask() {
  return dailyTasks[DateTime.now().millisecondsSinceEpoch % dailyTasks.length];
}