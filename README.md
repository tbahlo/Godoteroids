# chargeroids
Ein Asteroids-Clon mit geladenen Asteroiden und simplen Vektorgrafiken.

# Kurzbeschreibung
Chargeroids ist zunächst einmal ein Asteroids[1]-Clone in recht rudimentärer/primitiver Vektorgrafikoptik. Ein steuerbares Raumschiff (mehr oder weniger pfeilförmig) lässt sich auf der Spielfläche mit zyklischen Randbedingungen (links raus => rechts rein) steuern. Das Schiff kann sich lediglich drehen und vorwärtsschub produzieren. Um zu bremsen muss eine 180° Drehung vollführt werden und der Vorwärtsschub als Bremse benutzt werden. Außerdem kann das Raumschiff in vorwärtsrichtung mit eingeschränkter Reichweite und Feuerrate schießen.

Zusätzlich erscheinen an zufälligen Positionen mit zufälliger Startgeschwindigkeit "chargeroids". Chargeroids sind Asteroiden, die bei Beschuss unter Berücksichtigung von Impulserhaltung in eine zufällige Anzahl von Fragmenten zerbricht, die wiederum zerstörbar sind. Wird eine kritische Minimalmasse unterschritten gelten chargeroids als zerstört. Bei Kontakt des Raumschiffs mit einem chargeroid verliert der Spieler ein Leben und das Raumschiff wird in der Mitte der Spielfläche temporär unzerstörbar wiederhergestellt.

Das Zusatzfeature im Vergleich zum Original ist, dass die Asteroiden "geladen" (charged) sind. Das heißt, dass sie sich gegenseitig abstoßen und dadurch abhängig von ihrer Verteilung auf der Spielfläche ihre Richtung ändern und beschleunigte Bewegungen ausführen. Die Ladung der Chargeroids wird in sinnvollen Größenordnungen zufällig verteilt und kann anhand der Füllfarbe der Chargeroids abgeschätzt werden. Dies sorgt für eine recht große Dynamik auf dem Spielfeld.

Sind alle chargeroids auf dem Spielfeld eliminiert wird der Schwierigkeitsgrad erhöht. Dies geschieht durch Erhöhung der Anzahl von chargeroids auf der Spielfläche, Erhöhung der maximalen Ladung (und damit der beschleunigenden Kräfte und Dynamik bei Zerstörung eines chargeroids) und durch die Einführung neuer Spezialtypen von chargeroids.

## Ideen für Spezialtypen:
* Pulseroid - schwach geladen; produziert zufällig (oder periodisch?) eine kurz anhaltende Ladungserhöhung, sodass er pulsierende Kraftstöße auf Umgebung produziert
* Attrakteroid - invers geladen; zieht normale chargeroids an, kollididert vermutlich und zerstört sich dadurch selbst - zersplittert explosionsartig und emittiert Fragmente mit hoher Geschwindigkeit
* Emitteroid - instabiler chargeroid, der zufällig Fragmente emittiert
* Overchargeroid - überladener chargeroid, der Durchschläge (Blitze) produziert, die Chargeroids in kurzer Distanz zerstören können
* Clusteroids - chargeroid mit merkwürdigem Anziehungspotential, dass ein Optimum in kurzer Distanz besitzt - dadurch "fangen" sie sich gegenseitig in bestimmter Distanz und bilden zusammenhängende Cluster-/Gitterstrukturen und bewegen sich als Kollektiv (sieht bestimmt lustig aus, wenn ein Knotenpunkt zerstört wird) 

Bei der Zerstörung von chargeroids besteht eine geringe Chance, dass einsammelbare Powerups erscheinen, die die Funktionalität des Raumschiffs dauerhaft/temporär erweitern.

## Ideen für Powerups:
* Feuerratenerhöhung
* Mehrfachschuss in verschiedene Richtungen
* temporäres, aktivierbares (wiederaufladbares?) Schild, das vor Zerstörung schützt. Raumschiff kann dadurch als Projektil verwendet werden.
* temporäres, aktivierbares (wiederaufladbares?) Schild, das eine hohe Ladung produziert und dadurch alle chargeroids in der Umgebung abstößt
* zusätzliches Leben

[1] Wikipedia-Seite zu "Asteroids": https://en.wikipedia.org/wiki/Asteroids_%28video_game%29


