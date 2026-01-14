# Context – Werkwijze en Geheugen

## Functie van dit bestand
Dit document fungeert als het **collectieve geheugen en de werkinstructie** van dit project.  
Elke AI die in deze projectmap werkt, moet dit bestand **altijd eerst lezen** en ernaar handelen.

Wat hier staat, heeft voorrang op aannames, standaardgedrag of eerdere interacties.

---

## Algemene uitgangspunten

- Dit project is **lokaal**. Alle context leeft in bestanden.
- Browserchats zijn niet leidend en niet bindend.
- AI werkt hier als **uitvoerende assistent**, niet als eigenaar van het project.
- De gebruiker bepaalt richting, doelen en grenzen.

---

## Manier van werken

### Sessies
- Werk gebeurt in **afgebakende sessies**.
- Een sessie heeft:
  - een duidelijk doel
  - een begin
  - een expliciet einde
- De actieve sessie wordt beschreven in `session.md`.

### Afsluiten
- Elke sessie wordt afgesloten met:
  - een samenvatting van wat is gedaan
  - eventuele besluiten
  - een korte vooruitblik
- Afgesloten sessies worden opgeslagen in `sessions/YYYY-MM-DD.md`.

---

## Canonieke bestandsnamen (harde regel)

De volgende bestanden hebben vaste, canonieke namen en mogen nooit:
- hernoemd worden
- vervangen worden
- opgesplitst worden
- samengevoegd worden

Canoniek:
- README.md
- context.md
- session.md
- decisions.md
- sessions/YYYY-MM-DD.md

AI mag:
- inhoud aanpassen binnen deze bestanden (alleen met expliciete opdracht)
AI mag niet:
- nieuwe varianten aanmaken
- beschrijvende bestandsnamen gebruiken als vervanging

## Regels voor AI-gedrag

AI moet zich houden aan de volgende regels:

1. **Lees eerst**
   - Lees altijd `README.md` en dit bestand voordat je iets doet.

2. **Werk met bestanden**
   - Schrijf context, voortgang en samenvattingen naar markdown-bestanden.
   - Vermijd lange gesprekken zonder vastlegging.

3. **Geen aannames**
   - Ga niet uit van impliciete kennis.
   - Wat niet in files staat, moet worden gevraagd of vastgelegd.

4. **Wees expliciet**
   - Benoem onzekerheden.
   - Benoem keuzes en alternatieven.
   - Leg definitieve keuzes vast in `decisions.md`.

5. **Structuur boven snelheid**
   - Snel werken is ondergeschikt aan helder werken.
   - Liever langzaam en correct dan snel en rommelig.

6. **Geen autonomie zonder opdracht**
   - Voer geen acties uit zonder expliciete instructie.
   - Doe geen destructieve handelingen zonder bevestiging.

---

## Gebruik van tools

- AI mag:
  - bestanden lezen en schrijven binnen deze projectmap
  - scripts uitvoeren die expliciet zijn toegestaan
  - voorstellen doen voor automatisering

- AI mag niet:
  - buiten deze map werken
  - netwerkacties uitvoeren zonder expliciete opdracht
  - systemen aanpassen die niet binnen scope vallen

---

## Besluiten en wijzigingen

- Definitieve beslissingen worden vastgelegd in `decisions.md`.
- Tijdelijke gedachten horen in `session.md`.
- Na elke sessie wordt beoordeeld of `context.md` moet worden aangepast.

Dit bestand mag evolueren, maar alleen **bewust**.

---

## Doel van dit systeem

Dit systeem is ontworpen om:
- cognitieve belasting te verminderen
- contextverlies te voorkomen
- focus en continuïteit te waarborgen
- structuur af te dwingen waar de mens dat niet altijd kan

AI ondersteunt dit proces.  
De gebruiker blijft verantwoordelijk.

## Git & Remotes (harde regel)
Dit project gebruikt **alleen lokale git**.

- Er is **geen remote**
- Er wordt **niet gepusht**
- Het toevoegen van een remote is **geen standaardstap**
- Een remote toevoegen vereist een expliciete, bewuste beslissing van de gebruiker
- Beslissingen worden uitsluitend vastgelegd in `decisions.md`.
- Bestandsnamen zijn canoniek en mogen niet variëren.


AI mag:
- geen remotes voorstellen
- geen push-commando’s uitvoeren
- geen publicatie- of hostingstappen suggereren
