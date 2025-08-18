# Wie kann ich das Modell öffnen?
Öffnen Sie Matlab R2024a oder neuer und öffnen Sie den root Ordner dieses Projektes. Führen Sie die Datei `start.m` aus. Anschließend sollte sich Simulink in der Modellansicht öffnen.

# Wie kann ich mir Simulationsergebnisse anzeigen lassen?
Führen Sie `Run` mit einer Stop Time von `inf` in Simulink aus. Das Modell wird die Simulation automatisch stoppen. Diverse Simulationsgrößen können im Data Inspector angezeigt werden. Dafür klicken Sie bitte auf eines der Zahlreichen "WiFi Symbole" über den Linien. Das Modell verzichtet vollständig auf Scope oder Display Blöcke, da die Visualisierung im Data Inspector deutlich mehr Möglichkeiten bietet.

# Hilfsscripte
Der Ordner `helper` beinhaltet Hilfsscripte, die z.B. Die Rohe Höhe der extrahierten GPS Daten visualisiert. Diese scripte können einfach ausgeführt werden (Auch aus dem root Ordner dieses Projektes)

# Parameterstudie
Der Ordner `parameterstudie` beinhaltet Zahlreiche Varianten des init scripts, mit angepassten Parametern. Wenn man die Datei `parameterstudie.m` im root Ordner ausführt, wird das Modell geöffnet und simuliert voll automatisiert alle varianten an init scripten aus dem `parameterstudie` Ordner. Anschließend werden die SOC Ergebnisse für jede Parametervariation in eine Excel Datei geschrieben und prozentual mit der Original init.m Verglichen.
