import 'package:flutter/material.dart';
import 'package:hunger_games/services/gallery_utility.dart';
import 'package:hunger_games/services/tournament_service.dart';
import 'package:hunger_games/utils/url_launchers.dart';

class TournamentData extends StatefulWidget {
  final String tournamentId;
  const TournamentData({super.key, required this.tournamentId});

  @override
  State<TournamentData> createState() => _TournamentDataState();
}

class _TournamentDataState extends State<TournamentData> {
  final TournamentService _tournamentService = TournamentService();
  final GalleryService _galleryService = GalleryService();
  final TextStyle _fieldTextStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  final TextStyle _valueTextStyle = TextStyle(fontSize: 16);
  final TextStyle _phoneNumberStyle = TextStyle(
    fontSize: 16,
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _urlController = TextEditingController();

  late Map<String, dynamic> _tournamentData;
  bool _isLoading = false;

  Future<void> _fetchTournamentData() async {
    setState(() {
      _isLoading = true;
    });

    Map<String, dynamic> data =
        await _tournamentService.getTournamentById(widget.tournamentId);

    setState(() {
      _tournamentData = data;
      _isLoading = false;
    });
  }

  @override
  initState() {
    _fetchTournamentData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LinearProgressIndicator()
        : Column(
            children: [
              SizedBox(
                width: double.maxFinite,
                child: DataTable(
                  dividerThickness: 0,
                  headingRowHeight: 0,
                  columns: [
                    DataColumn(
                      label: Text("Field"),
                    ),
                    DataColumn(
                      label: Text("Value"),
                    ),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(
                          Text(
                            "Tournament Name",
                            style: _fieldTextStyle,
                          ),
                        ),
                        DataCell(
                          Text(
                            _tournamentData["name"],
                            style: _valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Text(
                            "Host",
                            style: _fieldTextStyle,
                          ),
                        ),
                        DataCell(
                          Text(
                            _tournamentData["hostInstitute"],
                            style: _valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Text(
                            "Start Date",
                            style: _fieldTextStyle,
                          ),
                        ),
                        DataCell(
                          Text(
                            _tournamentData["startDate"]
                                .toDate()
                                .toString()
                                .split(' ')[0],
                            style: _valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Text(
                            "End Date",
                            style: _fieldTextStyle,
                          ),
                        ),
                        DataCell(
                          Text(
                            _tournamentData["endDate"]
                                .toDate()
                                .toString()
                                .split(' ')[0],
                            style: _valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Text(
                            "Organiser contact",
                            style: _fieldTextStyle,
                          ),
                        ),
                        DataCell(
                          GestureDetector(
                            onTap: () {
                              phoneLauncher(_tournamentData["organiser"]);
                            },
                            child: Text(
                              _tournamentData["organiser"],
                              style: _phoneNumberStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Text(
                            "Medic contact",
                            style: _fieldTextStyle,
                          ),
                        ),
                        DataCell(
                          GestureDetector(
                            onTap: () {
                              phoneLauncher(_tournamentData["medical"]);
                            },
                            child: Text(
                              _tournamentData["medical"],
                              style: _phoneNumberStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Text(
                            "Security contact",
                            style: _fieldTextStyle,
                          ),
                        ),
                        DataCell(
                          GestureDetector(
                            onTap: () {
                              phoneLauncher(_tournamentData["security"]);
                            },
                            child: Text(
                              _tournamentData["security"],
                              style: _phoneNumberStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Text(
                            "Organiser email",
                            style: _fieldTextStyle,
                          ),
                        ),
                        DataCell(
                          GestureDetector(
                            onTap: () {
                              emailLauncher(_tournamentData["organiserEmail"]);
                            },
                            child: Text(
                              _tournamentData["organiserEmail"],
                              style: _phoneNumberStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Text(
                            "Gold Medal Points",
                            style: _fieldTextStyle,
                          ),
                        ),
                        DataCell(
                          Text(
                            _tournamentData["goldMedalPoints"].toString(),
                            style: _valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Text(
                            "Silver Medal Points",
                            style: _fieldTextStyle,
                          ),
                        ),
                        DataCell(
                          Text(
                            _tournamentData["silverMedalPoints"].toString(),
                            style: _valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Text(
                            "Bronze Medal Points",
                            style: _fieldTextStyle,
                          ),
                        ),
                        DataCell(
                          Text(
                            _tournamentData["bronzeMedalPoints"].toString(),
                            style: _valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Text(
                            "Galley Action",
                            style: _fieldTextStyle,
                          ),
                        ),
                        DataCell(
                          OutlinedButton(
                            child: Text("Add Images"),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Add Image URL"),
                                      content: Form(
                                        key: _formKey,
                                        child: TextFormField(
                                          controller: _urlController,
                                          decoration: InputDecoration(
                                            labelText: "Image URL",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please enter a URL";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      actions: [
                                        FilledButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              String imageUrl =
                                                  _urlController.text;
                                              bool success =
                                                  await _galleryService
                                                      .addImage(
                                                widget.tournamentId,
                                                imageUrl,
                                              );

                                              if (success) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Image added successfully"),
                                                ));
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Failed to add image"),
                                                ));
                                              }
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          child: Text("Add"),
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Close"),
                                        ),
                                      ],
                                    );
                                  });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
