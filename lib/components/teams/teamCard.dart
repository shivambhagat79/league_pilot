import 'package:flutter/material.dart';

class TeamCard extends StatefulWidget {
  final String teamName;
  final String logoUrl;
  final String description;

  const TeamCard({
    super.key,
    required this.teamName,
    required this.logoUrl,
    required this.description,
  });

  @override
  _TeamCardState createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isTapped = true;
        });
      },
      onTapUp: (_) {
        Future.delayed(const Duration(milliseconds: 150), () {
          setState(() {
            _isTapped = false;
          });
        });
      },
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      child: AnimatedScale(
        scale: _isTapped ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.teal[100],
          child: Padding(
            padding: const EdgeInsets.all(8.0), // Added proper padding
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Ensures the Row doesn’t take extra space
              children: [
                SizedBox( // Restricting the image size to prevent overflow
                  width: 50,
                  height: 50,
                  child: Hero(
                    tag: "teamLogo_${widget.teamName}",
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        widget.logoUrl, // This should be a valid asset path
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                      ),
                    ),

                  ),
                ),
                const SizedBox(width: 16),
                Expanded( // Ensures text does not cause overflow
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.teamName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                        softWrap: true, // Ensures proper text wrapping
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.teal[900],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),


        ),
      ),
    );
  }
}
