import 'package:flutter/material.dart';
import 'package:news_app/modules/layouts/custom_Bg_widget.dart';
import 'package:news_app/providers/local_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  static const String routeName = "Settings";

  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final List<String> _languages = ['English', 'Spanish', 'French', 'Arabic'];
  final Map<String, String> _languageCodes = {
    'English': 'en',
    'Spanish': 'es',
    'French': 'fr',
    'Arabic': 'ar'
  };

  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();

    final locale = context.read<LocaleProvider>().locale;
    _selectedLanguage = _languages.firstWhere(
      (lang) => _languageCodes[lang] == locale.languageCode,
      orElse: () => 'English',
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CustomBgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.settings),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.language,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * .02),
              Center(
                child: Container(
                  height: size.height * .06,
                  width: size.width * .8,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 5,
                          offset: Offset(0, 5)),
                      BoxShadow(
                          color: Colors.white,
                          blurRadius: 5,
                          offset: Offset(0, 5))
                    ],
                  ),
                  child: DropdownButton(
                    padding: const EdgeInsets.only(left: 12, top: 10, right: 4),
                    isExpanded: true,
                    value: _selectedLanguage,
                    icon: const Icon(Icons.arrow_drop_down),
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedLanguage = newValue!;
                        String localeCode = _languageCodes[_selectedLanguage]!;
                        context
                            .read<LocaleProvider>()
                            .changeLocal(localeCode); // Update the locale
                      });
                    },
                    items: _languages
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
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
