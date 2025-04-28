import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nolatech_tenis/features/common/domain/entities/court_entity.dart';
import 'package:nolatech_tenis/features/reservation/presentation/bloc/reservation_bloc.dart';
import 'package:nolatech_tenis/features/reservation/presentation/bloc/reservation_event.dart';
import 'package:nolatech_tenis/features/common/domain/entities/reservation_entity.dart';
import 'package:uuid/uuid.dart';

class NewReservationPage extends StatefulWidget {
  final CourtEntity court;

  const NewReservationPage({super.key, required this.court});

  @override
  State<NewReservationPage> createState() => _NewReservationPageState();
}

class _NewReservationPageState extends State<NewReservationPage> {
  final _commentController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String? selectedInstructor;

  final instructors = ['Instructor A', 'Instructor B', 'Instructor C'];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Image.asset(
                      widget.court.imageUrl,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.green[400],
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: const Color(0xfff5f7fb),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCourtInfo(l10n),
                    const SizedBox(height: 20),
                    _buildInstructorDropdown(l10n),
                    const SizedBox(height: 30),
                    _buildDateAndTimePickers(l10n),
                    const SizedBox(height: 30),
                    _buildCommentField(l10n),
                    const SizedBox(height: 30),
                    _buildReserveButton(l10n),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourtInfo(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                widget.court.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              l10n.pricePlaceholder,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              l10n.perHour,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          l10n.courtType(widget.court.type),
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 16),
            const SizedBox(width: 5),
            Text(
              l10n.available,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.access_time, size: 16, color: Colors.grey),
            const SizedBox(width: 5),
            Text(
              l10n.availableHours,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 16,
              color: Colors.grey,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                l10n.locationPlaceholder,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInstructorDropdown(AppLocalizations l10n) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: l10n.addInstructor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      value: selectedInstructor,
      onChanged: (value) {
        setState(() {
          selectedInstructor = value;
        });
      },
      items:
          instructors
              .map(
                (instructor) => DropdownMenuItem(
                  value: instructor,
                  child: Text(instructor),
                ),
              )
              .toList(),
    );
  }

  Widget _buildDateAndTimePickers(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.setDateAndTime,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(children: [Expanded(child: _buildDatePicker(l10n))]),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildStartTimePicker(l10n)),
            const SizedBox(width: 10),
            Expanded(child: _buildEndTimePicker(l10n)),
          ],
        ),
      ],
    );
  }

  Widget _buildDatePicker(AppLocalizations l10n) {
    return _buildCustomField(
      text:
          selectedDate == null
              ? l10n.selectDate
              : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
      onTap: _selectDate,
    );
  }

  Widget _buildStartTimePicker(AppLocalizations l10n) {
    return _buildCustomField(
      text:
          startTime == null
              ? l10n.startTime
              : '${startTime!.hour.toString().padLeft(2, '0')}:${startTime!.minute.toString().padLeft(2, '0')}',
      onTap: _selectStartTime,
    );
  }

  Widget _buildEndTimePicker(AppLocalizations l10n) {
    return _buildCustomField(
      text:
          endTime == null
              ? l10n.endTime
              : '${endTime!.hour.toString().padLeft(2, '0')}:${endTime!.minute.toString().padLeft(2, '0')}',
      onTap: _selectEndTime,
    );
  }

  Widget _buildCustomField({
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ),
    );
  }

  Widget _buildCommentField(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.addComment,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _commentController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: l10n.addCommentPlaceholder,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      ],
    );
  }

  Widget _buildReserveButton(AppLocalizations l10n) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _confirmReservation,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffc9e48f),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(l10n.reserveButton, style: const TextStyle(fontSize: 18)),
      ),
    );
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectStartTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        startTime = picked;
      });
    }
  }

  Future<void> _selectEndTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        endTime = picked;
      });
    }
  }

  void _confirmReservation() {
    final l10n = AppLocalizations.of(context)!;

    if (selectedDate == null || startTime == null || endTime == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.completeDateAndTime)));
      return;
    }

    final startDateTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      startTime!.hour,
      startTime!.minute,
    );

    final newReservation = ReservationEntity(
      id: const Uuid().v4(),
      userId: 'user1',
      userName: 'Andrea Gómez',
      courtId: widget.court.id,
      courtName: widget.court.name,
      courtImageUrl: widget.court.imageUrl,
      dateTime: startDateTime,
      instructor: selectedInstructor,
      comment: _commentController.text,
      isFavorite: false,
      rainProbability: null,
    );

    context.read<ReservationBloc>().add(CreateReservationEvent(newReservation));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.reservationSuccess)));
    Navigator.pop(context);
  }
}
