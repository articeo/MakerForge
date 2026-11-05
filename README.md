# MakerForge

Un'unica app per Windows per **incisione e taglio laser**, **fresatura CNC** e **stampa 3D**.

**[⬇️ Scarica MakerForge per Windows](../../releases/latest/download/MakerForge-Setup-Windows.exe)**: versione completa, con OrcaSlicer, circa 213 MB.

[Versione leggera senza OrcaSlicer](../../releases/latest/download/MakerForge-Setup-Windows-Lite.exe) (circa 81 MB) · [Tutte le versioni](../../releases)

Dalla 0.4.0 l'app **si aggiorna da sola** e c'è anche l'interfaccia in **inglese** (Impostazioni → Lingua).

## Cosa fa

**🔦 Laser (laser a diodo con GRBL)**
- Apre SVG, DXF e immagini, con più oggetti nello stesso lavoro.
- **Livelli per colore**, ognuno con le sue impostazioni:
  - modalità: linea, riempimento, riempimento concentrico, immagine;
  - potenza, velocità e passate.
- **Contornatura**: ritaglia il pezzo attorno al disegno inciso.
  - Forma: segue il disegno, rettangolo o cerchio.
  - Opzioni: ponticelli, kerf, attacco.
- **Ordine di taglio**: prima le forme interne, poi quelle esterne.
- **Testo** con i font di Windows e **matrici** di copie.
- **Immagini**: dithering avanzati (Floyd, Jarvis, Stucki, Atkinson, Bayer, retino).
- **Origine del lavoro**: assoluta, dall'origine utente o dalla posizione attuale della testa.
- **Simulazione** del lavoro e **griglia di prova** per trovare le impostazioni di ogni materiale.

- Annulla/ripeti, nesting automatico e posizionamento con webcam calibrata.

**🔧 CNC (GRBL)**
- CAM integrato da SVG/DXF: profilo, tasca, foratura, incisione, V-carve.
- Più utensili nello stesso lavoro, con pausa per il cambio, sonda Z e simulazione 3D del materiale asportato.
- Invio di qualsiasi G-code alla macchina, con anteprima.

**🖨️ Stampa 3D**
- **OrcaSlicer 2.4.2 incluso**: non serve installarlo a parte.
- Vista 3D del piatto e dei modelli STL/3MF/OBJ, con i profili di stampanti e filamenti di OrcaSlicer.
- Slicing dentro l'app, con anteprima strato per strato.
- Invio a OctoPrint e Klipper (Moonraker) e monitoraggio della stampa: avanzamento, temperature, webcam.

**🎮 Controllo macchina**
- Connessione USB, jog, homing, zero, console.
- Pausa, ripresa e stop sicuro.
- Regolazione di velocità e potenza durante il lavoro.

## Installazione

1. Scarica `MakerForge-Setup-Windows.exe`, o la versione Lite, con i link qui sopra.
2. Avvialo. L'installer **non è firmato digitalmente**, quindi Windows mostrerà "Windows ha protetto il PC". Clicca su **Ulteriori informazioni**, poi su **Esegui comunque**.
3. Collega la macchina via USB e premi **Connetti**. Se la porta non compare, installa il driver della scheda: di solito CH340 o CP210x.

**Requisiti:** Windows 10 o 11 a 64 bit.

### ⚠️ Smart App Control (Windows 11)
Se sul PC è attivo **Smart App Control**, Windows può bloccare i componenti di OrcaSlicer, che non sono firmati digitalmente. In quel caso lo slicing 3D non parte e l'app mostra un messaggio che lo spiega. Laser e CNC funzionano comunque.

## Sicurezza

- Indossa sempre **occhiali di protezione** adatti alla lunghezza d'onda del tuo laser.
- Non lasciare mai la macchina incustodita mentre lavora.
- Fai la **prima prova a bassa potenza** su un materiale di scarto, usando la *Griglia di prova materiale*.
- I valori dei materiali sono indicativi.

MakerForge è un progetto amatoriale, fornito **così com'è, senza garanzie**. Usalo a tuo rischio.

## Componenti di terze parti

- **OrcaSlicer 2.4.2**: licenza GNU AGPL v3, incluso senza modifiche.
  - Il sorgente è su https://github.com/OrcaSlicer/OrcaSlicer/tree/v2.4.2.
  - La licenza si trova nella cartella di installazione, in `resources/OrcaSlicer`.
- **Electron**: MIT.
- **three.js**: MIT.
- **opentype.js**: MIT.
- **Clipper (clipper-lib)**: Boost Software License.
