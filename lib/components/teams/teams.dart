import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/components/teams/team_card.dart';

class Teams extends StatefulWidget {
  const Teams({super.key});

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
      title: "Teams",
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            TeamCard(
              teamName: "IIT Ropar",
              logoUrl: "assets/images/components/iit-ropar.jpg",
              description: "A competitive and passionate team from IIT Ropar.",
            ),
            const SizedBox(height: 10),
            TeamCard(
              teamName: "IIT Kanpur",
              logoUrl: "assets/images/components/iit-kanpur.jpg",
              description:
                  "A well-experienced and skilled team from IIT Kanpur.",
            ),
            const SizedBox(height: 20),
            TeamCard(
              teamName: "Tech Titans",
              description: "An innovative team known for their strategic gameplay and teamwork.",
            ),
            const SizedBox(height: 10),

            TeamCard(
              teamName: "Rising Phoenix",
              description: "A team that never gives up, always bouncing back stronger in every match.",
            ),
            const SizedBox(height: 10),

            TeamCard(
              teamName: "The Mavericks",
              description: "A group of unconventional players who take bold risks and surprise their opponents.",
            ),
            const SizedBox(height: 10),

            TeamCard(
              teamName: "Storm Breakers",
              description: "A high-energy team that dominates with speed and precision.",
            ),
            const SizedBox(height: 10),

            TeamCard(
              teamName: "Shadow Strikers",
              description: "A stealthy and tactical team that outsmarts their competition with intelligent moves.",
            ),
            const SizedBox(height: 10),

            TeamCard(
              teamName: "Velocity Vipers",
              description: "A team known for their aggressive gameplay and lightning-fast responses.",
            ),
            const SizedBox(height: 10),

            TeamCard(
              teamName: "Iron Warriors",
              description: "A resilient team with unmatched endurance and an unbreakable spirit.",
            ),
            const SizedBox(height: 10),

            TeamCard(
              teamName: "Blazing Comets",
              description: "A fiery team with unstoppable energy and a passion for winning.",
            ),
            const SizedBox(height: 10),

            TeamCard(
              teamName: "Quantum Blitz",
              description: "A team that fuses science and strategy to dominate their opponents.",
            ),
            const SizedBox(height: 10),

            TeamCard(
              teamName: "Thunder Hawks",
              description: "A fearless team that soars high and strikes with electrifying force.",
            ),
            const SizedBox(height: 10),

          ],
        ),
      ),
    );
  }
}
