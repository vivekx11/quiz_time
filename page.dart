import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:html_unescape/html_unescape.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'setting.dart';

class PageScreen extends StatelessWidget {
  const PageScreen({super.key});

  static const Map<String, int> categories = {
    'General Knowledge': 9,
    'Books': 10,
    'Film': 11,
    'Science & Nature': 17,
    'Computers': 18,
    'Mathematics': 19,
    'Sports': 21,
    'Geography': 22,
    'History': 23,
    'Art': 25,
  };

  IconData _categoryIcon(String title) {
    switch (title) {
      case 'Books':
        return Icons.menu_book;
      case 'Film':
        return Icons.movie_filter;
      case 'Science & Nature':
        return Icons.biotech;
      case 'Computers':
        return Icons.computer;
      case 'Mathematics':
        return Icons.calculate;
      case 'Sports':
        return Icons.sports_soccer;
      case 'Geography':
        return Icons.public;
      case 'History':
        return Icons.history_edu;
      case 'Art':
        return Icons.color_lens;
      default:
        return Icons.lightbulb;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryTitles = categories.keys.toList();

    return Scaffold(
      body: Stack(
        children: [
          const RadialBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ... existing code ...
                  const SizedBox(height: 32),
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome Back!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const Text(
                            'Ready to Quiz?',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF1F2937),
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                      IconButton.filledTonal(
                        icon: const Icon(Icons.settings_outlined),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SettingsPage()),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Categories Grid
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: categoryTitles.length > 9 ? 9 : categoryTitles.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.9,
                            ),
                            itemBuilder: (context, index) {
                              String title = categoryTitles[index];
                              return _buildCategoryCard(context, title, categories[title]!);
                            },
                          ),
                          if (categoryTitles.length > 9) ...[
                            const SizedBox(height: 10),
                            Center(
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  // Match the width of a single grid item: (TotalWidth - gaps) / 3
                                  final double itemWidth = (constraints.maxWidth - 20) / 3;
                                  return SizedBox(
                                    width: itemWidth,
                                    child: _buildCategoryCard(
                                      context,
                                      categoryTitles[9],
                                      categories[categoryTitles[9]]!,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, int id) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DifficultyScreen(
              categoryName: title,
              categoryId: id,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _categoryIcon(title),
                size: 24,
                color: const Color(0xFF6366F1),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF374151),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DifficultyScreen extends StatelessWidget {
  final String categoryName;
  final int categoryId;

  const DifficultyScreen({
    super.key,
    required this.categoryName,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const RadialBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Custom header with back button
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Select Difficulty',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choose a section for your quiz',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.9,
                      children: [
                        DifficultyCard(
                          title: 'Easy',
                          icon: Icons.trending_up,
                          color: Colors.green,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => QuizLoader(
                                  categoryName: categoryName,
                                  categoryId: categoryId,
                                  difficulty: 'easy',
                                ),
                              ),
                            );
                          },
                        ),
                        DifficultyCard(
                          title: 'Medium',
                          icon: Icons.trending_neutral,
                          color: Colors.orange,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => QuizLoader(
                                  categoryName: categoryName,
                                  categoryId: categoryId,
                                  difficulty: 'medium',
                                ),
                              ),
                            );
                          },
                        ),
                        DifficultyCard(
                          title: 'Hard',
                          icon: Icons.trending_down,
                          color: Colors.red,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => QuizLoader(
                                  categoryName: categoryName,
                                  categoryId: categoryId,
                                  difficulty: 'hard',
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DifficultyCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const DifficultyCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: PremiumCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RadialBackground extends StatelessWidget {
  const RadialBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFB3E5FC),
            Color(0xFFF48FB1),
          ],
        ),
      ),
    );
  }
}

class PremiumCard extends StatelessWidget {
  final Widget child;
  const PremiumCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}

// QuizLoader and related classes (QuizPage, ScorePage) as per your original code:

class QuizLoader extends StatefulWidget {
  final String categoryName;
  final int categoryId;
  final String difficulty;
  const QuizLoader({
    super.key,
    required this.categoryName,
    required this.categoryId,
    required this.difficulty,
  });
  @override
  State<QuizLoader> createState() => _QuizLoaderState();
}

class _QuizLoaderState extends State<QuizLoader> {
  bool loading = true;
  String error = '';
  List<dynamic> questions = [];

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    final url =
        'https://opentdb.com/api.php?amount=10&category=${widget.categoryId}&difficulty=${widget.difficulty}&type=multiple';
    try {
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);
      if (data['response_code'] == 0) {
        setState(() {
          questions = data['results'];
          loading = false;
        });
      } else {
        throw Exception("No questions found for this difficulty.");
      }
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const RadialBackground(),
          SafeArea(
            child: Column(
              children: [
                // Custom header
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios,
                                color: Colors.black),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              '${widget.categoryName} - ${widget.difficulty.toUpperCase()}',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                letterSpacing: 1.1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Answer the questions below',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: loading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF1E88E5)),
                          )
                        : error.isNotEmpty
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: Colors.red[300],
                                    size: 80,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "Error: $error",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.9),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  ElevatedButton.icon(
                                    onPressed: loadQuestions,
                                    icon: const Icon(Icons.refresh, size: 22),
                                    label: const Text(
                                      "Try Again",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF1E88E5),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : QuizPage(
                                questions: questions,
                                categoryName: widget.categoryName,
                              ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  final List<dynamic> questions;
  final String categoryName;
  const QuizPage(
      {super.key, required this.questions, required this.categoryName});
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final HtmlUnescape unescape = HtmlUnescape();

  int currentQuestion = 0;
  int correctAnswers = 0;
  bool answered = false;
  List<String> currentAnswers = [];

  @override
  void initState() {
    super.initState();
    _prepareQuestion();
  }

  void _prepareQuestion() {
    var q = widget.questions[currentQuestion];
    currentAnswers = List<String>.from(q['incorrect_answers']);
    currentAnswers.add(q['correct_answer']);
    currentAnswers.shuffle();
  }

  void checkAnswer(String selectedAnswer) {
    if (answered) return;
    setState(() {
      answered = true;
      if (selectedAnswer ==
          widget.questions[currentQuestion]['correct_answer']) {
        correctAnswers++;
        showSnack("Correct! ✅", Colors.green[600]!);
      } else {
        showSnack("Incorrect! ❌", Colors.red[600]!);
      }
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      setState(() {
        if (currentQuestion + 1 < widget.questions.length) {
          currentQuestion++;
          answered = false;
          _prepareQuestion();
        } else {
          saveScoreToHive(
              widget.categoryName, correctAnswers, widget.questions.length);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => ScorePage(
                score: correctAnswers,
                total: widget.questions.length,
              ),
            ),
          );
        }
      });
    });
  }

