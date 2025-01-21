import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petai/view_models/language_controller.dart';
import 'package:petai/views/pages/account_settings_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'profile'.tr,
          style: const TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          _buildSettingsItem(
            'account_settings'.tr,
            'account_settings_subtitle'.tr,
            onTap: () {
              // Navigate to Account Settings page
              Get.to(() => const AccountSettingsPage());
            },
          ),
          _buildSettingsItem(
            'privacy_policy'.tr,
            null,
            onTap: () {/* Navigate to Privacy Policy */},
          ),
          _buildSettingsItem(
            'terms_of_service'.tr,
            null,
            onTap: () {/* Navigate to Terms of Service */},
          ),
          _buildSettingsItem(
            'data_policy'.tr,
            null,
            onTap: () {/* Navigate to Data Policy */},
          ),
          _buildSettingsItem(
            'language'.tr,
            null,
            onTap: () {
              // open a dialog to select language
              Get.defaultDialog(
                title: 'select_language'.tr,
                content: Column(
                  children: [
                    _buildLanguageItem('english'.tr, 'en'),
                    _buildLanguageItem('turkish'.tr, 'tr'),
                  ],
                ),
              );
            },
          ),
          _buildSettingsItem(
            'faqs'.tr,
            null,
            onTap: () {/* Navigate to Data Policy */},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(String title, String? subtitle,
      {required VoidCallback onTap}) {
    return ListTile(
      title: Text(
        title,
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            )
          : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildLanguageItem(String title, String locale) {
    return ListTile(
      title: Text(
        title,
      ),
      onTap: () {
        Get.find<LanguageController>().changeLanguage(locale);
        Get.back();
      },
    );
  }
}
