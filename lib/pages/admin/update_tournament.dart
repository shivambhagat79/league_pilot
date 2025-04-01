import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/pages/admin/admin_tournament.dart';
import 'package:hunger_games/services/tournament_service.dart';

class UpdateTournamentPage extends StatefulWidget {
  final String tournamentId;
  const UpdateTournamentPage({super.key, required this.tournamentId});

  @override
  State<UpdateTournamentPage> createState() => _UpdateTournamentPageState();
}

class _UpdateTournamentPageState extends State<UpdateTournamentPage> {
  final _formKey = GlobalKey<FormState>();
  TournamentService tournamentService = TournamentService();
  final List<String> _sports = [
    "Football",
    "Cricket",
    "Basketball",
    "Lawn Tennis",
    "Badminton",
    "Volleyball",
    "Hockey",
    "Chess"
  ];

  final _tournamentNameController = TextEditingController();
  final _hostInstituteController = TextEditingController();
  final _goldMedalController = TextEditingController();
  final _silverMedalController = TextEditingController();
  final _bronzeMedalController = TextEditingController();
  final _hostLatitudeController = TextEditingController();
  final _hostLongitudeController = TextEditingController();
  final _organisingTeamContactController = TextEditingController();
  final _medicContactController = TextEditingController();
  final _securityContactController = TextEditingController();
  final _organisingTeamEmailController = TextEditingController();
  bool _isLoading = false;

  final List<String> _selectedSports = [];
  DateTime? _startdate, _endDate;
  final List<String> _contingents = [];
  final List<String> _admins = [];

