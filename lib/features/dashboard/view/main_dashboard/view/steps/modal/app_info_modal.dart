import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInfoModal extends StatefulWidget {
  const AppInfoModal({super.key});

  @override
  State<AppInfoModal> createState() => _AppInfoModalState();
}

class _AppInfoModalState extends State<AppInfoModal> {
  String _appVersion = "1.0.0";

  Future<void> _getAppVersion()async{
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = "${info.version} (${info.buildNumber})";
    });
  }

  @override
  void dispose() {
    super.dispose();
    _getAppVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(28)
              ),
            ),
            const SizedBox(height: 24,),
            const Text(
              "Moodora",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Text(
              "Version $_appVersion",
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Moodora your personal assistant for mood tracking, habit formation, and mental health care.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.black54, height: 1.4),
              ),
            ),
            const SizedBox(height: 32),

            _buildInfoRow(Icons.privacy_tip, "Privacy policy"),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.description, "User agreement"),
            const SizedBox(height: 12),
            _buildInfoRow(
                Icons.code,
                "Developer's GitHub",
                onTap: () async{
                  final Uri url = Uri.parse('https://github.com/timurkabitss-beep');
                  if (await canLaunchUrl(url)){
                    await launchUrl(url);
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Couldn't open the link"))
                    );
                  }
                }
            ),

            const SizedBox(height: 32),

            Text(
              "© 2026 Moodora. All rights reserved.",
              style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
            ),
          ],
        )
    );
  }
  Widget _buildInfoRow(IconData icon, String title, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey.shade600, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}

