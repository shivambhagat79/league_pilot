import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';

class CreateTeamPage extends StatefulWidget {
  const CreateTeamPage({super.key});

  @override
  State<CreateTeamPage> createState() => _CreateTeamPageState();
}

class _CreateTeamPageState extends State<CreateTeamPage> {
  @override
  Widget build(BuildContext context) {
    return Customscrollpage(title: 'Create Team', child: Container());
  }
}
