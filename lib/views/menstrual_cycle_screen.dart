import 'package:flutter/material.dart';
import 'package:pcos_care/views/home_screen.dart';

class MenstrualCycleSlider extends StatelessWidget {
  final int initialPage;

  MenstrualCycleSlider({this.initialPage = 0, required int phaseIndex});

  final List<Widget> phases = [
    MenstrualPhase(),
    FollicularPhase(),
    OvulationPhase(),
    LutealPhase(),
  ];

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController(initialPage: initialPage);

    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: phases,
      ),
    );
  }
}


class MenstrualPhase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PhaseTemplate(
      phaseName: 'Menstrual Phase',
      description: 'This phase marks the start of your cycle, where the uterine lining sheds and exits the body as menstrual blood.',
      symptoms: 'You may experience cramps, fatigue, mood swings, and lower back pain.',
      fertilizationChance: 'Low',
      fertilizationDescription: 'Very low; your body is shedding the unfertilized egg.',
      imagePath: 'assets/menstrual_cycle/Mens.png',
      phaseStatus: 'Current phase',
    );
  }
}

class FollicularPhase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PhaseTemplate(
      phaseName: 'Follicular Phase',
      description: 'During this phase, your body prepares for ovulation. Follicles in the ovaries mature with one egg becoming dominant.',
      symptoms: 'You might feel energized, with clearer skin and a more positive mood.',
      fertilizationChance: 'Medium',
      fertilizationDescription: 'Increasing; your body is preparing to release an egg.',
      imagePath: 'assets/menstrual_cycle/Folli.png',
      phaseStatus: 'Future phase',
    );
  }
}

class OvulationPhase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PhaseTemplate(
      phaseName: 'Ovulation Phase',
      description: 'Ovulation is when the mature egg is released from the ovary and is ready to be fertilized.',
      symptoms: 'You may notice a slight rise in body temperature, increased cervical mucus, and heightened libido.',
      fertilizationChance: 'High',
      fertilizationDescription: 'Highest; this is the most fertile time of your cycle.',
      imagePath: 'assets/menstrual_cycle/Ovul.png',
      phaseStatus: 'Future phase',
    );
  }
}

class LutealPhase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PhaseTemplate(
      phaseName: 'Luteal Phase',
      description: "After ovulation, the body prepares for a potential pregnancy. If the egg isn't fertilized, the body will prepare to start the cycle again.",
      symptoms: 'You may experience bloating, breast tenderness, mood swings, and cravings known as PMS (premenstrual syndrome).',
      fertilizationChance: 'Low',
      fertilizationDescription: 'Low; the fertile window has passed.',
      imagePath: 'assets/menstrual_cycle/Luteal.png',
      phaseStatus: 'Future phase',
    );
  }
}

class PhaseTemplate extends StatelessWidget {
  final String phaseName;
  final String phaseStatus;
  final String description;
  final String symptoms;
  final String fertilizationChance;
  final String fertilizationDescription;
  final String imagePath;

  PhaseTemplate({
    required this.phaseName,
    required this.phaseStatus,
    required this.description,
    required this.symptoms,
    required this.fertilizationChance,
    required this.fertilizationDescription,
    required this.imagePath,
  });

  get userData => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFFFFFFF),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 25),

            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen(
                      userData: userData,
                      symptoms: userData.symptoms,
                      recommendations: [],
                    ),),
                  );
                },
              ),
            ),
            Image.asset(imagePath, height: 200),
            SizedBox(height: 20),
            Text(
              phaseName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              phaseStatus,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16),
            PhaseInfoCard(
              title: 'What Happens:',
              content: description,
            ),
            SizedBox(height: 12),
            // Symptoms Card
            PhaseInfoCard(
              title: 'Symptoms:',
              content: symptoms,
            ),
            SizedBox(height: 12),
            // Fertilization Chances Card
            PhaseInfoCard(
              title: 'Fertilization Chances: $fertilizationChance',
              content: fertilizationDescription,
              titleColor: fertilizationChance == 'High'
                  ? Colors.red
                  : fertilizationChance == 'Medium'
                  ? Colors.orange
                  : Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}


class PhaseInfoCard extends StatelessWidget {
  final String title;
  final String content;
  final Color? titleColor;

  PhaseInfoCard({
    required this.title,
    required this.content,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: titleColor ?? Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
