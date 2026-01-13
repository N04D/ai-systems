# Project – Lokale AI Werk- en Systeemomgeving

## Doel
Dit project is een **lokale, volledig controleerbare werkomgeving** waarin AI wordt gebruikt als uitvoerende en analyserende assistent binnen de terminal.  
Alle data, context, beslissingen en voortgang worden **lokaal opgeslagen** en beheerd via bestanden en git.

AI is hier geen gesprekspartner, maar een **hulpmiddel binnen een gestructureerd systeem**.

---

## Kernprincipes

1. **Alles is lokaal**
   - Geen afhankelijkheid van browserchats
   - Geen externe opslag van context
   - Alle relevante informatie leeft in bestanden in deze map

2. **Files zijn waarheid**
   - Context, beslissingen en voortgang staan in markdown-bestanden
   - Wat niet in files staat, bestaat niet
   - Er wordt niets “onthouden” buiten dit project

3. **AI is vervangbaar**
   - Gemini, Claude, andere modellen of lokale LLM’s zijn uitwisselbaar
   - Het systeem is niet afhankelijk van één leverancier
   - De structuur blijft gelijk, ongeacht de AI

4. **Sessies zijn eindig**
   - Werk gebeurt in afgebakende sessies
   - Elke sessie wordt expliciet afgesloten
   - Afgesloten sessies worden samengevat en gearchiveerd

5. **Beslissingen worden vastgelegd**
   - Definitieve keuzes worden genoteerd in `decisions.md`
   - Geen herhaling van oude discussies zonder reden
   - Git commit history geldt als historisch logboek

---

## Structuur van het project

- `context.md`  
  Permanent collectief geheugen en werkwijze van dit project

- `session.md`  
  Actieve werksessie (tijdelijk)

- `decisions.md`  
  Vastgelegde besluiten

- `sessions/`  
  Archief van afgeronde sessies met datum

- `scripts/`  
  Instructies en hulpmiddelen voor vaste handelingen (zoals sessie-afsluiting)

---

## Werkwijze

1. Start een sessie door:
   - `context.md` te lezen
   - het doel van de sessie te formuleren in `session.md`

2. Werk uitsluitend binnen deze projectmap

3. Gebruik AI om:
   - plannen te maken
   - taken uit te voeren
   - bestanden bij te werken
   - samen te vatten

4. Sluit elke sessie af:
   - samenvatting maken
   - context en beslissingen bijwerken indien nodig
   - sessie archiveren in `sessions/`
   - wijzigingen committen in git

---

## Wat dit project niet is

- Geen chat-archief
- Geen experimentele speeltuin zonder structuur
- Geen productie-omgeving
- Geen onbeperkt autonoom AI-systeem

Alles gebeurt **bewust, afgebakend en controleerbaar**.

---

## Einddoel

Een stabiele, rustige en overdraagbare manier van werken waarin:
- cognitieve belasting wordt verlaagd
- voortgang zichtbaar is
- context behouden blijft
- structuur sterker is dan motivatie

Dit systeem dient de gebruiker. Niet andersom.
