import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';

class PermissionStaffScreen extends StatefulWidget {
  const PermissionStaffScreen({super.key});

  @override
  State<PermissionStaffScreen> createState() => _PermissionStaffScreenState();
}

class _PermissionStaffScreenState extends State<PermissionStaffScreen> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _textAreaCtrl = TextEditingController();

  String? _position;
  DateTime? _startDate;
  DateTime? _endDate;
  String _choice = "មួយថ្ងៃ";
  String? _fileName;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _textAreaCtrl.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? d) {
    if (d == null) return "";
    return "${d.day.toString().padLeft(2, '0')}-${d.month.toString().padLeft(2, '0')}-${d.year}";
  }

  Future<void> _pickDate({required bool isStart}) async {
    final now = DateTime.now();
    final initial = isStart ? (_startDate ?? now) : (_endDate ?? _startDate ?? now);

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked == null) return;

    setState(() {
      if (isStart) {
        _startDate = picked;
        if (_endDate != null && _endDate!.isBefore(picked)) {
          _endDate = null;
        }
      } else {
        _endDate = picked;
      }
    });
  }

  Future<void> _pickFile() async {
    final res = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (res == null) return;

    setState(() {
      _fileName = res.files.single.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  Padding buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              _label("ឈ្មោះ (Name)"),
              _textField(controller: _textAreaCtrl, hint: "បញ្ចូលឈ្មោះ"),
              const SizedBox(height: 14),

              // Position
              _label("មុខតំណែង (Position)"),
              DropdownButtonFormField<String>(
                value: _position,
                hint: Text("ជ្រើសរើសមុខតំណែង", style:GoogleFonts.battambang(fontSize: 16)),
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                items: [
                  DropdownMenuItem(value: "HCMC", child: Text("HCMC",style:GoogleFonts.battambang(fontSize: 16))),
                  DropdownMenuItem(value: "DDF", child: Text("DDF",style:GoogleFonts.battambang(fontSize: 16))),
                  DropdownMenuItem(value: "CMS", child: Text("CMS",style:GoogleFonts.battambang(fontSize: 16))),
                  DropdownMenuItem(value: "CNM", child: Text("CNM",style:GoogleFonts.battambang(fontSize: 16))),
                  DropdownMenuItem(value: "Procument", child: Text("Procument")),
                ],
                onChanged: (v) => setState(() => _position = v),
              ),
              const SizedBox(height: 14),

              // Start Date
              _label("ថ្ងៃចាប់ផ្តើម (Start Date)"),
              InkWell(
                onTap: () => _pickDate(isStart: true),
                child: _dateBox(
                  text: _startDate == null ? "ជ្រើសរើសថ្ងៃចាប់ផ្តើម" : _formatDate(_startDate),
                ),
              ),
              const SizedBox(height: 14),

              // End Date
              _label("ថ្ងៃបញ្ចប់ (End Date)"),
              InkWell(
                onTap: _startDate == null ? null : () => _pickDate(isStart: false),
                child: Opacity(
                  opacity: _startDate == null ? 0.5 : 1,
                  child: _dateBox(
                    text: _endDate == null ? "ជ្រើសរើសថ្ងៃបញ្ចប់" : _formatDate(_endDate),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Radio Choice
              _label("ជម្រើស (Choice)"),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: [
                  _radioChip("មួយថ្ងៃ"),
                  _radioChip("មួយខែ"),
                  _radioChip("មួយឆ្នាំ"),
                ],
              ),
              const SizedBox(height: 14),

              // Import File
              _label("នាំចូលឯកសារ (Import File)"),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Text(
                        _fileName ?? "មិនទាន់ជ្រើសរើសឯកសារ",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.battambang(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: _pickFile,
                    icon: const Icon(Icons.upload_file),
                    label: Text("Import", style: GoogleFonts.battambang()),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Textarea
              _label("ពណ៌នា/មូលហេតុ (Textarea)"),
              TextField(
                controller: _textAreaCtrl,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "សរសេរព័ត៌មានបន្ថែម...",
                  hintStyle: GoogleFonts.battambang(fontSize: 20),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                style: GoogleFonts.battambang(),
              ),

              const SizedBox(height: 18),

              // Optional submit button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Submit logic
                    // print(_nameCtrl.text);
                    // print(_position);
                  },
                  child: Text("បញ្ជូន (Submit)", style: GoogleFonts.battambang(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- Widgets ----------
  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: GoogleFonts.battambang(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _textField({required TextEditingController controller, required String hint}) {
    return TextField(
      controller: controller,
      style: GoogleFonts.battambang(),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.battambang(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
  }

  Widget _dateBox({required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          Expanded(child: Text(text, style: GoogleFonts.battambang())),
          const Icon(Icons.date_range),
        ],
      ),
    );
  }

  Widget _radioChip(String value) {
    final selected = _choice == value;
    return InkWell(
      onTap: () => setState(() => _choice = value),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              size: 18,
              color: selected ? Colors.white : Colors.black54,
            ),
            const SizedBox(width: 6),
            Text(
              value,
              style: GoogleFonts.battambang(
                color: selected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: MediaQuery.of(context).size.height * 0.07,
      leadingWidth: 110,
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(width: 10),
            const Icon(Icons.arrow_back_ios, size: 26, color: Colors.blue),
            Text("ចាកចេញ",style: GoogleFonts.battambang(fontSize: 21, color: Colors.blue),
            )
          ],
        ),
      ),
      title: Text("ការស្នើសុំច្បាប់", style: GoogleFonts.moul(fontSize: 24)),
    );
  }
}
