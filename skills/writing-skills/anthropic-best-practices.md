# Skill authoring best practices

> Anthropic's official published guidance on writing Skills, included here for reference.
>
> This document is kept so you can see the shape of Anthropic's recommended approach and understand where austinpowers deliberately differs. Where this guidance and austinpowers' SKILL.md conflict, follow SKILL.md — our approach has been tuned through behavioral testing rather than pure authoring theory.

Good Skills are concise, well-structured, and tested with real usage. This guide provides practical authoring decisions to help you write Skills that models can discover and use effectively.

## Core principles

### Concise is key

The [context window](https://platform.claude.com/docs/en/build-with-claude/context-windows) is a public good. Your Skill shares the context window with everything else Claude needs to know, including:

* The system prompt
* Conversation history
* Other Skills' metadata
* Your actual request

Not every token in your Skill has an immediate cost. At startup, only the metadata (name and description) from all Skills is pre-loaded. Claude reads SKILL.md only when the Skill becomes relevant, and reads additional files only as needed. However, being concise in SKILL.md still matters: once Claude loads it, every token competes with conversation history and other context.

**Default assumption**: Claude is already very smart

Only add context Claude doesn't already have. Challenge each piece of information:

* "Does Claude really need this explanation?"
* "Can I assume Claude knows this?"
* "Does this paragraph justify its token cost?"

**Good example: Concise** (approximately 50 tokens):

````markdown
## Extract PDF text

Use pdfplumber for text extraction:

```python
import pdfplumber

with pdfplumber.open("file.pdf") as pdf:
    text = pdf.pages[0].extract_text()
```
````

**Bad example: Too verbose** (approximately 150 tokens):

```markdown
## Extract PDF text

PDF (Portable Document Format) files are a common file format that contains
text, images, and other content. To extract text from a PDF, you'll need to
use a library. There are many libraries available for PDF processing, but we
recommend pdfplumber because it's easy to use and handles most cases well.
First, you'll need to install it using pip. Then you can use the code below...
```

The concise version assumes Claude knows what PDFs are and how libraries work.

### Set appropriate degrees of freedom

Match the level of specificity to the task's fragility and variability.

**High freedom** (text-based instructions):

Use when:

* Multiple approaches are valid
* Decisions depend on context
* Heuristics guide the approach

**Medium freedom** (pseudocode or scripts with parameters):

Use when:

* A preferred pattern exists
* Some variation is acceptable
* Configuration affects behavior

**Low freedom** (specific scripts, few or no parameters):

Use when:

* Operations are fragile and error-prone
* Consistency is critical
* A specific sequence must be followed

**Analogy**: Think of Claude as a robot exploring a path:

* **Narrow bridge with cliffs on both sides**: There's only one safe way forward. Provide specific guardrails and exact instructions (low freedom). Example: database migrations that must run in exact sequence.
* **Open field with no hazards**: Many paths lead to success. Give general direction and trust Claude to find the best route (high freedom). Example: code reviews where context determines the best approach.

### Test with all models you plan to use

Skills act as additions to models, so effectiveness depends on the underlying model. Test your Skill with all the models you plan to use it with.

**Testing considerations by model**:

* **Claude Haiku** (fast, economical): Does the Skill provide enough guidance?
* **Claude Sonnet** (balanced): Is the Skill clear and efficient?
* **Claude Opus** (powerful reasoning): Does the Skill avoid over-explaining?

What works perfectly for Opus might need more detail for Haiku. If you plan to use your Skill across multiple models, aim for instructions that work well with all of them.

## Skill structure

The SKILL.md frontmatter requires two fields:

* `name` - Human-readable name of the Skill (64 characters maximum)
* `description` - One-line description of what the Skill does and when to use it (1024 characters maximum)

### Naming conventions

Use consistent naming patterns to make Skills easier to reference and discuss. We recommend using **gerund form** (verb + -ing) for Skill names, as this clearly describes the activity or capability the Skill provides.

**Good naming examples (gerund form)**:

* "Processing PDFs"
* "Analyzing spreadsheets"
* "Managing databases"
* "Testing code"
* "Writing documentation"

**Avoid**:

* Vague names: "Helper", "Utils", "Tools"
* Overly generic: "Documents", "Data", "Files"
* Inconsistent patterns within your skill collection

### Writing effective descriptions

The `description` field enables Skill discovery and should include both what the Skill does and when to use it.

**Always write in third person**. The description is injected into the system prompt, and inconsistent point-of-view can cause discovery problems.

* **Good:** "Processes Excel files and generates reports"
* **Avoid:** "I can help you process Excel files"
* **Avoid:** "You can use this to process Excel files"

**Be specific and include key terms**. Include both what the Skill does and specific triggers/contexts for when to use it.

Each Skill has exactly one description field. The description is critical for skill selection: Claude uses it to choose the right Skill from potentially 100+ available Skills.

Effective examples:

```yaml
description: Extract text and tables from PDF files, fill forms, merge documents. Use when working with PDF files or when the user mentions PDFs, forms, or document extraction.
```

```yaml
description: Analyze Excel spreadsheets, create pivot tables, generate charts. Use when analyzing Excel files, spreadsheets, tabular data, or .xlsx files.
```

Avoid vague descriptions like these:

```yaml
description: Helps with documents
```

### Progressive disclosure patterns

SKILL.md serves as an overview that points Claude to detailed materials as needed.

**Practical guidance:**

* Keep SKILL.md body under 500 lines for optimal performance
* Split content into separate files when approaching this limit
* Use the patterns below to organize instructions, code, and resources effectively

#### Pattern 1: High-level guide with references

```markdown
---
name: PDF Processing
description: Extracts text and tables from PDF files, fills forms, and merges documents.
---

# PDF Processing

## Quick start

Extract text with pdfplumber. See [FORMS.md](FORMS.md) for form filling.
```

#### Pattern 2: Domain-specific organization

For Skills with multiple domains, organize content by domain to avoid loading irrelevant context.

#### Pattern 3: Conditional details

Show basic content, link to advanced content when the user needs those features.

### Avoid deeply nested references

Claude may partially read files when they're referenced from other referenced files.

**Keep references one level deep from SKILL.md**. All reference files should link directly from SKILL.md.

**Bad example: Too deep**:

```markdown
# SKILL.md
See [advanced.md](advanced.md)...

# advanced.md
See [details.md](details.md)...

# details.md
Here's the actual information...
```

**Good example: One level deep**:

```markdown
# SKILL.md

**Basic usage**: [instructions in SKILL.md]
**Advanced features**: See [advanced.md](advanced.md)
**API reference**: See [reference.md](reference.md)
```

## Evaluation and iteration

### Build evaluations first

**Create evaluations BEFORE writing extensive documentation.** This ensures your Skill solves real problems rather than documenting imagined ones.

**Evaluation-driven development:**

1. **Identify gaps**: Run Claude on representative tasks without a Skill. Document specific failures or missing context
2. **Create evaluations**: Build three scenarios that test these gaps
3. **Establish baseline**: Measure Claude's performance without the Skill
4. **Write minimal instructions**: Create just enough content to address the gaps and pass evaluations
5. **Iterate**: Execute evaluations, compare against baseline, and refine

### Develop Skills iteratively with Claude

The most effective Skill development process involves Claude itself. Work with one instance of Claude ("Claude A") to create a Skill that will be used by other instances ("Claude B").

1. **Complete a task without a Skill**: Work through a problem with Claude A using normal prompting.
2. **Identify the reusable pattern**: After completing the task, identify what context you provided that would be useful for similar future tasks.
3. **Ask Claude A to create a Skill**: Capture the pattern as a properly structured SKILL.md.
4. **Review for conciseness**: Check that Claude A hasn't added unnecessary explanations.
5. **Test on similar tasks**: Use the Skill with Claude B (a fresh instance) on related use cases.
6. **Iterate based on observation**: If Claude B struggles, return to Claude A with specifics.

## Anti-patterns to avoid

### Avoid Windows-style paths

Always use forward slashes in file paths, even on Windows:

* Good: `scripts/helper.py`, `reference/guide.md`
* Avoid: `scripts\helper.py`, `reference\guide.md`

### Avoid offering too many options

Don't present multiple approaches unless necessary. Provide a default with an escape hatch.

## Checklist for effective Skills

Before sharing a Skill, verify:

* [ ] Description is specific and includes key terms
* [ ] Description includes both what the Skill does and when to use it
* [ ] SKILL.md body is under 500 lines
* [ ] Additional details are in separate files (if needed)
* [ ] No time-sensitive information (or in "old patterns" section)
* [ ] Consistent terminology throughout
* [ ] Examples are concrete, not abstract
* [ ] File references are one level deep
* [ ] Progressive disclosure used appropriately
* [ ] Workflows have clear steps
* [ ] At least three evaluations created
* [ ] Tested with real usage scenarios
