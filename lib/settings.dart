import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class ParametresPage extends StatefulWidget {
  @override
  _ParametresPageState createState() => _ParametresPageState();
}

class _ParametresPageState extends State<ParametresPage> {
  double _fontSize = 20.0; // Taille de police initiale

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Changer de mode',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Div pour le mode clair
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.light_mode, size: 24), // Icône pour le mode clair
                      SizedBox(width: 8), // Espacement entre l'icône et le texte
                      Text('Mode clair', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                Switch(
                  value: AdaptiveTheme.of(context).mode.isLight,
                  onChanged: (value) {
                    // Basculer vers le mode clair
                    AdaptiveTheme.of(context).setLight();
                  },
                ),
              ],
            ),
            SizedBox(height: 16), // Espacement entre les divs
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Div pour le mode sombre
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.dark_mode, size: 24), // Icône pour le mode sombre
                      SizedBox(width: 8), // Espacement entre l'icône et le texte
                      Text('Mode sombre', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                Switch(
                  value: AdaptiveTheme.of(context).mode.isDark,
                  onChanged: (value) {
                    // Basculer vers le mode sombre
                    AdaptiveTheme.of(context).setDark();
                  },
                ),
              ],
            ),
            SizedBox(height: 24), // Espacement entre les divs
            Text(
              'Affichage de la police',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Div pour le slider de taille de police
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.format_size, size: 24), // Icône pour le slider
                SizedBox(width: 8), // Espacement entre l'icône et le slider
                Expanded(
                  child: Slider(
                    value: _fontSize, // Valeur actuelle de la taille de la police
                    min: 10,
                    max: 40,
                    divisions: 30,
                    onChanged: (double value) {
                      setState(() {
                        _fontSize = value; // Mettre à jour la taille de la police
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 24), // Espacement entre les boutons
          ],
        ),
      ),
    );
  }
}
