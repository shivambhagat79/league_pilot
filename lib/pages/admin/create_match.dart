import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/services/match_service.dart';
import 'package:hunger_games/services/tournament_service.dart';

class CreateMatchPage extends StatefulWidget {
  final String tournamentId;
  const CreateMatchPage({super.key, required this.tournamentId});

  @override
  State<CreateMatchPage> createState() => _CreateMatchPageState();
}

class _CreateMatchPageState extends State<CreateMatchPage> {
  final TournamentService _tournamentService = TournamentService();
  final MatchService _matchService = MatchService();
  final _formKey = GlobalKey<FormState>();
  List<String> _sports = [];
  List<String> _contingents = [];
  final List<String> _genders = ["Men", "Women", "Mixed"];

  String? _selectedSport;
  String? _selectedGender;
  DateTime? _date;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String? _selectedContingent1;
  String? _selectedContingent2;
  final _venueController = TextEditingController();
  final _winController = TextEditingController();
  final _lossController = TextEditingController();
  final _drawController = TextEditingController();
  final _scorekeeperController = TextEditingController();
  bool _isLoading = false;

  Future<void> setDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        _date = date;
      });
    }
  }

  Future<TimeOfDay?> setTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      return time;
    }
    return null;
  }

  Future<void> _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      if (_date == null || _startTime == null || _endTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select date and time for the match'),
          ),
        );
        return;
      }

      if (_startTime!.isAfter(_endTime!)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Start time cannot be after end time'),
          ),
        );
        return;
      }

      if (_selectedContingent1 == _selectedContingent2) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Contingents cannot be same'),
          ),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      String? matchId = await _matchService.createMatch(
        sport: _selectedSport ?? "",
        tournament: widget.tournamentId,
        gender: _selectedGender ?? "Men",
        winPoints1: _winController.text,
        losePoints1: _lossController.text,
        drawPoints1: _drawController.text,
        venue: _venueController.text,
        team1: _selectedContingent1 ?? "",
        team2: _selectedContingent2 ?? "",
        date: _date ?? DateTime.now(),
        startTime: _startTime ?? TimeOfDay.now(),
        endTime: _endTime ?? TimeOfDay.now(),
      );

      if (matchId != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Match created successfully"),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to create Match"),
          ),
        );
      }
      Navigator.of(context).pop();

      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    final sports = await _tournamentService.getSports(widget.tournamentId);
    final contingents =
        await _tournamentService.getContingents(widget.tournamentId);

    setState(() {
      _sports = sports;
      _contingents = contingents;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
      title: 'New Match',
      child: Form(
        key: _formKey,
        child: _isLoading
            ? LinearProgressIndicator()
            : Container(
                padding: EdgeInsets.all(14),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Sport',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      value: _selectedSport,
                      items: _sports.map((sport) {
                        return DropdownMenuItem(
                          value: sport,
                          child: Text(sport),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedSport = newValue;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Please select a Sport' : null,
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      value: _selectedGender,
                      items: _genders.map((gender) {
                        return DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Please select a gender' : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _venueController,
                      decoration: InputDecoration(
                        labelText: 'Venue',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      validator: (value) =>
                          value == null ? 'Please select a gender' : null,
                    ),
                    Divider(height: 40, thickness: 1),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Pick Contingents for the match',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Continent 1',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            value: _selectedContingent1,
                            items: _contingents.map((gender) {
                              return DropdownMenuItem(
                                value: gender,
                                child: Text(gender),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedContingent1 = newValue;
                              });
                            },
                            validator: (value) => value == null
                                ? 'Please select a Contingent'
                                : null,
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Contingent 2',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            value: _selectedContingent2,
                            items: _contingents.map((gender) {
                              return DropdownMenuItem(
                                value: gender,
                                child: Text(gender),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedContingent2 = newValue;
                              });
                            },
                            validator: (value) => value == null
                                ? 'Please select a Contingent'
                                : null,
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 40, thickness: 1),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Set Points Distribution',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _winController,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Win',
                              hintText: '2',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please enter points'
                                : null,
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            controller: _lossController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Loss',
                              hintText: '0',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please enter points'
                                : null,
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            controller: _drawController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Draw',
                              hintText: '1',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please enter points'
                                : null,
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 40, thickness: 1),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Pick date for the match',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _date?.toString().split(' ')[0] ?? 'YYYY-MM-DD',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        OutlinedButton(
                          onPressed: setDate,
                          child: Text('Select Date'),
                        ),
                      ],
                    ),
                    Divider(
                      height: 40,
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Start Time',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                _startTime?.format(context) ?? 'HH:MM AM/PM',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () async {
                                final TimeOfDay? time = await setTime();
                                if (time != null) {
                                  setState(() {
                                    _startTime = time;
                                  });
                                }
                              },
                              child: Text('Select Time'),
                            ),
                          ],
                        ),
                        Text('to'),
                        Column(
                          children: [
                            Text(
                              'End Time',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                _endTime?.format(context) ?? 'HH:MM AM/PM',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () async {
                                final TimeOfDay? time = await setTime();
                                if (time != null) {
                                  setState(() {
                                    _endTime = time;
                                  });
                                }
                              },
                              child: Text('Select Date'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(height: 40, thickness: 1),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Enter Email of the Scorekeeper',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _scorekeeperController,
                      decoration: InputDecoration(
                        labelText: 'Scorekeeper Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      validator: (value) {
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!)) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    FilledButton(
                      onPressed: _onSubmit,
                      child: Container(
                        width: double.maxFinite,
                        alignment: Alignment.center,
                        height: 56,
                        child: Text(
                          'Create Match',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