  void showSnack(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: color,
        duration: const Duration(milliseconds: 1000),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
      ),
    );
  }

  Future<void> saveScoreToHive(String category, int score, int total) async {
    var box = await Hive.openBox('quiz_scores');
    List<dynamic> scores = box.get('scores', defaultValue: []);
    scores.add({
      'category': category,
      'score': score,
      'total': total,
      'date': DateTime.now().toIso8601String(),
    });
    await box.put('scores', scores);
  }

  @override
  Widget build(BuildContext context) {
    var q = widget.questions[currentQuestion];
    double progress = (currentQuestion + 1) / widget.questions.length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          // Progress section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Question ${currentQuestion + 1} of ${widget.questions.length}",
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Score: $correctAnswers",
                style: const TextStyle(
                  color: Color(0xFF6366F1),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade200,
              color: const Color(0xFF6366F1),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 32),
          // Question Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Text(
              unescape.convert(q['question']),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF1F2937),
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 32),
          // Answers List
          Expanded(
            child: ListView.separated(
              itemCount: currentAnswers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                String ans = currentAnswers[index];
                bool isCorrect = ans == q['correct_answer'];
                Color borderColor = Colors.grey.shade200;
                Color bgColor = Colors.white;
                Color textColor = const Color(0xFF374151);

                if (answered) {
                  if (isCorrect) {
                    borderColor = Colors.green.shade400;
                    bgColor = Colors.green.shade50;
                    textColor = Colors.green.shade700;
                  } else {
                    borderColor = Colors.red.shade100;
                    bgColor = Colors.white;
                    textColor = Colors.grey.shade400;
                  }
                }

                return AnimatedCard(
                  child: GestureDetector(
                    onTap: answered ? null : () => checkAnswer(ans),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 24),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: borderColor, width: 2),
                        boxShadow: [
                          if (!answered)
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              unescape.convert(ans),
                              style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (answered && isCorrect)
                            const Icon(Icons.check_circle, color: Colors.green),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ScorePage extends StatelessWidget {
  final int score;
  final int total;
  const ScorePage({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    double percentage = (score / total) * 100;
    String message = "Great Job!";
    IconData icon = Icons.emoji_events_rounded;
    Color iconColor = const Color(0xFFFFB800);

    if (percentage < 50) {
      message = "Keep Practicing!";
      icon = Icons.psychology_rounded;
      iconColor = const Color(0xFF6366F1);
    } else if (percentage == 100) {
      message = "Perfect Score!";
      icon = Icons.auto_awesome_rounded;
      iconColor = const Color(0xFFFFB800);
    }

    return Scaffold(
      body: Stack(
        children: [
          const RadialBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: iconColor.withOpacity(0.2),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Icon(
                        icon,
                        size: 80,
                        color: iconColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "You scored $score out of $total questions",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 48),
                  PremiumCard(
                    child: Column(
                      children: [
                        Text(
                          "${percentage.toInt()}%",
                          style: const TextStyle(
                            fontSize: 52,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF6366F1),
                          ),
                        ),
                        const Text(
                          "Accuracy",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.popUntil(context, (route) => route.isFirst),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 4,
                    ),
                    child: const Text(
                      "Back to Home",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// PremiumCard is now used above

class AnimatedCard extends StatelessWidget {
  final Widget child;
  const AnimatedCard({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400),
      tween: Tween<double>(begin: 0.95, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, double value, _) {
        return Transform.scale(
            scale: value,
            child: Material(color: Colors.transparent, child: child));
      },
    );
  }
}
