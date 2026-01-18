import 'package:flutter/material.dart';

class StaffDetailScreen extends StatelessWidget {
  final Staff staff;

  const StaffDetailScreen({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Staff Detail')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _HeaderCard(staff: staff),
          const SizedBox(height: 12),
          _InfoCard(staff: staff),
          const SizedBox(height: 12),
          _QuickActions(staff: staff),
          const SizedBox(height: 12),
          _ShiftSection(shifts: staff.upcomingShifts),
          const SizedBox(height: 12),
          _NotesSection(notes: staff.notes),
        ],
      ),
    );
  }
}

/// HEADER
class _HeaderCard extends StatelessWidget {
  final Staff staff;
  const _HeaderCard({required this.staff});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              child: Text(
                staff.name.isEmpty ? '?' : staff.name[0].toUpperCase(),
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    staff.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('${staff.role} • ID: ${staff.id}'),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(
                        avatar: const Icon(Icons.verified_user_outlined, size: 18),
                        label: Text(staff.status),
                      ),
                      Chip(
                        avatar: const Icon(Icons.apartment_outlined, size: 18),
                        label: Text(staff.department),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// INFO
class _InfoCard extends StatelessWidget {
  final Staff staff;
  const _InfoCard({required this.staff});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _InfoTile(
            icon: Icons.phone_outlined,
            title: 'Phone',
            value: staff.phone,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Call ${staff.phone}')),
              );
            },
          ),
          const Divider(height: 1),
          _InfoTile(
            icon: Icons.email_outlined,
            title: 'Email',
            value: staff.email.isEmpty ? '-' : staff.email,
            onTap: staff.email.isEmpty
                ? null
                : () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Email ${staff.email}')),
              );
            },
          ),
          const Divider(height: 1),
          _InfoTile(
            icon: Icons.badge_outlined,
            title: 'Position',
            value: staff.role,
          ),
          const Divider(height: 1),
          _InfoTile(
            icon: Icons.calendar_month_outlined,
            title: 'Joined date',
            value: staff.joinedDate,
          ),
        ],
      ),
    );
  }
}

/// QUICK ACTIONS
class _QuickActions extends StatelessWidget {
  final Staff staff;
  const _QuickActions({required this.staff});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Message ${staff.name}')),
                  );
                },
                icon: const Icon(Icons.chat_outlined),
                label: const Text('Message'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Assign shift to ${staff.name}')),
                  );
                },
                icon: const Icon(Icons.schedule_outlined),
                label: const Text('Assign Shift'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// SHIFTS
class _ShiftSection extends StatelessWidget {
  final List<StaffShift> shifts;
  const _ShiftSection({required this.shifts});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Upcoming Shifts',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('View all shifts')),
                    );
                  },
                  child: const Text('View all'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (shifts.isEmpty)
              const Text('No shifts scheduled.')
            else
              Column(
                children: shifts.take(3).map((s) => _ShiftTile(shift: s)).toList(),
              ),
          ],
        ),
      ),
    );
  }
}

class _ShiftTile extends StatelessWidget {
  final StaffShift shift;
  const _ShiftTile({required this.shift});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.event_available_outlined),
      title: Text(shift.date),
      subtitle: Text('${shift.startTime} - ${shift.endTime}'),
      trailing: shift.location.isEmpty ? null : Text(shift.location),
    );
  }
}

/// NOTES
class _NotesSection extends StatelessWidget {
  final String notes;
  const _NotesSection({required this.notes});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(notes.isEmpty ? 'No notes yet.' : notes),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Add note action')),
                );
              },
              icon: const Icon(Icons.note_add_outlined),
              label: const Text('Add Note'),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback? onTap;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(value),
      trailing: onTap == null ? null : const Icon(Icons.chevron_right),
    );
  }
}

/// ✅ FIXED MODELS (simple + consistent)
class Staff {
  final String id;
  final String name;
  final String role; // Attendant, Supervisor, Manager...
  final String phone;

  final String email;
  final String department;
  final String joinedDate; // string for simplicity
  final String status; // Active / Inactive
  final List<StaffShift> upcomingShifts;
  final String notes;

  const Staff({
    required this.id,
    required this.name,
    required this.role,
    required this.phone,
    this.email = '',
    this.department = '',
    this.joinedDate = '',
    this.status = 'Active',
    this.upcomingShifts = const [],
    this.notes = '',
  });
}

class StaffShift {
  final String date; // e.g. 2026-01-16
  final String startTime; // e.g. 08:00
  final String endTime; // e.g. 17:00
  final String location;

  const StaffShift({
    required this.date,
    required this.startTime,
    required this.endTime,
    this.location = '',
  });
}

/// ✅ SAMPLE DATA (works immediately)
const demoStaff = Staff(
  id: 'S001',
  name: 'Makara Sok',
  role: 'Attendant',
  phone: '010 123 456',
  email: 'makara@example.com',
  department: 'Front Desk',
  joinedDate: '2024-08-10',
  status: 'Active',
  upcomingShifts: [
    StaffShift(date: '2026-01-16', startTime: '08:00', endTime: '17:00', location: 'Main Lobby'),
    StaffShift(date: '2026-01-17', startTime: '08:00', endTime: '17:00', location: 'Main Lobby'),
  ],
  notes: 'Very punctual. Great with guests.',
);

// Example usage:
// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (_) => const StaffDetailScreen(staff: demoStaff),
//   ),
// );
