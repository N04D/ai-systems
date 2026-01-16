# Architecture

## Project Name (Working Title)
**Cognitive Archive / Local Memory System**

---

## Purpose
This system is not an “AI assistant”.

It is a **local cognitive archive** designed to:

- transform conversations into structured knowledge  
- make prior failures and outcomes retrievable  
- enforce comparison with historical context  
- provide context without making decisions  
- perform autonomous processing according to explicit rules  

The system does not think.  
It records, structures, and confronts.

---

## Core Principles

1. **Chat Is UI, Not Memory**  
   Chats are never consulted as a knowledge source.  
   They are input only.

2. **The LLM Is Stateless**  
   The language model retains no memory and performs no learning.  
   All persistence exists exclusively in data structures and storage layers.

3. **Sources Are Authoritative**  
   Every output must be traceable to at least one explicit source:
   - database record  
   - stored query  
   - document  
   - prior recorded decision  

4. **Layered Memory Model**
   - **Working Memory**: RAM-based, fast, volatile  
   - **Warm Memory**: SSD-based, structured, queryable  
   - **Cold Memory**: NAS-based, archival, immutable  

5. **No Moral Judgment**  
   The system never states what is “good” or “bad”.  
   It only presents historical facts and outcomes:  
   *“This occurred under these conditions.”*

6. **No Autonomous Normative Learning**  
   The system must never form or adapt:
   - norms  
   - values  
   - moral judgments  
   - goals  

   It must not decide what is “better”, “right”, or “desirable”.

7. **Autonomous Technical Problem Solving**  
   The system is allowed to autonomously attempt to resolve **technical failures**.

   This includes creative variation in:
   - methods  
   - parameters  
   - execution strategies  

   Provided that:
   - the original goal remains unchanged  
   - all attempts are logged  
   - changes are explicit and reversible  
   - success criteria are not redefined  

8. **Bounded Execution and Escalation**  
   All autonomous technical remediation is strictly bounded by configuration.

   After a predefined number of failed attempts, the system must:
   - stop further action  
   - mark the task as failed  
   - notify the primary user immediately  

---

## System Overview

### Nodes

**RPi5 – Orchestrator**
- LLM runtime  
- tool routing (SQL, vector search, filesystem)  
- chat / API interface  
- privacy pre-processing  

**RPi5 – Work Memory Node**
- in-memory vector database  
- active context handling  
- confirmed lessons cache  
- structural similarity detection  

**Odroid XU4 – NAS / Cold Memory**
- raw chat logs  
- original documents  
- media files  
- hashes  
- immutable archival storage  

**(Future) RPi5 + Hailo**
- perception (audio / video)  
- identity and context classification  
- no access to memory layers  

---

## Data Flow (High-Level)

1. Input enters via chat or interface  
2. Full raw input is stored in cold memory  
3. Analysis and summarization are performed  
4. Metadata and structured records are stored in warm memory  
5. Embeddings are placed in working memory  
6. Chat context is discarded  

---

## Explicit Non-Goals

This system explicitly does **not**:

- perform autonomous normative learning  
- steer user behavior  
- retain cloud-dependent memory  
- maintain a personality or identity  
