import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      children: [
        // Avatar
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.lightBlue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/assets?q=tbn:ANd9GcQssdL0Yty9vYW-vjEzZqg2QbVSKFVrq3wLGA&s',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Code My Infomation
        buildInformation(),
        SizedBox(height: 20),
        buildInformationWork(),
      ],
    );
  }

  Widget buildInformation() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("ព័ត៌មានបផ្ទាល់ខ្លួន",style: GoogleFonts.moul(fontSize: 18)),

          const SizedBox(height: 20),
          _infoRow(title: "លេខសម្គាល់មន្ត្រី", value: "----"),
          const SizedBox(height: 10),
          _infoRow(title: "ឈ្មោះ", value: "Saky"),
          const SizedBox(height: 10),
          _infoRow(title: "ភេទ", value: "ប្រុស"),
          const SizedBox(height: 10),
          _infoRow(title: "ថ្ងៃខែឆ្នាំកំណើត", value: "01/01/1995"),
          const SizedBox(height: 10),
          _infoRow(title: "អ៊ីមែល", value: "ransaky@gmail.com"),
          const SizedBox(height: 10),
          _infoRow(title: "អាស័យដ្ឋាន", value: "ភ្នំពេញ"),
          const SizedBox(height: 10),
          _infoRow(title: "លេខទូរស័ព្ទ", value: "012 940 761"),
        ],
      ),
    );
  }
  Widget buildInformationWork() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("ព័ត៌មានការងារ",style: GoogleFonts.moul(fontSize: 18)),

          const SizedBox(height: 20),
          _infoRow(title: "ថ្ងៃចូលធ្វើការ", value: "01/01/2019"),
          const SizedBox(height: 10),
          _infoRow(title: "សាខា", value: "ក្រសួងសុខាភិបាល"),
          const SizedBox(height: 10),
          _infoRow(title: "នាយកដ្ឋាន", value: "មជ្ឈមណ្ឌលជាតិប្រយុទ្ធនឹងជំងឺគ្រុនចាញ់ ប៉ារ៉ាស៊ីតសាស្ត្រ និងបាណកសាស្ត្រ"),
          const SizedBox(height: 10),
          _infoRow(title: "មុខតំណែង", value: "មន្ត្រីរាជការ"),
          const SizedBox(height: 10),
          _infoRow(title: "អត្តលេខមន្ត្រី", value: "010203040506"),
          const SizedBox(height: 10),
          _infoRow(title: "តួនាទី", value: "មន្ត្រីព័ត៌មានវិទ្យា"),
          const SizedBox(height: 10),
          _infoRow(title: "លេខទូរស័ព្ទ", value: "012 940 761"),
        ],
      ),
    );
  }

  Widget _infoRow({required String title, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            title,
            style: GoogleFonts.battambang(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.battambang(fontSize: 17),
          ),
        ),
      ],
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
            Text(
              "ចាកចេញ",
              style: GoogleFonts.battambang(fontSize: 21, color: Colors.blue),
            ),
          ],
        ),
      ),
      title: Text("ព័ត៌មានលម្អិត", style: GoogleFonts.moul(fontSize: 23)),
    );
  }
}
