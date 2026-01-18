import 'package:flutter/material.dart';
import 'package:mission_attendant_app/screen/staff_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  final List<Staff> _allStaff = const [
    Staff(id: 'S001', name: 'Makara Ban', role: 'Attendant', phone: '010 123 456'),
    Staff(id: 'S002', name: 'Sokha Chan', role: 'Attendant', phone: '011 234 567'),
    Staff(id: 'S003', name: 'Dara Kim', role: 'Supervisor', phone: '012 345 678'),
    Staff(id: 'S004', name: 'Sophy Roeun', role: 'Attendant', phone: '015 456 789'),
    Staff(id: 'S005', name: 'Vanna Lim', role: 'Manager', phone: '016 567 890'),
    Staff(id: 'S006', name: 'Nhem Boy', role: 'Attendant', phone: '017 678 901'),
    Staff(id: 'S006', name: 'Lim Sros', role: 'Attendant', phone: '017 678 901'),
    Staff(id: 'S006', name: 'Rina Pov', role: 'Attendant', phone: '017 678 901'),
    Staff(id: 'S006', name: 'Rim Chil', role: 'Attendant', phone: '017 678 901'),
  ];

  String _query = '';
  StaffRoleFilter _filter = StaffRoleFilter.attendant; // default

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Staff> get _filtered {
    final q = _query.trim().toLowerCase();

    Iterable<Staff> list = _allStaff;

    // Role filter
    if (_filter != StaffRoleFilter.all) {
      final wanted = _filter.label.toLowerCase();
      list = list.where((s) => s.role.toLowerCase() == wanted);
    }

    // Search query
    if (q.isNotEmpty) {
      list = list.where((s) =>
      s.name.toLowerCase().contains(q) ||
          s.id.toLowerCase().contains(q) ||
          s.phone.toLowerCase().contains(q));
    }

    return list.toList();
  }

  void _clear() {
    setState(() {
      _query = '';
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final results = _filtered;

    return Scaffold(
      body: Column(
        children: [
          // Search + Filter header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  onChanged: (v) => setState(() => _query = v),
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'Search by name, ID, or phone',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _query.isEmpty
                        ? null
                        : IconButton(
                      tooltip: 'Clear',
                      onPressed: _clear,
                      icon: const Icon(Icons.close),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('Role:'),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SegmentedButton<StaffRoleFilter>(
                        segments: const [
                          ButtonSegment(
                            value: StaffRoleFilter.attendant,
                            label: Text('Attendant'),
                            icon: Icon(Icons.badge_outlined),
                          ),
                          ButtonSegment(
                            value: StaffRoleFilter.all,
                            label: Text('All'),
                            icon: Icon(Icons.group_outlined),
                          ),
                        ],
                        selected: {_filter},
                        onSelectionChanged: (set) {
                          setState(() => _filter = set.first);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Results
          Expanded(
            child: results.isEmpty
                ? _EmptyResults(query: _query)
                : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: results.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final s = results[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        s.name.isEmpty ? '?' : s.name[0].toUpperCase(),
                      ),
                    ),
                    title: Text(s.name),
                    subtitle: Text('${s.role} • ${s.id}\n${s.phone}'),
                    isThreeLine: true,
                    trailing: IconButton(
                      tooltip: 'Call',
                      icon: const Icon(Icons.call_outlined),
                      onPressed: () {
                        // TODO: integrate url_launcher to call:
                        // launchUrl(Uri.parse('tel:${s.phone}'));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Call ${s.phone}')),
                        );
                      },
                    ),
                    onTap: () {
                      // TODO: open staff detail page
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(content: Text('Selected: ${s.name}')),
                      // );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const StaffDetailScreen(staff: demoStaff),
                        ),
                      );
                    },
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

class _EmptyResults extends StatelessWidget {
  final String query;
  const _EmptyResults({required this.query});

  @override
  Widget build(BuildContext context) {
    final q = query.trim();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off_outlined, size: 64),
            const SizedBox(height: 10),
            Text(
              q.isEmpty ? 'Start searching' : 'No results',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              q.isEmpty
                  ? 'Type a name, staff ID, or phone number.'
                  : 'Nothing matched "$q". Try another keyword.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

enum StaffRoleFilter { attendant, all }

extension StaffRoleFilterX on StaffRoleFilter {
  String get label {
    switch (this) {
      case StaffRoleFilter.attendant:
        return 'Attendant';
      case StaffRoleFilter.all:
        return 'All';
    }
  }
}

class Staff {
  final String id;
  final String name;
  final String role;
  final String phone;

  const Staff({
    required this.id,
    required this.name,
    required this.role,
    required this.phone,
  });
}
