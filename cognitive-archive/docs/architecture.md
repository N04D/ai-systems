# Architecture

## Projectnaam (werk)
**Cognitive Archive / Local Memory System**

## Doel
Dit systeem is geen “AI assistant”.  
Het is een **lokaal cognitief archief** dat:

- gesprekken omzet in gestructureerde kennis  
- eerdere fouten en oplossingen terugvindbaar maakt  
- vergelijking met het verleden afdwingt  
- geen beslissingen neemt, maar context levert 
- autonome verwerking volgens expliciete regels. 

Het systeem denkt niet.  
Het onthoudt, ordent en confronteert.

---

## Kernprincipes

1. **Chat is UI, geen geheugen**  
   Chats worden nooit geraadpleegd als kennisbron. Ze zijn uitsluitend input.

2. **LLM is stateless**  
   Het taalmodel leert niets en onthoudt niets. Alle “leren” zit in data en structuur.

3. **Bronnen zijn leidend**  
   Elk antwoord moet herleidbaar zijn naar:
   - database  
   - query  
   - document  
   - eerdere beslissing  

4. **Gelaagd geheugen**
   - Werkgeheugen (RAM, snel, vluchtig)  
   - Warm geheugen (SSD, gestructureerd)  
   - Koud geheugen (NAS, archief)  

5. **Geen moreel oordeel**  
   Het systeem zegt nooit “dit is goed/fout”.  
   Het zegt alleen: *“dit gebeurde toen”*.

---

## Architectuuroverzicht

### Nodes

**RPi5 – Orchestrator**
- LLM runtime  
- tool-router (SQL, vector search)  
- chat / API interface  
- privacy pre-processor  

**RPi5 – Work Memory**
- in-memory vector database  
- actieve context  
- lessons-learned cache  
- patroonherkenning  

**Odroid XU4 – NAS / Cold Memory**
- ruwe chat logs  
- originele documenten  
- media  
- hashes  
- immutable archief  

**(Toekomst) RPi5 + Hailo**
- waarneming (audio/video)  
- identity/context classificatie  
- geen toegang tot geheugen  

---

## Dataflow (hoog niveau)

1. Chat / input komt binnen  
2. Volledige ruwe log → cold memory  
3. Analyse & samenvatting  
4. Metadata + structuur → warm memory  
5. Embeddings → work memory  
6. Chat verdwijnt uit actieve context  

---

## Wat dit systeem expliciet niet doet

- Geen autonoom normatief leren. 
- Geen gedragssturing 
- Geen cloud-afhankelijk geheugen  


# Definitions

## 1. Definitie: Geheugen
Geheugen is **gestructureerde, herleidbare informatie** die:

- reproduceerbaar is  
- vergeleken kan worden  
- onafhankelijk is van taalvorm  

Een chat is **geen geheugen**.

---

## 2. Definitie: Leren
Leren betekent hier **niet**:

- modeltraining  
- gewicht-aanpassing  
- emergent gedrag  

Leren betekent:

- vastleggen van eerdere context  
- expliciet markeren van fouten  
- terugvindbaar maken van oplossingen  
- vergelijking afdwingen bij herhaling  

---

## 3. Definitie: Fout
Een fout is:

- een aanpak die niet het gewenste resultaat opleverde  
- ongeacht intentie  
- ongeacht rechtvaardiging  

Fouten worden vastgelegd zonder oordeel.

---

## 4. Definitie: Les
Een les is **geen conclusie van het systeem**.

Een les is:

- een door de gebruiker erkend verband tussen:  
  - context  
  - aanpak  
  - gevolg  

Het systeem mag lessen **tonen**, niet formuleren.

---

## 5. Definitie: Bron
Een bron is één van:

- database-record  
- document  
- query-resultaat  
- eerdere beslissing  

Uitspraken zonder bron zijn ongeldig.

---

## 6. Definitie: Telling (religieuze teksten)
Een telling is alleen geldig als:

- de dataset expliciet is vastgelegd  
- de definitie van “woord” is vastgelegd  
- de query reproduceerbaar is  

Voorbeeld:

> “Woord X komt N keer voor in de Koran”

is alleen toegestaan als:

- bron = specifieke Koranversie  
- normalisatie vastligt  
- query is opgeslagen  

---

## 7. Definitie: Moraliseren
Het systeem moraliseert **niet actief**.

Morele confrontatie ontstaat alleen door:

- vergelijking met precedent  
- tonen van gevolgen  
- tonen van tekstuele parallellen (bijv. hadith)  

Zonder interpretatie.

 
