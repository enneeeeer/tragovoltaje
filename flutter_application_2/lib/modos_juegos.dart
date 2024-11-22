import 'package:flutter/material.dart';
import 'modo_basico_page.dart'; 
import 'modo_aventura_page.dart'; 
import 'modo_confesiones_page.dart'; 
import 'modo_desafio_page.dart'; 
import 'modo_extremo_page.dart'; 
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ModosJuego extends StatefulWidget {
  const ModosJuego({super.key});
  @override
  State<ModosJuego> createState() => _ModosJuego();
}

class _ModosJuego extends State<ModosJuego>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'EMPIEZA A JUGAR',
              style: TextStyle(
                fontSize: 32,
                color: Colors.lightBlue,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.blueAccent,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Selecciona modo de juego:',
              style: TextStyle(fontSize: 18, color: Colors.lightBlue),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  GameModeCard(text: 'Modo básico', image: 'assets/images/green.jpg'),
                  GameModeCard(text: 'Modo aventura', image: 'assets/images/azul.jpeg'),
                  GameModeCard(text: 'Modo desafío', image: 'assets/images/anaranjado.jpg'),
                  GameModeCard(text: 'Modo confesiones', image: 'assets/images/rojo.jpg'),
                  GameModeCard(text: 'Modo Extremo', image: 'assets/images/negro.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameModeCard extends StatefulWidget {
  final String text;
  final String image;
  GameModeCard({required this.text, required this.image});
  @override
  State<GameModeCard> createState() => _GameModeCard(text: text, image: image);
}

class _GameModeCard extends State<GameModeCard> {
  _GameModeCard({required this.text, required this.image});
  final String text;
  final String image;

  InterstitialAd? _interstitialAd;
  bool _isLoadedInterstitial = false;
  final adUnitId = 'ca-app-pub-3940256099942544/1033173712';

  @override
  void initState() {
    super.initState();
    loadAd(); // Cargar el anuncio cuando se inicializa el widget
  }

  /// Loads an interstitial ad.
  void loadAd() {
    InterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            _interstitialAd = ad;
            setState(() {
              _isLoadedInterstitial = true;
            });
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdFailedToShowFullScreenContent: (ad, error) {
                ad.dispose();
                setState(() {
                  _isLoadedInterstitial = false;
                });
                loadAd();
              },
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
                setState(() {
                  _isLoadedInterstitial = false;
                });
                loadAd();
              }
            );
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          // Navegar a la nueva página de Ruleta
          if (text == 'Modo básico') {  
            if (_isLoadedInterstitial) {
              _interstitialAd!.show();
            }
            Navigator.push(context, MaterialPageRoute(builder: (context) => ModoBasicoPage()));  
          } else if (text == 'Modo aventura') {  
            if (_isLoadedInterstitial) {
              _interstitialAd!.show();
            }
            Navigator.push(context, MaterialPageRoute(builder: (context) => ModoAventuraPage()));  
          } else if (text == 'Modo desafío') {  
            if (_isLoadedInterstitial) {
              _interstitialAd!.show();
            }
            Navigator.push(context, MaterialPageRoute(builder: (context) => ModoDesafioPage()));  
          } else if (text == 'Modo confesiones') {  
            if (_isLoadedInterstitial) {
              _interstitialAd!.show();
            }
            Navigator.push(context, MaterialPageRoute(builder: (context) => ModoConfesionesPage()));  
          } else if (text == 'Modo Extremo') {  
            if (_isLoadedInterstitial) {
              _interstitialAd!.show();
            }
            Navigator.push(context, MaterialPageRoute(builder: (context) => ModoExtremoPage()));  
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
              ),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}