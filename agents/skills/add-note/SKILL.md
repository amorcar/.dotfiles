---
name: add-note
description: Create a note in the user's Obsidian vault at ~/.org/main/notes/personal/learning/. Use when the user asks to write a note, save a note, add a note, or document something as a note. When creating a note from a conversation, extract the theoretical knowledge or learnings that emerged during the conversation — not a transcript of what happened, but the underlying concept or insight. Use the actual problem or task from the conversation as a concrete example to illustrate the concept when useful.
---

This skill creates notes in the user's Obsidian vault. All notes are stored in `~/.org/main/notes/personal/learning/`.

**Important:**
- Use only readonly commands (ls, grep, cat, Glob, Grep, Read) when accessing existing notes — never modify or delete existing note content except to add backlinks to the newly created note.
- Do not ask for permission to read existing notes or to write the new note — just do it.
- After creating the new note, check if any existing notes in the vault cover related topics. If so, edit those notes to add a backlink (`[[new-note-alias]]`) in a relevant place within their content.

Follow these steps:

## 1. Determine note content

If the user has already provided content or context (e.g. from a conversation), extract the theoretical knowledge or learnings — not a play-by-play of the conversation. Otherwise, ask what the note should be about.

When the conversation involved fixing a bug or solving a problem, use that as a concrete example to illustrate the underlying concept, but the note itself should teach the concept.

## 2. Check existing notes for backlinks

Before writing the note, scan other notes in the vault (`~/.org/main/notes/`) for related topics that should be referenced. Use Glob and Grep to find notes whose titles or content relate to the new note's subject. Collect these so you can add Obsidian-style backlinks (`[[note-alias]]`) in the note content where relevant.

## 3. Generate the filename

Notes are always placed in `~/.org/main/notes/personal/learning/`.

Filenames follow the pattern: `YYYYmmddHHMMSS-name.md`

- Use the current timestamp (run `date +%Y%m%d%H%M%S`)
- The `name` part should be a short, lowercase, hyphenated slug (e.g. `repository-pattern`, `sqlmesh-incremental`)

## 4. Write the note with the correct header

Every note must start with this YAML frontmatter:

```markdown
---
id: <same as filename without .md>
aliases:
  - <underscore version of the name, e.g. repository_pattern>
tags:
  - <relevant tags>
---
```

Rules for the header:
- `id` must match the filename (without `.md`)
- `aliases` should include at least one underscore-separated version of the name
- `tags` should be relevant to the content; use empty `[]` if nothing fits

## 5. Write the note body

- Use clear markdown with headers, code blocks, and lists as appropriate
- When referencing concepts or topics that exist as other notes in the vault, use Obsidian backlinks: `[[alias-or-id]]`
- Prefer linking via alias (e.g. `[[pipeliner2]]`) over the full id
- Only backlink to notes that actually exist in the vault — verify with Glob/Grep before linking
- Include concrete examples, especially from the current codebase when relevant

## 6. Confirm

Tell the user the path of the created note.
