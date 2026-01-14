# Project — Local AI Work and System Environment

## Purpose
This project is a **local, fully controllable working environment** in which AI is used as an executing and analytical assistant within the terminal.  
All data, context, decisions, and progress are stored and managed **locally** via files and git.

AI is not a conversational partner here, but a **tool within a structured system**.

---

## Core Principles

1. **Everything Is Local**
   - No dependency on browser chats
   - No external storage of context
   - All relevant information lives in files within this directory

2. **Files Are Truth**
   - Context, decisions, and progress are stored in markdown files
   - What is not written in files does not exist
   - Nothing is “remembered” outside this project

3. **AI Is Replaceable**
   - Gemini, Claude, other models, or local LLMs are interchangeable
   - The system does not depend on a single vendor
   - The structure remains the same regardless of the AI used

4. **Sessions Are Finite**
   - Work happens in clearly bounded sessions
   - Every session is explicitly closed
   - Closed sessions are summarized and archived

5. **Decisions Are Recorded**
   - Final decisions are documented in `decisions.md`
   - No repetition of past discussions without cause
   - Git commit history serves as the historical log

---

## Project Structure

- `context.md`  
  Permanent collective memory and working rules of this project

- `session.md`  
  Active working session (temporary)

- `decisions.md`  
  Recorded decisions

- `sessions/`  
  Archive of completed sessions, dated

- `scripts/`  
  Instructions and tools for recurring actions (such as session closing)

---

## Workflow

1. Start a session by:
   - reading `context.md`
   - defining the session goal in `session.md`

2. Work exclusively within this project directory

3. Use AI to:
   - create plans
   - execute tasks
   - update files
   - produce summaries

4. Close every session by:
   - writing a summary
   - updating context and decisions if needed
   - archiving the session in `sessions/`
   - committing changes to git

---

## What This Project Is Not

- Not a chat archive
- Not an unstructured experimental playground
- Not a production environment
- Not an unlimited autonomous AI system

Everything happens **deliberately, within boundaries, and under control**.

---

## End Goal

A stable, calm, and transferable way of working in which:
- cognitive load is reduced
- progress is visible
- context is preserved
- structure outweighs motivation

This system serves the user. Not the other way around.