technische Details
------------------
* Game Engine Godot 4
* Versionskontrolle über git - wünschenswert wäre ein gitlab-server als remote rep - ansonsten geht auch github - dann ist der quelltext aber automatisch public
* auf Kollisionskontrolle sollte viel Wert gelegt werden. Ziel ist (in späteren Versionen) bei tatsächlicher Kollision Impulserhaltung zu gewährleisten. Hitbox-Test mit boolscher Antwort ist als allererste Version ok, sollte aber durch ambitioniertere Version ersetzt werden. Am besten die einzelnen Objekte als konkave Einzelobjekte darstellen und nach dem "Prinzip der überlappenden Achsen" [2] prüfen   

[2] Tutorial zur Kollissionskontrolle beim Indi-Game "N - Ninja": http://www.metanetsoftware.com/technique/tutorialA.html


featureliste "version 0.1" (minimal viable product)
------------------------
* darstellbare Spielfläche mit Möglichkeit Punkte, Kreise, Kreisbögen, Kreissegmente, Geraden zu zeichnen
* steuerbares, simpel dargestelltes, bewegliches Raumschiff auf Spielfläche (nach links rotieren, nach rechts rotieren, vorwärtsschub geben)
* Projektile erstellen (einstellbare Feuerrate, begrenzte Lebensdauer)
* min. 1 simpel dargestellter, zerstörbarer, geladener chargeroid, der bei Beschuss in 2 Fragmente zerfällt, die ebenfalls geladen interagieren und ein weiteres Mal zerfallen können.
* Kollisionskontrolle über grobe Hitbox mit ja/nein Antwort


featureliste "version 0.5" (ziellos spielbar)
---------------------------------------------
* kein Menü - Spiel startet direkt
* 3 Leben - Raumschiff kann zerstört werden
* Level 1 = 1 chargeroid, Level 2 = 2 chargeroids ...
* Punktestandsanzeige
* kein Sound


featureliste "version 1.0" (sinnvoll spielbar - "prinzipiell fertiges Spiel")
-----------------------------------------------------------------------------
* Menü mit Titel, "Spiel starten", "Highscores", "Credits", "Spiel beenden"
* Highscoreliste speichern und anzeigen lassen
* Effektsounds
* Kollisionskontrolle über physikalisch motiviertes Feedback - Schüsse übertragen Impuls auf chargeroid/-fragmente
* Levelnummer = Anzahl Chargeroids


featureliste "version 2.0" (voll spielbar + sonderfeatures)
-----------------------------------------------------------
ich halte gescheite Features für sinnvoller und besser umsetzbar als abgedrehte Grafik mit Partikeleffekten usw.
* min. 3 neue chargeroidklassen aus folgender Liste implementieren: Pulseroid, Attrakteroid, Emitteroid, Overchargeroid, Clusteroids
* nach 3 erfolgreichen Levels jeweils eine neue Klasse einführen:
  Level 4: 1 chargeroids + 1 spezialklasse A
  Level 5: 2 chargeroids + 1 spezialklasse A
  Level 6: 3 chargeroids + 1 spezialklasse A
  Level 7: 1 chargeroids + 1 spezialklasse A + 1 spezialklasse B
  Level 8: 2 chargeroids + 1 spezialklasse A + 1 spezialklasse B
  Level 9: 3 chargeroids + 1 spezialklasse A + 1 spezialklasse B
* min 3 Powerups aus folgender (nach Priorität geordneten) Liste implementieren: +1-Up; +Feuerrate; +Mehrfachschuss; +Schutzschild; +Ladungsschild
* zusätzliche Hintergrundmusik (vl. selbst eingespielter Gitarrenriff, oder Keyboardsong? :D)

featureliste "version 3.0" (mit vollen features spielbar und grafisch überarbeitet)
----------------------------------------------------------------------------------
* Intro beim Starten des Programms
* Einführungsanimation beim Starten eines neuen Spiels
* alle chargeroidklassen implementieren und in Levels einbauen
* alle Powerups implementieren und in Levels einbauen
* Grafik überarbeiten: 
  Explosionen bei Zerstörung von Objekten
  Partikeleffekte bei Fragmentierung und Zerstörung
  pulsierende Glow-Effekte proportional zur Ladung der Objekte
  Erscheinungsbild des Raumschiffs abhängig von Powerups
  unaufdringliches Hintergrundbild, ggf animiert

featureliste "version 4.0" ("chargeroidHD")
----------------------------------------------------------------------------------
Der Status bis zu dem dieses Spiel nie kommen wird.
* komplette Vektorgrafik ersetzt durch texturierte 3D-Grafiken (das Spiel bleibt 2D)
* räumlich anmutendes Hintergrundbild mit vorbeifliegenden Asteroiden
* Explosionen, Projektile usw. beleuchten Umgebung korrekt
* Weltherrschaft an mich reissen.