  Future<DateTime?> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _startdate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    return pickedDate;
  }

  Future<void> _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      if (_startdate == null || _endDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please select start and end date")));
        return;
      }
      if (_startdate!.isAfter(_endDate!)) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Start date cannot be after end date")));
        return;
      }
      if (_selectedSports.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please select at least one sport")));
        return;
      }
      if (_contingents.length < 2) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please add at least 2 contingents")));
        return;
      }
      if (_admins.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please add at least one admin")));
        return;
      }

      setState(() {
        _isLoading = true;
      });

      String? tournamentId = await tournamentService.createTournament(
        name: _tournamentNameController.text,
        hostInstitute: _hostInstituteController.text,
        startDate: _startdate ?? DateTime.now(),
        endDate: _endDate ?? DateTime.now(),
        admins: _admins,
        sports: _selectedSports,
        contingents: _contingents,
        goldMedalPointsString: _goldMedalController.text,
        silverMedalPointsString: _silverMedalController.text,
        bronzeMedalPointsString: _bronzeMedalController.text,
        latitudeString: _hostLatitudeController.text,
        longitudeString: _hostLongitudeController.text,
        security: _securityContactController.text,
        medical: _medicContactController.text,
        organiser: _organisingTeamContactController.text,
        organiserEmail: _organisingTeamEmailController.text,
      );

      if (tournamentId != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Tournament created successfully"),
          ),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => AdminTourrnamentPage(
              title: _tournamentNameController.text,
              tournamentId: tournamentId,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to create tournament"),
          ),
        );
        Navigator.of(context).pop();
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    final tournament =
        await tournamentService.getTournamentById(widget.tournamentId);

    setState(() {
      _tournamentNameController.text = tournament['name'];
      _hostInstituteController.text = tournament['hostInstitute'];
      _goldMedalController.text = tournament['goldMedalPoints'].toString();
      _silverMedalController.text = tournament['silverMedalPoints'].toString();
      _bronzeMedalController.text = tournament['bronzeMedalPoints'].toString();
      _hostLatitudeController.text = tournament['latitude'].toString();
      _hostLongitudeController.text = tournament['longitude'].toString();
      _organisingTeamContactController.text = tournament['organiser'];
      _medicContactController.text = tournament['medical'];
      _securityContactController.text = tournament['security'];
      _organisingTeamEmailController.text = tournament['organiserEmail'];
      _startdate = tournament['startDate'].toDate();
      _endDate = tournament['endDate'].toDate();
      tournament['sports'].forEach((element) {
        _selectedSports.add(element.toString());
      });
      tournament['contingents'].forEach((element) {
        _contingents.add(element.toString());
      });
      tournament['admins'].forEach((element) {
        _admins.add(element.toString());
      });

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
      title: 'Update Tournament',
      child: _isLoading
          ? LinearProgressIndicator()
          : Form(
              key: _formKey,
              child: _isLoading
                  ? LinearProgressIndicator()
                  : Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _tournamentNameController,
                            decoration: InputDecoration(
                              labelText: 'Tournament Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _hostInstituteController,
                            decoration: InputDecoration(
                              labelText: 'Host',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter valid host institute name';
                              }
                              return null;
                            },
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
                                    'Start Date',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 6),
                                    child: Text(
                                      _startdate
                                              ?.toLocal()
                                              .toString()
                                              .split(' ')[0] ??
                                          'YYYY-MM-DD',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  OutlinedButton(
                                    onPressed: () async {
                                      final DateTime? date =
                                          await _selectDate();
                                      if (date != null) {
                                        setState(() {
                                          _startdate = date;
                                        });
                                      }
                                    },
                                    child: Text('Select Date'),
                                  ),
                                ],
                              ),
                              Text('to'),
                              Column(
                                children: [
                                  Text(
                                    'End Date',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 6),
                                    child: Text(
                                      _endDate
                                              ?.toLocal()
                                              .toString()
                                              .split(' ')[0] ??
                                          'YYYY-MM-DD',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  OutlinedButton(
                                    onPressed: () async {
                                      final DateTime? date =
                                          await _selectDate();
                                      if (date != null) {
                                        setState(() {
                                          _endDate = date;
                                        });
                                      }
                                    },
                                    child: Text('Select Date'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            height: 40,
                            thickness: 1,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Select Sports',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            childAspectRatio: 3.5,
                            shrinkWrap: true,
                            children: _sports
                                .map((sport) => CheckboxListTile(
                                      title: Text(sport),
                                      value: _selectedSports.contains(sport),
                                      onChanged: (bool? newValue) {
                                        setState(() {
                                          _selectedSports.contains(sport)
                                              ? _selectedSports.remove(sport)
                                              : _selectedSports.add(sport);
                                        });
                                      },
                                    ))
                                .toList(),
                          ),
                          Divider(
                            height: 40,
                            thickness: 1,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Assign Points to Medals',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _goldMedalController,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              icon: SizedBox(
                                width: 160,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.emoji_events,
                                      color: Colors.orange,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Gold Medal",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                              ),
                              hintText: '8',
                              labelText: 'Points',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter points';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _silverMedalController,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              icon: SizedBox(
                                width: 160,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.emoji_events,
                                      color: Colors.blueGrey,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Silver Medal",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                              ),
                              labelText: 'Points',
                              hintText: '4',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter points';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _bronzeMedalController,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              icon: SizedBox(
                                width: 160,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.emoji_events,
                                      color: Colors.brown.shade800,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Bronze Medal",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                              ),
                              hintText: '2',
                              labelText: 'Points',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter points';
                              }
                              return null;
                            },
                          ),
                          Divider(
                            height: 40,
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Add Contingents',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              FilledButton.icon(
                                onPressed: () {
                                  final controller = TextEditingController();
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title:
                                          Text("Add Name of the Contingent:"),
                                      content: TextField(
                                        controller: controller,
                                        decoration: InputDecoration(
                                          label: Text("Contingent"),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        FilledButton(
                                          onPressed: () {
                                            if (controller.text.isNotEmpty) {
                                              setState(() {
                                                _contingents
                                                    .add(controller.text);
                                              });
                                            }
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Add"),
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Cancel"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: Icon(Icons.add),
                                label: Text("Add"),
                              ),
                            ],
                          ),
                          Column(
                            children: _contingents
                                .map((contingent) => Column(
                                      children: [
                                        ListTile(
                                          title: Text(contingent),
                                          trailing: IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () {
                                              setState(() {
                                                _contingents.remove(contingent);
                                              });
                                            },
                                          ),
                                        ),
                                        Divider(
                                          height: 0,
                                        ),
                                      ],
                                    ))
                                .toList(),
                          ),
                          Divider(
                            height: 40,
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Add Admins',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              FilledButton.icon(
                                onPressed: () {
                                  final controller = TextEditingController();
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("Add Email of the admin:"),
                                      content: TextField(
                                        controller: controller,
                                        decoration: InputDecoration(
                                          label: Text("Admin Email"),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        FilledButton(
                                          onPressed: () {
                                            if (controller.text.isNotEmpty) {
                                              setState(() {
                                                _admins.add(controller.text);
                                              });
                                            }
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Add"),
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Cancel"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: Icon(Icons.add),
                                label: Text("Add"),
                              ),
                            ],
                          ),
                          Column(
                            children: _admins
                                .map((contingent) => Column(
                                      children: [
                                        ListTile(
                                          title: Text(contingent),
                                          trailing: IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () {
                                              setState(() {
                                                _admins.remove(contingent);
                                              });
                                            },
                                          ),
                                        ),
                                        Divider(
                                          height: 0,
                                        ),
                                      ],
                                    ))
                                .toList(),
                          ),
                          Divider(
                            height: 40,
                            thickness: 1,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Add Host Map Coordinates',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _hostLatitudeController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    label: Text("Latitude"),
                                    hintText: "Enter Host Latitude",
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter a latitude";
                                    } else if (!RegExp(
                                            r"^-?([1-9]?\d(\.\d+)?|180(\.0+)?)$")
                                        .hasMatch(value)) {
                                      return "Enter a valid floating point latitude value";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: TextFormField(
                                  controller: _hostLongitudeController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    label: Text("Longitude"),
                                    hintText: "Enter Host Longitude",
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter a Longitude";
                                    } else if (!RegExp(
                                            r"^-?([1-9]?\d(\.\d+)?|180(\.0+)?)$")
                                        .hasMatch(value)) {
                                      return "Enter a valid floating point longitude value";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            height: 40,
                            thickness: 1,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Add Miscellaneous Details',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _organisingTeamContactController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              label: Text("Organising team contact no."),
                              hintText: "Enter contact no.",
                              icon: Icon(Icons.phone),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter phone number';
                              }
                              // Validate phone number format (10 digits in this example).
                              if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                                return 'Please enter a valid 10-digit phone number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _medicContactController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              label: Text("Medic contact no."),
                              hintText: "Enter contact no.",
                              icon: Icon(Icons.medical_information),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter phone number';
                              }
                              // Validate phone number format (10 digits in this example).
                              if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                                return 'Please enter a valid 10-digit phone number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _securityContactController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              label: Text("Security contact no."),
                              hintText: "Enter contact no.",
                              icon: Icon(Icons.security),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter phone number';
                              }
                              // Validate phone number format (10 digits in this example).
                              if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                                return 'Please enter a valid 10-digit phone number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _organisingTeamEmailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              label: Text("Organising Team Email"),
                              hintText: "Enter email",
                              icon: Icon(Icons.mail),
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
                          SizedBox(height: 20),
                          SizedBox(height: 20),
                          FilledButton(
                            onPressed: _onSubmit,
                            child: Container(
                              width: double.maxFinite,
                              alignment: Alignment.center,
                              height: 56,
                              child: Text(
                                'Create Tournament',
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
