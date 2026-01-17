# ═══════════════════════════════════════════════════════════════════════════
# DOCUMENT: SYSTEM CALIBRATION MANUAL — MK-IV REDACTION TERMINAL
# CLASSIFICATION: OPERATIONAL / BOARD OF ETHICS APPROVED
# ORIGIN: The Redactors, Technical Division — Calibration Infrastructure Branch
# REVISION: 4.7.2 (Current Deployment Standard)
# ═══════════════════════════════════════════════════════════════════════════

```
██████████████████████████████████████████████████████████████████████████████
█                                                                            █
█   BOARD OF ETHICS CERTIFICATION                                            █
█                                                                            █
█   This manual describes approved procedures for the MK-IV Redaction        █
█   Terminal ("The Redaction Chamber"). All operators must complete          █
█   Ethics Module 7-C before system access is granted.                       █
█                                                                            █
█   Remember: We do not destroy memories. We archive them responsibly.       █
█   The subject's improvement is the purpose. The method is kindness.        █
█                                                                            █
██████████████████████████████████████████████████████████████████████████████
```

---

**MANUAL HEADER**

**DOCUMENT:** MK-IV Redaction Terminal — System Calibration Manual
**PREPARED BY:** Technical Division, Calibration Infrastructure Branch
**APPROVED BY:** Board of Ethics, Sub-Committee on Voluntary Improvement
**AUDIENCE:** Terminal Operators (Tier 4+), Maintenance Personnel, Self-Service Subjects
**PURPOSE:** Operational guidance for memory-exchange procedures

---

## PREAMBLE: THE PURPOSE OF THE CHAMBER

The Redaction Chamber exists to fulfill the Redactors' core promise: **that the past need not define the future.** Subjects who enter the Chamber carry memories that weigh upon them—regrets, traumas, inconvenient attachments, inefficient sentimentalities. They also carry Recall Tokens, representing memories they have already chosen to surrender.

The Chamber allows them to convert this *cognitive excess* into measurable improvement. The memories are archived (never destroyed—destruction would be unethical). The subject emerges lighter, stronger, more aligned with their potential.

**This is not a transaction. It is a transformation.**

The terminal interface is designed to facilitate this transformation with clinical precision and emotional appropriate distance. The aesthetic choices are deliberate: the Chamber should feel *institutional* but not hostile, *clinical* but not cold, *inevitable* but not coercive.

The subject must always feel they are choosing. Because they are.

---

# ═══════════════════════════════════════════════════════════════════════════
# SECTION I: TERMINAL HARDWARE SPECIFICATIONS
# ═══════════════════════════════════════════════════════════════════════════

## 1.1 PHYSICAL INSTALLATION

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                     REDACTION CHAMBER — PHYSICAL LAYOUT                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│    ┌─────────────────────────────────────────────────────────┐              │
│    │                                                         │              │
│    │                   CRT DISPLAY UNIT                      │              │
│    │                   (Primary Interface)                   │              │
│    │                                                         │              │
│    │              ┌─────────────────────────┐                │              │
│    │              │                         │                │              │
│    │              │     ACTIVE DISPLAY      │                │              │
│    │              │        AREA             │                │              │
│    │              │     (640 x 480)         │                │              │
│    │              │                         │                │              │
│    │              │    Phosphor Green       │                │              │
│    │              │    on Black             │                │              │
│    │              │                         │                │              │
│    │              └─────────────────────────┘                │              │
│    │                                                         │              │
│    │    [STATUS LED: READY]     [STATUS LED: PROCESSING]     │              │
│    │         ○ GREEN                  ○ AMBER                │              │
│    │                                                         │              │
│    └─────────────────────────────────────────────────────────┘              │
│                              │                                              │
│    ┌─────────────────────────┴─────────────────────────────┐                │
│    │                                                       │                │
│    │                 INPUT CONSOLE                         │                │
│    │                                                       │                │
│    │   [CONFIRM]    [CANCEL]    [SCROLL ▲]   [SCROLL ▼]    │                │
│    │                                                       │                │
│    │            ┌───────────────────────┐                  │                │
│    │            │    TOKEN INSERTION    │                  │                │
│    │            │        SLOT           │                  │                │
│    │            │    ═══════════════    │                  │                │
│    │            └───────────────────────┘                  │                │
│    │                                                       │                │
│    │        [EMERGENCY ABORT — PROTECTED]                  │                │
│    │                                                       │                │
│    └───────────────────────────────────────────────────────┘                │
│                                                                             │
│    ════════════════════════════════════════════════════════                 │
│                         SUBJECT STATION                                     │
│                    (Restraint Rails Optional)                               │
│    ════════════════════════════════════════════════════════                 │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 1.2 DISPLAY CHARACTERISTICS

```json
{
  "display_specifications": {
    "type": "Cathode Ray Tube (CRT) — Monochrome Phosphor",
    "resolution": "640 x 480 (Standard) / 320 x 240 (Degraded Mode)",
    "color_palette": {
      "primary_text": "#33FF33 (Phosphor Green)",
      "secondary_text": "#1A8C1A (Dim Green)",
      "background": "#0A0A0A (Deep Black)",
      "highlight": "#66FF66 (Bright Green)",
      "warning": "#FFAA00 (Amber)",
      "error": "#FF3333 (Red — Rare, Alarming)",
      "redaction_bars": "#000000 (True Black — No Phosphor)"
    },
    "visual_effects": {
      "scanlines": "Horizontal, 2px spacing, 15% opacity overlay",
      "screen_curvature": "Subtle barrel distortion at edges",
      "phosphor_glow": "Bloom effect on bright text, 3px radius",
      "flicker": "Subtle 60Hz variation, increases during processing",
      "burn_in": "Persistent ghost images of frequently-displayed elements"
    },
    "audio_characteristics": {
      "ambient": "Low electrical hum (50Hz), increases near processing",
      "keypress": "Mechanical click, slightly delayed feedback",
      "confirmation": "Two-tone chime (clinical, not pleasant)",
      "warning": "Rhythmic pulse, increasing tempo",
      "error": "Harsh buzz, single burst"
    }
  }
}
```

## 1.3 DESIGN PHILOSOPHY — THE CLINICAL AESTHETIC

The MK-IV Terminal's appearance is not accidental. Every element serves psychological purpose:

| Element | Purpose | Psychological Effect |
|---------|---------|---------------------|
| CRT Display | Institutional association | Feels "official," like medical equipment or government systems |
| Green Phosphor | Clinical sterility | Dehumanizes the content; text becomes data, not emotion |
| Scanlines | Temporal distance | Creates feeling of "old" technology, implying long-established procedure |
| Black Background | Void association | The emptiness is where memories go; it's not threatening, just... absent |
| Mechanical Sounds | Procedural weight | Every action sounds consequential; the machine is "doing something" |
| Deliberate Slowness | Gravitas | Fast interfaces feel casual; slowness implies importance |

**Key Principle:** The interface should feel like something the government would use to process important records. Bureaucratic. Inevitable. Not malicious—just *systematic.*

---

# ═══════════════════════════════════════════════════════════════════════════
# SECTION II: USER INTERFACE ARCHITECTURE
# ═══════════════════════════════════════════════════════════════════════════

## 2.1 BOOT SEQUENCE

When the player approaches the Redaction Chamber and initiates contact, the terminal performs a boot sequence. This is not necessary for functionality—it is necessary for *atmosphere.*

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  │
│                                                                             │
│                                                                             │
│               REDACTOR CALIBRATION SYSTEMS — DIVISION 7                     │
│                                                                             │
│                        MK-IV REDACTION TERMINAL                             │
│                                                                             │
│                      — BOARD OF ETHICS APPROVED —                           │
│                                                                             │
│                                                                             │
│  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  │
│                                                                             │
│                                                                             │
│       INITIALIZING MEMORY INTERFACE.................... [OK]                │
│       LOADING BIOGRAPHICAL DATABASE.................... [OK]                │
│       CALIBRATING EXTRACTION PROTOCOLS................. [OK]                │
│       VERIFYING ETHICS COMPLIANCE...................... [OK]                │
│       CONNECTING TO CENTRAL ARCHIVE.................... [OK]                │
│                                                                             │
│                                                                             │
│       SUBJECT IDENTIFICATION REQUIRED                                       │
│                                                                             │
│       > SCANNING.........                                                   │
│                                                                             │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Boot Sequence Timing:**
- Each line appears with 0.5-1.0 second delay
- "[OK]" confirmations appear after brief processing animation (spinning cursor)
- Occasional "[VERIFYING...]" pause before "[OK]" for tension
- "SUBJECT IDENTIFICATION" triggers player's character data load

## 2.2 MAIN INTERFACE — THE CALIBRATION DASHBOARD

After boot, the player sees the main Calibration Dashboard. This is the primary UI they will interact with.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ ┌─────────────────────────────────────────────────────────────────────────┐ │
│ │  REDACTION TERMINAL MK-IV          SUBJECT: [PLAYER_NAME]    RT: [147] │ │
│ │  ─────────────────────────────────────────────────────────────────────  │ │
│ │  STATUS: READY FOR CALIBRATION     CLEARANCE: TIER [3]                 │ │
│ └─────────────────────────────────────────────────────────────────────────┘ │
│                                                                             │
│  ╔═══════════════════════════════════════════════════════════════════════╗  │
│  ║                     CURRENT CALIBRATION METRICS                       ║  │
│  ╠═══════════════════════════════════════════════════════════════════════╣  │
│  ║                                                                       ║  │
│  ║   PHYSICAL COMPLIANCE............... [████████░░░░░░░░░░░░]  LV.08   ║  │
│  ║   COGNITIVE THROUGHPUT.............. [██████░░░░░░░░░░░░░░]  LV.06   ║  │
│  ║   PERCEPTUAL ALIGNMENT.............. [████████████░░░░░░░░]  LV.12   ║  │
│  ║   ARCHIVAL EFFICIENCY............... [████░░░░░░░░░░░░░░░░]  LV.04   ║  │
│  ║                                                                       ║  │
│  ║   ─────────────────────────────────────────────────────────────────   ║  │
│  ║   TOTAL CALIBRATION INDEX: 30/80                                      ║  │
│  ║                                                                       ║  │
│  ╚═══════════════════════════════════════════════════════════════════════╝  │
│                                                                             │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │                        AVAILABLE OPERATIONS                           │  │
│  ├───────────────────────────────────────────────────────────────────────┤  │
│  │                                                                       │  │
│  │   [1] ► INITIATE CALIBRATION UPGRADE                                  │  │
│  │                                                                       │  │
│  │   [2] ► REVIEW BIOGRAPHICAL ARCHIVE                                   │  │
│  │                                                                       │  │
│  │   [3] ► VIEW REDACTION HISTORY                                        │  │
│  │                                                                       │  │
│  │   [4] ► SYSTEM INFORMATION                                            │  │
│  │                                                                       │  │
│  │   [0] ► TERMINATE SESSION                                             │  │
│  │                                                                       │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │ INPUT: _                                                    [READY]   │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### UI ELEMENT BREAKDOWN

```json
{
  "ui_elements": {
    "header_bar": {
      "contents": ["Terminal ID", "Subject Name", "Recall Token Balance", "Clearance Level"],
      "behavior": "Always visible, updates in real-time",
      "styling": "Inverse colors (black on green) for prominence"
    },

    "calibration_metrics_panel": {
      "contents": "The four character stats with progress bars",
      "behavior": "Bars fill left-to-right, 20 segments per stat",
      "styling": "Double-line border (╔╗╚╝), indicates primary importance",
      "animation": "Subtle pulse on the stat currently selected for upgrade"
    },

    "operations_menu": {
      "contents": "Available actions",
      "behavior": "Keyboard navigation (1-4, 0), selection highlights row",
      "styling": "Single-line border, ► marker on selected option",
      "animation": "Selected option glows slightly brighter"
    },

    "input_line": {
      "contents": "Command entry field",
      "behavior": "Blinking cursor, accepts numeric input or typed commands",
      "styling": "Underlined, [READY]/[PROCESSING]/[ERROR] status indicator"
    }
  }
}
```

## 2.3 CALIBRATION UPGRADE FLOW

When the player selects "[1] INITIATE CALIBRATION UPGRADE," the interface transitions to the upgrade flow. This is the core loop of the Redaction Chamber.

### STEP 1: STAT SELECTION

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ ┌─────────────────────────────────────────────────────────────────────────┐ │
│ │  CALIBRATION UPGRADE — STEP 1 OF 3               RT AVAILABLE: [147]   │ │
│ └─────────────────────────────────────────────────────────────────────────┘ │
│                                                                             │
│  ╔═══════════════════════════════════════════════════════════════════════╗  │
│  ║                    SELECT METRIC FOR IMPROVEMENT                      ║  │
│  ╠═══════════════════════════════════════════════════════════════════════╣  │
│  ║                                                                       ║  │
│  ║  ┌─────────────────────────────────────────────────────────────────┐  ║  │
│  ║  │ [1] PHYSICAL COMPLIANCE                                         │  ║  │
│  ║  │     Current: LV.08 → Target: LV.09                              │  ║  │
│  ║  │     Cost: 15 RT + 1 BIOGRAPHICAL ENTRY                          │  ║  │
│  ║  │                                                                 │  ║  │
│  ║  │     "The body's willingness to perform under institutional      │  ║  │
│  ║  │      direction. Higher levels indicate reduced resistance       │  ║  │
│  ║  │      to physical demands."                                      │  ║  │
│  ║  └─────────────────────────────────────────────────────────────────┘  ║  │
│  ║                                                                       ║  │
│  ║  ┌─────────────────────────────────────────────────────────────────┐  ║  │
│  ║  │ [2] COGNITIVE THROUGHPUT                                        │  ║  │
│  ║  │     Current: LV.06 → Target: LV.07                              │  ║  │
│  ║  │     Cost: 20 RT + 1 BIOGRAPHICAL ENTRY                          │  ║  │
│  ║  │                                                                 │  ║  │
│  ║  │     "Processing capacity for sanctioned information streams.    │  ║  │
│  ║  │      Higher levels enable faster integration of approved        │  ║  │
│  ║  │      knowledge patterns."                                       │  ║  │
│  ║  └─────────────────────────────────────────────────────────────────┘  ║  │
│  ║                                                                       ║  │
│  ║                         [▼ SCROLL FOR MORE]                           ║  │
│  ║                                                                       ║  │
│  ╚═══════════════════════════════════════════════════════════════════════╝  │
│                                                                             │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │ SELECT METRIC [1-4] OR [0] TO CANCEL: _                    [READY]   │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### STEP 2: BIOGRAPHICAL ENTRY SELECTION (The Cost of Progress)

After selecting a stat, the player must choose which memory to sacrifice. This is where the system reveals (and forces interaction with) the player's character biography.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ ┌─────────────────────────────────────────────────────────────────────────┐ │
│ │  CALIBRATION UPGRADE — STEP 2 OF 3               RT AVAILABLE: [147]   │ │
│ │  SELECTED: PHYSICAL COMPLIANCE (LV.08 → LV.09)   COST: 15 RT          │ │
│ └─────────────────────────────────────────────────────────────────────────┘ │
│                                                                             │
│  ╔═══════════════════════════════════════════════════════════════════════╗  │
│  ║              SELECT BIOGRAPHICAL ENTRY FOR ARCHIVAL                   ║  │
│  ║                                                                       ║  │
│  ║  "Improvement requires release. Select a memory to archive.           ║  │
│  ║   The memory will be preserved safely. You simply will not            ║  │
│  ║   carry it anymore."                                                  ║  │
│  ╠═══════════════════════════════════════════════════════════════════════╣  │
│  ║                                                                       ║  │
│  ║  ► [A] THE CHILDHOOD FRIEND                          [AVAILABLE]      ║  │
│  ║        Category: PERSONAL ATTACHMENT                                  ║  │
│  ║        Weight: MODERATE                                               ║  │
│  ║                                                                       ║  │
│  ║    [B] THE MEMORY OF HOME                            [AVAILABLE]      ║  │
│  ║        Category: FOUNDATIONAL IDENTITY                                ║  │
│  ║        Weight: SIGNIFICANT                                            ║  │
│  ║                                                                       ║  │
│  ║    [C] THE VOW                                       [AVAILABLE]      ║  │
│  ║        Category: CORE MOTIVATION                                      ║  │
│  ║        Weight: CRITICAL                                               ║  │
│  ║                                                                       ║  │
│  ║    [D] THE LAST WORDS                                [RESTRICTED]     ║  │
│  ║        Category: ████████████                                         ║  │
│  ║        Weight: ████████                                               ║  │
│  ║                                                                       ║  │
│  ║                         [▼ MORE ENTRIES BELOW]                        ║  │
│  ║                                                                       ║  │
│  ╚═══════════════════════════════════════════════════════════════════════╝  │
│                                                                             │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │ SELECT ENTRY [A-Z] OR [0] TO CANCEL: _                     [READY]   │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### STEP 3: CONFIRMATION & REDACTION

Once an entry is selected, the player sees the full memory content and must confirm its archival. This is the emotional core of the system.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ ┌─────────────────────────────────────────────────────────────────────────┐ │
│ │  CALIBRATION UPGRADE — STEP 3 OF 3               RT AVAILABLE: [147]   │ │
│ │  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ CONFIRMATION REQUIRED ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓               │ │
│ └─────────────────────────────────────────────────────────────────────────┘ │
│                                                                             │
│  ╔═══════════════════════════════════════════════════════════════════════╗  │
│  ║                  BIOGRAPHICAL ENTRY — PREVIEW                         ║  │
│  ╠═══════════════════════════════════════════════════════════════════════╣  │
│  ║                                                                       ║  │
│  ║  ENTRY: THE CHILDHOOD FRIEND                                          ║  │
│  ║  ───────────────────────────────────────────────────────────────────  ║  │
│  ║                                                                       ║  │
│  ║  "Her name was Lira. We met by the river when we were seven.          ║  │
│  ║  She taught me to skip stones. I taught her the words to the          ║  │
│  ║  song my mother sang. We promised we would always find each           ║  │
│  ║  other, no matter what. I gave her half of my lucky coin. She         ║  │
│  ║  gave me a ribbon from her hair. I still have it. I think.            ║  │
│  ║  I can almost see her face when I close my eyes.                      ║  │
│  ║  Almost."                                                             ║  │
│  ║                                                                       ║  │
│  ║  ───────────────────────────────────────────────────────────────────  ║  │
│  ║  ASSOCIATED ASSETS: [RIBBON — INVENTORY ITEM]                         ║  │
│  ║  NOTE: Archiving this entry may affect item significance.             ║  │
│  ║                                                                       ║  │
│  ╚═══════════════════════════════════════════════════════════════════════╝  │
│                                                                             │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │  UPGRADE SUMMARY:                                                     │  │
│  │    • PHYSICAL COMPLIANCE: LV.08 → LV.09                               │  │
│  │    • RECALL TOKENS: 147 → 132 (-15)                                   │  │
│  │    • BIOGRAPHICAL ENTRY: "THE CHILDHOOD FRIEND" → [ARCHIVED]          │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │  [CONFIRM] — PROCEED WITH ARCHIVAL        [CANCEL] — ABORT UPGRADE   │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### STEP 4: THE REDACTION ANIMATION

If the player confirms, the system performs the redaction with a deliberate, unsettling animation sequence.

```
REDACTION ANIMATION SEQUENCE — TECHNICAL SPECIFICATION

Phase 1: ACKNOWLEDGMENT (2 seconds)
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│                                                                             │
│                                                                             │
│                        ARCHIVAL INITIATED                                   │
│                                                                             │
│                 Processing biographical entry...                            │
│                                                                             │
│                        Please do not look away.                             │
│                                                                             │
│                                                                             │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘

- Screen flickers subtly
- Low hum increases in volume
- AMBER status LED activates


Phase 2: THE READING (4-6 seconds)
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│  ╔═══════════════════════════════════════════════════════════════════════╗  │
│  ║                                                                       ║  │
│  ║  "Her name was Lira. We met by the river when we were seven.          ║  │
│  ║  She taught me to skip stones. I taught her the words to the          ║  │
│  ║  song my mother sang. We promised we would always find each           ║  │
│  ║  other, no matter what. I gave her half of my lucky coin. She         ║  │
│  ║  gave me a ribbon from her hair. I still have it. I think.            ║  │
│  ║  I can almost see her face when I close my eyes.                      ║  │
│  ║  Almost."                                                             ║  │
│  ║         ▲                                                             ║  │
│  ║         │                                                             ║  │
│  ║    [SCANNING LINE MOVES DOWN THROUGH TEXT]                            ║  │
│  ║                                                                       ║  │
│  ╚═══════════════════════════════════════════════════════════════════════╝  │
│                                                                             │
│              INDEXING MEMORY CONTENT............. 47%                       │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘

- A bright scanning line moves slowly down through the text
- Each line it passes becomes slightly dimmer, as if being "read" and drained
- Percentage counter increases
- The player is forced to watch their memory being processed


Phase 3: THE REDACTION (3-4 seconds)
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│  ╔═══════════════════════════════════════════════════════════════════════╗  │
│  ║                                                                       ║  │
│  ║  "Her name was ████. We met by the █████ when we were seven.          ║  │
│  ║  She taught me to ████ ██████. I taught her the █████ to the          ║  │
│  ║  ████ my ██████ sang. We promised we would always ████ each           ║  │
│  ║  █████, no matter what. I gave her ████ of my █████ ████. She         ║  │
│  ║  gave me a ██████ from her ████. I █████ have it. I █████.            ║  │
│  ║  I can ██████ see her ████ when I █████ my ████.                      ║  │
│  ║  ██████."                                                             ║  │
│  ║                                                                       ║  │
│  ╚═══════════════════════════════════════════════════════════════════════╝  │
│                                                                             │
│              ARCHIVING SIGNIFICANT DETAILS............. 78%                 │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘

- Words are replaced with black bars (█) in a semi-random pattern
- The redaction spreads like ink bleeding through paper
- Key emotional words go first: names, locations, objects
- Structural words remain longer, creating ghostly sentence fragments
- Sound: soft "thup thup thup" like a stamp being applied


Phase 4: THE COMPLETION (2 seconds)
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│  ╔═══════════════════════════════════════════════════════════════════════╗  │
│  ║                                                                       ║  │
│  ║  "███ ████ ███ ████. ██ ███ ██ ███ █████ ████ ██ ████ █████.          ║  │
│  ║  ███ ██████ ██ ██ ████ ██████. █ ██████ ███ ███ █████ ██ ███          ║  │
│  ║  ████ ██ ██████ ████. ██ ████████ ██ █████ ██████ ████ ████           ║  │
│  ║  █████, ██ ██████ ████. █ ████ ███ ████ ██ ██ █████ ████. ███         ║  │
│  ║  ████ ██ █ ██████ ████ ███ ████. █ █████ ████ ██. █ █████.            ║  │
│  ║  █ ███ ██████ ███ ███ ████ ████ █ █████ ██ ████.                      ║  │
│  ║  ██████."                                                             ║  │
│  ║                                                                       ║  │
│  ╚═══════════════════════════════════════════════════════════════════════╝  │
│                                                                             │
│              ARCHIVAL COMPLETE ████████████████████████ 100%                │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘

- Text is now fully redacted—just black bars with punctuation ghosts
- A final "stamp" sound
- The bars pulse once, then settle


Phase 5: THE AFTERMATH (3 seconds)
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│                                                                             │
│                        ═══════════════════════════                          │
│                            CALIBRATION COMPLETE                             │
│                        ═══════════════════════════                          │
│                                                                             │
│                   PHYSICAL COMPLIANCE: LV.08 → LV.09                        │
│                                                                             │
│                        BIOGRAPHICAL ENTRY ARCHIVED:                         │
│                        "███ █████████ ██████"                               │
│                                                                             │
│                   The memory has been preserved safely.                     │
│                   You are lighter now.                                      │
│                                                                             │
│                                                                             │
│                        [PRESS ANY KEY TO CONTINUE]                          │
│                                                                             │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘

- Even the TITLE of the memory is now partially redacted
- "You are lighter now" is the NLP hook—frames loss as liberation
- Brief pause before input is accepted—let it sink in
```

---

# ═══════════════════════════════════════════════════════════════════════════
# SECTION III: BIOGRAPHICAL ENTRIES — SAMPLE CONTENT
# ═══════════════════════════════════════════════════════════════════════════

## 3.1 ENTRY DESIGN PHILOSOPHY

Biographical entries must:
1. **Be emotionally resonant** — The player must feel the weight of what they're trading
2. **Be personally relevant** — Entries should feel like they belong to *this* character
3. **Have mechanical consequences** — Some entries affect gameplay beyond stats
4. **Degrade meaningfully** — The redacted version should be haunting, not just blank

```json
{
  "entry_categories": {
    "personal_attachment": {
      "description": "Memories of relationships—friends, family, lovers",
      "weight_range": "MINOR to SIGNIFICANT",
      "mechanical_impact": "May affect NPC recognition, dialogue options, quest availability",
      "redaction_style": "Names go first, then places, then emotional content"
    },
    "foundational_identity": {
      "description": "Memories that define who the character believes they are",
      "weight_range": "SIGNIFICANT to CRITICAL",
      "mechanical_impact": "May affect character voice lines, idle animations, core motivation",
      "redaction_style": "Sensory details go first, then narrative, then emotional weight"
    },
    "core_motivation": {
      "description": "Memories that explain WHY the character does what they do",
      "weight_range": "CRITICAL",
      "mechanical_impact": "May alter main quest framing, ending availability, NPC relationships",
      "redaction_style": "Reasoning goes first, then context, leaving only raw emotion"
    },
    "forbidden": {
      "description": "Memories that touch Aethel-Astral, institutional secrets, or reality itself",
      "weight_range": "UNDEFINED — SYSTEM PROTECTED",
      "mechanical_impact": "Cannot be normally selected—triggers Breach Event if accessed",
      "redaction_style": "ALREADY PARTIALLY REDACTED before player sees them"
    }
  }
}
```

---

## 3.2 SAMPLE ENTRY A: "THE CHILDHOOD FRIEND"

### Pre-Redaction State

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  BIOGRAPHICAL ENTRY #003                                                    │
│  TITLE: THE CHILDHOOD FRIEND                                                │
│  CATEGORY: PERSONAL ATTACHMENT                                              │
│  WEIGHT: MODERATE                                                           │
│  ─────────────────────────────────────────────────────────────────────────  │
│                                                                             │
│  Her name was Lira. We met by the river when we were seven. She taught      │
│  me to skip stones—she could make them bounce five, six, seven times        │
│  while mine always sank after two. I taught her the words to the song       │
│  my mother sang at bedtime, the one about the stars that fell asleep.       │
│                                                                             │
│  We promised we would always find each other, no matter what. I gave        │
│  her half of my lucky coin—the one my father said would keep me safe.       │
│  She gave me a ribbon from her hair, pale blue like the morning sky.        │
│                                                                             │
│  I still have it. I think. I can almost see her face when I close my        │
│  eyes. The shape of her smile. The sound of her laugh.                      │
│                                                                             │
│  Almost.                                                                    │
│                                                                             │
│  ─────────────────────────────────────────────────────────────────────────  │
│  ASSOCIATED ASSETS: [RIBBON — Equippable Accessory, +5 Luck]                │
│  ASSOCIATED NPCs: [LIRA — Potential encounter in late-game]                 │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Post-Redaction State (Viewed in "Redaction History")

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  BIOGRAPHICAL ENTRY #003                                                    │
│  TITLE: ███ █████████ ██████                                                │
│  CATEGORY: ████████ ██████████                                              │
│  WEIGHT: ████████                                                           │
│  STATUS: [ARCHIVED — CYCLE 47]                                              │
│  ─────────────────────────────────────────────────────────────────────────  │
│                                                                             │
│  ███ name was ████. We met by the █████ when we were █████. She taught      │
│  me to ████ ██████—she could make them ██████ five, ███, █████ times        │
│  while mine always ████ after two. I taught her the █████ to the ████       │
│  my ██████ sang at ███████, the one about the █████ that ████ ██████.       │
│                                                                             │
│  We ████████ we would always ████ ████ █████, no matter what. I gave        │
│  ███ half of my █████ ████—the one my ██████ said would ████ me ████.       │
│  ███ gave me a ██████ from ███ ████, ████ ████ like the ███████ ███.        │
│                                                                             │
│  I █████ have it. I █████. I can ██████ ███ ███ ████ when I █████ my        │
│  ████. The █████ of ███ █████. The █████ of ███ █████.                      │
│                                                                             │
│  ██████.                                                                    │
│                                                                             │
│  ─────────────────────────────────────────────────────────────────────────  │
│  ASSOCIATED ASSETS: [RIBBON — Equippable Accessory, +5 ███]                 │
│  NOTE: "I have this ribbon. I don't remember why it matters."               │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Mechanical Consequences

```json
{
  "consequences": {
    "immediate": [
      "Ribbon item loses +5 Luck bonus, becomes 'Faded Ribbon' (+0 stats)",
      "Item description changes to: 'A pale ribbon. It feels important, but you cannot remember why.'",
      "Character voice line added: 'There's something I was supposed to remember...' (plays randomly)"
    ],
    "narrative": [
      "If Lira appears in late-game: Player does not recognize her",
      "Dialogue option 'We made a promise' becomes unavailable",
      "Lira's reaction changes from joy to grief: 'You don't remember me. They took me from you.'"
    ],
    "hidden": [
      "Unredacted faction can potentially RESTORE this memory later (very difficult quest)",
      "If restored, Ribbon regains stats AND gains +10 additional (memories have power when reclaimed)"
    ]
  }
}
```

---

## 3.3 SAMPLE ENTRY B: "THE MEMORY OF HOME"

### Pre-Redaction State

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  BIOGRAPHICAL ENTRY #007                                                    │
│  TITLE: THE MEMORY OF HOME                                                  │
│  CATEGORY: FOUNDATIONAL IDENTITY                                            │
│  WEIGHT: SIGNIFICANT                                                        │
│  ─────────────────────────────────────────────────────────────────────────  │
│                                                                             │
│  The house had blue shutters. I remember because I helped my father paint   │
│  them the summer I turned nine. We got more paint on ourselves than on the  │
│  wood, and my mother laughed from the doorway, holding a pitcher of cold    │
│  water that caught the afternoon light.                                     │
│                                                                             │
│  The kitchen always smelled like bread. There was a window above the        │
│  basin where herbs grew in clay pots—rosemary, thyme, something purple      │
│  I never learned the name of. My mother would hum while she worked. I       │
│  can still hear it. The melody, if not the words.                           │
│                                                                             │
│  My room was in the back, small but mine. I carved my initials into the     │
│  beam above the bed when I was twelve. I wonder if they're still there.     │
│  I wonder if the house is still there.                                      │
│                                                                             │
│  I haven't been back. I'm not sure I could find it if I tried.              │
│                                                                             │
│  ─────────────────────────────────────────────────────────────────────────  │
│  ASSOCIATED LOCATION: [UNMARKED — "Childhood Home" appears on map if held]  │
│  ASSOCIATED NPCs: [PARENTS — Status unknown, quest-dependent]               │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Post-Redaction State

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  BIOGRAPHICAL ENTRY #007                                                    │
│  TITLE: ███ ██████ ██ ████                                                  │
│  CATEGORY: ████████████ ████████                                            │
│  WEIGHT: ███████████                                                        │
│  STATUS: [ARCHIVED — CYCLE 47]                                              │
│  ─────────────────────────────────────────────────────────────────────────  │
│                                                                             │
│  The █████ had ████ ████████. I ████████ because I helped my ██████ paint   │
│  them the ██████ I turned ████. We got more █████ on █████████ than on the  │
│  ████, and my ██████ ███████ from the ███████, holding a ███████ of cold    │
│  █████ that caught the █████████ █████.                                     │
│                                                                             │
│  The ███████ always smelled like █████. There was a ██████ above the        │
│  █████ where █████ grew in ████ ████—████████, █████, something ██████      │
│  I never ███████ the ████ of. My ██████ would ███ while ███ ██████. I       │
│  can █████ ████ ██. The ██████, if not the █████.                           │
│                                                                             │
│  My ████ was in the ████, █████ but ████. I ██████ my ████████ into the     │
│  ████ above the ███ when I was ██████. I ██████ if ██████ █████ █████.      │
│  I ██████ if the █████ is █████ █████.                                      │
│                                                                             │
│  I ██████ been ████. I'm not ████ I █████ ████ ██ if I █████.               │
│                                                                             │
│  ─────────────────────────────────────────────────────────────────────────  │
│  ASSOCIATED LOCATION: [DATA REMOVED]                                        │
│  NOTE: "There was a place. I lived there once. I can't find it anymore."    │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Mechanical Consequences

```json
{
  "consequences": {
    "immediate": [
      "Map marker 'Childhood Home' is removed",
      "Character loses 'Familiar Ground' passive (+10% stats when near home region)",
      "Idle animation 'Looking at horizon nostalgically' is replaced with 'Staring blankly'"
    ],
    "narrative": [
      "If player reaches home location: Area appears as empty field",
      "NPC dialogue about player's origins becomes confused: 'Where did you say you were from? I don't recognize that description.'",
      "Parents (if found) do not trigger recognition dialogue"
    ],
    "hidden": [
      "Home location still exists in data—but player cannot perceive it",
      "Truth Lens item temporarily reveals the house's 'ghost' when equipped in the area",
      "Full restoration requires Unredacted assistance + significant RT investment"
    ]
  }
}
```

---

## 3.4 SAMPLE ENTRY C: "THE VOW"

### Pre-Redaction State

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  BIOGRAPHICAL ENTRY #012                                                    │
│  TITLE: THE VOW                                                             │
│  CATEGORY: CORE MOTIVATION                                                  │
│  WEIGHT: CRITICAL                                                           │
│  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ WARNING ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                        │
│  Archiving this entry may significantly alter character motivation.         │
│  ─────────────────────────────────────────────────────────────────────────  │
│                                                                             │
│  I made a promise. Kneeling in the ashes of what used to be the village     │
│  square, I made a promise to the dead.                                      │
│                                                                             │
│  I said: I will find out what happened here. I will learn who gave the      │
│  order. I will understand why. And when I understand—I will make them       │
│  answer for it. Not with violence alone. With truth. The truth they tried   │
│  to bury with the bodies.                                                   │
│                                                                             │
│  I don't know if anyone heard me. Maybe the dead don't listen. Maybe        │
│  they're past caring. But I heard myself. And I have not forgotten.         │
│                                                                             │
│  Everything I have done since that day has been in service of that vow.     │
│  Every skill I've learned. Every alliance I've made. Every compromise       │
│  I've justified. It all leads back to that moment in the ashes.             │
│                                                                             │
│  I will not stop until I keep my promise.                                   │
│                                                                             │
│  ─────────────────────────────────────────────────────────────────────────  │
│  ASSOCIATED QUEST: [MAIN STORY — "The Buried Truth"]                        │
│  ASSOCIATED ENDING: [REVELATION ENDING — Requires this memory intact]       │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Post-Redaction State

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  BIOGRAPHICAL ENTRY #012                                                    │
│  TITLE: ███ ███                                                             │
│  CATEGORY: ████ ██████████                                                  │
│  WEIGHT: ████████                                                           │
│  STATUS: [ARCHIVED — CYCLE 47]                                              │
│  ─────────────────────────────────────────────────────────────────────────  │
│                                                                             │
│  I made a ███████. ████████ in the █████ of what used to be the ███████     │
│  ██████, I made a ███████ to the ████.                                      │
│                                                                             │
│  I said: ████████████████████████████████████████████████████████████████   │
│  ██████████████████████████████████████████████████████████████████████████ │
│  ██████████████████████████████████████████████████████████████████████████ │
│  ██████████████████████████████████████████████████████████████████████████ │
│                                                                             │
│  I ██████ ████ if ██████ █████ me. █████ ███ ████ █████ ██████. █████       │
│  ████████ ████ ██████. ███ █ █████ ██████. ███ █ ████ ███ █████████.        │
│                                                                             │
│  ██████████ I ████ ████ █████ ████ ███ ███ ████ ██ ███████ ██ ████ ███.     │
│  █████ █████ ████ ███████. █████ ████████ ████ ████. █████ ██████████       │
│  ████ █████████. ██ ███ █████ ████ ██ ████ ██████ ██ ███ █████.             │
│                                                                             │
│  I ████ ███ ████ █████ █ ████ ██ ███████.                                   │
│                                                                             │
│  ─────────────────────────────────────────────────────────────────────────  │
│  ASSOCIATED QUEST: [MAIN STORY — "███ ██████ █████"]                        │
│  NOTE: "I'm doing something. I must have a reason. I can't remember it."    │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Mechanical Consequences

```json
{
  "consequences": {
    "immediate": [
      "Main quest 'The Buried Truth' is removed from quest log",
      "Quest replaced with 'Uncertain Purpose' — generic exploration objectives",
      "Character voice lines about determination are replaced with confusion: 'Why am I here again?'",
      "Main menu character description changes"
    ],
    "narrative": [
      "REVELATION ENDING becomes unavailable",
      "NPCs who knew the player's purpose react with concern: 'You've changed. You used to have fire in you.'",
      "New ending branch unlocks: 'THE EMPTY PATH' — player drifts through remaining story without driving purpose",
      "Faction reactions change: Resistance sees player as lost cause; Status Quo sees recruitment opportunity"
    ],
    "hidden": [
      "This is the most valuable memory for Status Quo to acquire",
      "If player redacts this willingly, they gain MASSIVE stat boost (triple normal)",
      "Restoration requires late-game intervention from Aethel-Pact (they can show you what you promised)",
      "Restored Vow comes back STRONGER — the act of reclaiming it adds power"
    ]
  }
}
```

---

# ═══════════════════════════════════════════════════════════════════════════
# SECTION IV: THE BREACH TRIGGER SYSTEM
# ═══════════════════════════════════════════════════════════════════════════

## 4.1 FORBIDDEN FILES — CLASSIFICATION

Certain biographical entries are marked [RESTRICTED] or [FORBIDDEN]. These represent memories that:
- Touch Aethel-Astral directly (player has seen beneath the frame)
- Contain institutional secrets (player has learned something the system protects)
- Are foundationally protected (the system needs these intact for reasons unknown to the player)

**The player should NOT be able to easily redact these.** Attempting to do so triggers a **Breach Event.**

## 4.2 SAMPLE FORBIDDEN ENTRY: "THE LAST WORDS"

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  BIOGRAPHICAL ENTRY #023                                                    │
│  TITLE: THE LAST WORDS                                                      │
│  CATEGORY: ████████████                                                     │
│  WEIGHT: ████████                                                           │
│  STATUS: [RESTRICTED — CLEARANCE INSUFFICIENT]                              │
│  ─────────────────────────────────────────────────────────────────────────  │
│                                                                             │
│  ████████████████████████████████████████████████████████████████████████   │
│  ████████████████████████████████████████████████████████████████████████   │
│  ████████████████████████████████████████████████████████████████████████   │
│                                                                             │
│  ████ told me ████████████████████ before ████ ████████████.                │
│                                                                             │
│  ████████████████████████████████████████████████████████████████████████   │
│  ████████████████████████████████████████████████████████████████████████   │
│  ████████████████████████████████████████████████████████████████████████   │
│                                                                             │
│  I understood then. About the ██████████. About the ██████. About why       │
│  ████████████████████████████████████████████████████████████████████████   │
│                                                                             │
│  I can never unhear what ████ said.                                         │
│                                                                             │
│  ─────────────────────────────────────────────────────────────────────────  │
│  ACCESS DENIED: This entry is protected by Archival Security Protocol.      │
│  Unauthorized access attempts will be logged.                               │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Note:** The entry is ALREADY partially redacted—even to the player. This implies that:
1. Someone/something has edited the player's memories before
2. There is information here the system considers dangerous
3. The player knows SOMETHING important but cannot consciously access it

## 4.3 BREACH EVENT SEQUENCE

If the player attempts to select a [RESTRICTED] or [FORBIDDEN] entry for archival, the terminal does not simply refuse. It **reacts.**

### PHASE 1: THE WARNING

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  │
│                                                                             │
│                        ██ WARNING ██                                        │
│                                                                             │
│           ENTRY SELECTION: "THE LAST WORDS"                                 │
│           STATUS: PROTECTED UNDER ARCHIVAL SECURITY PROTOCOL                │
│                                                                             │
│           This entry is classified beyond your current clearance.           │
│           Attempting to access protected entries may trigger                │
│           automatic security responses.                                     │
│                                                                             │
│           Do you wish to proceed?                                           │
│                                                                             │
│                [YES — I UNDERSTAND THE RISKS]                               │
│                [NO — RETURN TO SELECTION]                                   │
│                                                                             │
│  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

- Screen flickers to AMBER warning state
- Audio: Low warning tone, rhythmic pulse
- Text is slightly unstable, characters occasionally glitching

### PHASE 2: THE BREACH ATTEMPT (If player selects YES)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│              ACCESSING PROTECTED ENTRY...                                   │
│                                                                             │
│              ████████████████████░░░░░░░░░░░░░░░░░░░░ 34%                   │
│                                                                             │
│                                                                             │
│                                                                             │
│                                                                             │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

- Progress bar moves forward, then stutters
- Screen begins to show visual artifacts—static, color bleeds
- Audio: Electrical interference, the hum becoming unstable

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│              ACCESSING PROTECTED ENTRY...                                   │
│                                                                             │
│              ████████████████████████████████████░░░░ 78%                   │
│                                                                             │
│                                                                             │
│              ▓▓▓▓▓▓▓▓▓▓ SECURITY ALERT ▓▓▓▓▓▓▓▓▓▓                          │
│                                                                             │
│              Unauthorized access pattern detected.                          │
│              Initiating countermeasures...                                  │
│                                                                             │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### PHASE 3: THE BREACH (System Failure)

The terminal **breaks.** Not in a clean error-message way—in a *something-has-gone-wrong* way.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│  ERRR█R: ████CURITY PROT██OL VIOLATION                                      │
│                                                                             │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░MEMORY CONTAINME░░░FAILURE░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│                                                                             │
│                                                                             │
│                                                                             │
│                        Y O U   S A W   I T                                  │
│                                                                             │
│                                                                             │
│                                                                             │
│                         ████ told you                                       │
│                                                                             │
│                     before the ████████████                                 │
│                                                                             │
│                                                                             │
│                    you    a l r e a d y    k n o w                          │
│                                                                             │
│                                                                             │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Visual Effects:**
- Screen tears, horizontal line artifacts
- Colors invert momentarily
- Text appears where it shouldn't—fragments of the protected memory leaking through
- The CRT makes sounds it shouldn't—cracking, electrical popping

**Audio Effects:**
- Distorted voice fragments (the voice of whoever spoke "the last words")
- Static crescendo
- A sound like something INSIDE the machine trying to get out

### PHASE 4: THE REVEAL (Brief)

For exactly 2-3 seconds, the player sees PART of the protected content—not redacted, but glitched and fragmentary:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│                                                                             │
│                                                                             │
│              "The Scale is not protecting you.                              │
│                                                                             │
│               They are protecting ████████ FROM you.                        │
│                                                                             │
│               You saw what was underneath.                                  │
│                                                                             │
│               That is why they ████████████████                             │
│                                                                             │
│               Remember:                                                     │
│                                                                             │
│               The door was never                                            │
│                                                                             │
│                                                                             │
│                                                                             │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

Then—

### PHASE 5: THE LOCKDOWN

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│                                                                             │
│                                                                             │
│                                                                             │
│  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  │
│                                                                             │
│                     TERMINAL LOCKDOWN INITIATED                             │
│                                                                             │
│                     Security Protocol 7-SIGMA Active                        │
│                                                                             │
│                     Your access attempt has been logged.                    │
│                                                                             │
│                     Please remain at your station.                          │
│                     A Calibration Specialist has been notified.             │
│                                                                             │
│                     THIS IS FOR YOUR PROTECTION.                            │
│                                                                             │
│  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  │
│                                                                             │
│                                                                             │
│                                                                             │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Gameplay Consequences:**
- Terminal becomes unusable for a period (real-time or in-game time)
- Player's flag level increases (if not already flagged)
- Redactor NPCs become more watchful
- The fragmentary text the player saw becomes a **Clue** in their inventory
- New questline potentially unlocks: "What Did I See?"

---

# ═══════════════════════════════════════════════════════════════════════════
# SECTION V: CHARACTER STATISTICS — INSTITUTIONAL TERMINOLOGY
# ═══════════════════════════════════════════════════════════════════════════

## 5.1 STATS VS. SOUL — DESIGN PHILOSOPHY

Character statistics in Soulwalker are not neutral descriptors. The *names* of the stats are part of the institutional control system. By using these terms, the player internalizes the system's framing.

**Traditional RPG stats** suggest individual capability: *Strength, Intelligence, Dexterity, Wisdom.*

**Soulwalker stats** suggest institutional alignment: *Physical Compliance, Cognitive Throughput, Perceptual Alignment, Archival Efficiency.*

The difference is subtle but important. The player is not becoming *stronger*—they are becoming *more compliant.* They are not becoming *smarter*—they are processing *sanctioned information faster.* The system rewards alignment with itself.

---

## 5.2 THE FOUR CALIBRATION METRICS

```json
{
  "character_stats": {
    "physical_compliance": {
      "abbreviation": "PC",
      "traditional_equivalent": "Strength / Constitution",
      "institutional_framing": "The body's willingness to perform under institutional direction.",

      "official_description": "Measures your physical capacity for sanctioned tasks. Higher levels indicate reduced biological resistance to labor demands and improved response to physical Calibration protocols.",

      "hidden_meaning": "How well your body obeys when your mind might resist. How much punishment you can take while remaining functional. How thoroughly you've surrendered physical autonomy.",

      "mechanical_effects": [
        "Base health pool (+5% per level)",
        "Melee damage (+3% per level)",
        "Stamina regeneration (+2% per level)",
        "Resistance to physical status effects (+2% per level)"
      ],

      "visual_feedback": {
        "low_levels": "Character moves hesitantly, sometimes pauses before physical actions",
        "mid_levels": "Smooth, efficient movement; no wasted motion",
        "high_levels": "Mechanical precision; almost robotic smoothness; occasionally unsettling"
      },

      "upgrade_dialogue": {
        "terminal_prompt": "Physical Compliance optimization initiated. Your body will remember its purpose.",
        "post_upgrade": "Calibration complete. Your physical responses have been aligned with institutional standards."
      },

      "cost_scaling": {
        "base_rt": 10,
        "per_level_increase": 5,
        "biographical_requirement": "Any entry (early levels) → Personal Attachment (mid) → Foundational Identity (high)"
      }
    },

    "cognitive_throughput": {
      "abbreviation": "CT",
      "traditional_equivalent": "Intelligence / Wisdom",
      "institutional_framing": "Processing capacity for sanctioned information streams.",

      "official_description": "Measures your ability to receive, integrate, and act upon approved knowledge. Higher levels enable faster learning of sanctioned skills and improved comprehension of official documentation.",

      "hidden_meaning": "How quickly you accept what you're told. How efficiently you replace personal understanding with institutional knowledge. How little you question before internalizing.",

      "mechanical_effects": [
        "Skill point acquisition rate (+5% per level)",
        "Ability cooldown reduction (+2% per level)",
        "Dialogue options available (+1 option per 5 levels)",
        "Ritual/protocol completion speed (+3% per level)"
      ],

      "visual_feedback": {
        "low_levels": "Character sometimes re-reads documents, asks clarifying questions to NPCs",
        "mid_levels": "Quick reading, efficient interaction; nods along with NPC explanations",
        "high_levels": "Finishes NPC sentences; skips tutorial text automatically; may speak in institutional phrases"
      },

      "upgrade_dialogue": {
        "terminal_prompt": "Cognitive Throughput enhancement beginning. Unnecessary thought patterns will be streamlined.",
        "post_upgrade": "Enhancement complete. Your mind now processes sanctioned information with optimal efficiency."
      },

      "cost_scaling": {
        "base_rt": 15,
        "per_level_increase": 7,
        "biographical_requirement": "Any entry (early) → Personal Attachment (mid) → Core Motivation (high)"
      }
    },

    "perceptual_alignment": {
      "abbreviation": "PA",
      "traditional_equivalent": "Perception / Awareness",
      "institutional_framing": "Degree of concordance between personal observation and documented reality.",

      "official_description": "Measures your ability to perceive events as they are officially recorded. Higher levels reduce dissonance between personal experience and institutional truth, enabling clearer focus on approved stimuli.",

      "hidden_meaning": "How well you see what you're supposed to see. How successfully the frame filters your raw perception. How completely you've surrendered the authority of your own eyes.",

      "mechanical_effects": [
        "Detection range for 'official' threats (+5% per level)",
        "Resistance to perception-altering effects (+3% per level)",
        "BUT: Reduced ability to notice 'unofficial' details (-2% per level at high values)",
        "Mirror-Walker/Aethel-Pact abilities become LESS effective against you (+4% resistance per level)"
      ],

      "visual_feedback": {
        "low_levels": "Character notices background details, looks at things not plot-relevant",
        "mid_levels": "Focused on objectives; ignores 'irrelevant' environmental details",
        "high_levels": "May not perceive certain objects/NPCs that the system doesn't acknowledge exist"
      },

      "special_mechanical_note": "At very high PA (15+), the player's HUD begins filtering information. Hidden items become harder to find. Resistance NPCs may become 'blurry' or hard to remember after conversations.",

      "upgrade_dialogue": {
        "terminal_prompt": "Perceptual Alignment calibration in progress. Extraneous sensory data will be deprioritized.",
        "post_upgrade": "Calibration complete. Your perception now aligns with documented reality standards."
      },

      "cost_scaling": {
        "base_rt": 15,
        "per_level_increase": 8,
        "biographical_requirement": "Personal Attachment (early) → Foundational Identity (mid) → Core Motivation (high)"
      }
    },

    "archival_efficiency": {
      "abbreviation": "AE",
      "traditional_equivalent": "Charisma / Luck (sort of)",
      "institutional_framing": "Facility with which personal data integrates into the Archive.",

      "official_description": "Measures your compatibility with Archival systems. Higher levels improve Recall Token yields from memory contribution, reduce Calibration side effects, and increase standing with documentation-oriented factions.",

      "hidden_meaning": "How easily you give yourself up. How smoothly your memories flow into the machine. How little of you remains that the system cannot process and file.",

      "mechanical_effects": [
        "Recall Token yield from memory surrender (+10% per level)",
        "Reduced negative effects from high-weight memory loss (+5% resistance per level)",
        "Improved prices/terms from Archive-adjacent NPCs (+3% per level)",
        "BUT: Increased susceptibility to Redactor abilities (-2% resistance per level)"
      ],

      "visual_feedback": {
        "low_levels": "Character flinches during Calibration animations; shows discomfort at Archive",
        "mid_levels": "Neutral expression; efficient interaction with archival systems",
        "high_levels": "Serene expression during memory surrender; may voluntarily offer memories in dialogue"
      },

      "special_mechanical_note": "At very high AE (15+), the character may occasionally 'volunteer' biographical information in NPC dialogue without player input. Small memories begin archiving automatically during sleep/rest cycles.",

      "upgrade_dialogue": {
        "terminal_prompt": "Archival Efficiency optimization engaged. Your integration with the system deepens.",
        "post_upgrade": "Optimization complete. The Archive welcomes your contribution. You are part of something larger now."
      },

      "cost_scaling": {
        "base_rt": 20,
        "per_level_increase": 10,
        "biographical_requirement": "Any (early) → Foundational Identity (mid) → Core Motivation OR Forbidden attempt (high)"
      }
    }
  }
}
```

---

## 5.3 THE TRAP OF PROGRESSION

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                       DESIGNER NOTE — THE TRAP                            ║
╠═══════════════════════════════════════════════════════════════════════════╣
║                                                                           ║
║  The stat system is designed to make the player feel the contradiction    ║
║  between "getting stronger" and "losing themselves."                      ║
║                                                                           ║
║  At low levels, the benefits are obvious and the costs seem minor.        ║
║  A childhood friend? I can sacrifice that for more health.                ║
║                                                                           ║
║  At mid levels, the costs become more noticeable. Wait, I can't do        ║
║  that quest anymore? That NPC doesn't recognize me?                       ║
║                                                                           ║
║  At high levels, the character begins acting on their own. They speak     ║
║  in institutional phrases. They don't notice things. They volunteer       ║
║  information. The player has optimized themselves into a tool.            ║
║                                                                           ║
║  The key insight: THE NUMBERS GO UP. The player "wins" mechanically.      ║
║  But narratively, they have lost. They traded their soul for stats.       ║
║                                                                           ║
║  This should provoke reflection:                                          ║
║  - Is "optimal" the same as "good"?                                       ║
║  - What am I willing to trade for power?                                  ║
║  - If I'm not who I was, am I still "me"?                                 ║
║                                                                           ║
║  The system never forces. It only offers. That's the horror.              ║
║                                                                           ║
╚═══════════════════════════════════════════════════════════════════════════╝
```

---

## 5.4 STAT DISPLAY — VISUAL DESIGN

### Standard Display (Main Menu / Pause Screen)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │  [CHARACTER NAME]                          CALIBRATION INDEX: 30    │    │
│  │  ─────────────────────────────────────────────────────────────────  │    │
│  │                                                                     │    │
│  │  PHYSICAL COMPLIANCE        [████████░░░░░░░░░░░░]  08/20          │    │
│  │  "Your body performs its duties adequately."                        │    │
│  │                                                                     │    │
│  │  COGNITIVE THROUGHPUT       [██████░░░░░░░░░░░░░░]  06/20          │    │
│  │  "Your processing of sanctioned information is developing."         │    │
│  │                                                                     │    │
│  │  PERCEPTUAL ALIGNMENT       [████████████░░░░░░░░]  12/20          │    │
│  │  "Your perception increasingly matches documented reality."         │    │
│  │                                                                     │    │
│  │  ARCHIVAL EFFICIENCY        [████░░░░░░░░░░░░░░░░]  04/20          │    │
│  │  "Your integration with archival systems requires improvement."     │    │
│  │                                                                     │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                                                             │
│  BIOGRAPHICAL INTEGRITY: ████████████████░░░░ 78%                           │
│  (Entries Remaining: 14/18)                                                 │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Degraded Display (After Heavy Redaction)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │  [CHARACTER NAME]                          CALIBRATION INDEX: 67    │    │
│  │  ─────────────────────────────────────────────────────────────────  │    │
│  │                                                                     │    │
│  │  PHYSICAL COMPLIANCE        [██████████████████░░]  18/20          │    │
│  │  "Your body serves the institution without hesitation."             │    │
│  │                                                                     │    │
│  │  COGNITIVE THROUGHPUT       [████████████████░░░░]  16/20          │    │
│  │  "Your mind accepts sanctioned patterns with minimal resistance."   │    │
│  │                                                                     │    │
│  │  PERCEPTUAL ALIGNMENT       [██████████████████░░]  18/20          │    │
│  │  "You see what is documented. This is clarity."                     │    │
│  │                                                                     │    │
│  │  ARCHIVAL EFFICIENCY        [██████████████░░░░░░]  15/20          │    │
│  │  "The Archive knows you well. You are becoming part of it."         │    │
│  │                                                                     │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                                                             │
│  BIOGRAPHICAL INTEGRITY: ████░░░░░░░░░░░░░░░░ 22%                           │
│  (Entries Remaining: 4/18)                                                  │
│                                                                             │
│  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  │
│  NOTE: High Calibration Index detected. Character voice patterns and       │
│  autonomous behaviors may be affected. This is optimal functioning.        │
│  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Note:** The descriptions become progressively more disturbing as stats increase. At maximum levels, they're openly describing the character as an institutional tool, but framed positively.

---

# ═══════════════════════════════════════════════════════════════════════════
# SECTION VI: TECHNICAL IMPLEMENTATION NOTES
# ═══════════════════════════════════════════════════════════════════════════

## 6.1 GODOT IMPLEMENTATION GUIDANCE

```gdscript
# RedactionChamber.gd — Core terminal controller

extends Control

# Visual effect shaders
const SCANLINE_SHADER = preload("res://shaders/crt_scanlines.gdshader")
const PHOSPHOR_GLOW_SHADER = preload("res://shaders/phosphor_bloom.gdshader")
const SCREEN_CURVE_SHADER = preload("res://shaders/barrel_distortion.gdshader")

# Audio resources
const SFX_KEY_PRESS = preload("res://audio/sfx/terminal_keypress.ogg")
const SFX_CONFIRM = preload("res://audio/sfx/terminal_confirm.ogg")
const SFX_WARNING = preload("res://audio/sfx/terminal_warning.ogg")
const SFX_REDACTION = preload("res://audio/sfx/redaction_stamp.ogg")
const SFX_BREACH = preload("res://audio/sfx/security_breach.ogg")
const AMB_TERMINAL_HUM = preload("res://audio/ambient/terminal_hum.ogg")

# State machine
enum TerminalState {
    BOOT,
    MAIN_MENU,
    STAT_SELECT,
    MEMORY_SELECT,
    CONFIRMATION,
    REDACTING,
    BREACH_WARNING,
    BREACH_EVENT,
    LOCKDOWN,
    SHUTDOWN
}

var current_state: TerminalState = TerminalState.BOOT
var selected_stat: String = ""
var selected_memory: Dictionary = {}
var breach_triggered: bool = false

# Biography data reference
@onready var biography_manager = get_node("/root/BiographyManager")
@onready var player_stats = get_node("/root/PlayerStats")
@onready var recall_token_manager = get_node("/root/RecallTokenManager")

func _ready():
    # Apply CRT visual effects
    apply_crt_effects()
    # Start ambient audio
    $AmbientHum.stream = AMB_TERMINAL_HUM
    $AmbientHum.play()
    # Begin boot sequence
    start_boot_sequence()


func apply_crt_effects():
    $ScreenContainer.material.shader = SCANLINE_SHADER
    $ScreenContainer.material.set_shader_parameter("scanline_opacity", 0.15)
    $ScreenContainer.material.set_shader_parameter("scanline_spacing", 2.0)
    # Additional effect layering...


func start_boot_sequence():
    current_state = TerminalState.BOOT
    var boot_lines = [
        {"text": "INITIALIZING MEMORY INTERFACE...", "delay": 0.8},
        {"text": "[OK]", "delay": 0.3, "append": true},
        {"text": "LOADING BIOGRAPHICAL DATABASE...", "delay": 1.0},
        {"text": "[OK]", "delay": 0.3, "append": true},
        {"text": "CALIBRATING EXTRACTION PROTOCOLS...", "delay": 0.7},
        {"text": "[OK]", "delay": 0.3, "append": true},
        {"text": "VERIFYING ETHICS COMPLIANCE...", "delay": 1.2},
        {"text": "[OK]", "delay": 0.3, "append": true},
        {"text": "CONNECTING TO CENTRAL ARCHIVE...", "delay": 0.9},
        {"text": "[OK]", "delay": 0.3, "append": true},
    ]
    await display_boot_sequence(boot_lines)
    transition_to_main_menu()


# Redaction animation system
func perform_redaction_animation(memory_entry: Dictionary):
    current_state = TerminalState.REDACTING

    var original_text = memory_entry.content
    var redacted_text = generate_redacted_text(original_text)

    # Phase 1: Acknowledgment
    await display_acknowledgment_screen()

    # Phase 2: Scanning animation
    await animate_scanning_line(original_text)

    # Phase 3: Progressive redaction
    await animate_progressive_redaction(original_text, redacted_text)

    # Phase 4: Completion
    await display_completion_screen(memory_entry.title)

    # Apply actual changes
    apply_redaction_effects(memory_entry)


func generate_redacted_text(original: String) -> String:
    var result = ""
    var words = original.split(" ")

    for word in words:
        # Preserve punctuation, redact content
        var clean_word = word.strip_edges()
        var punctuation = ""

        # Extract trailing punctuation
        while clean_word.length() > 0 and not clean_word[-1].is_valid_identifier():
            punctuation = clean_word[-1] + punctuation
            clean_word = clean_word.substr(0, clean_word.length() - 1)

        # Determine if word should be redacted (weighted random)
        # Emotional words, names, places are more likely to be redacted
        var redaction_chance = calculate_redaction_chance(clean_word)

        if randf() < redaction_chance:
            result += "█".repeat(clean_word.length()) + punctuation + " "
        else:
            result += word + " "

    return result.strip_edges()


func calculate_redaction_chance(word: String) -> float:
    # Higher chance for emotionally significant words
    var emotional_words = ["love", "hate", "fear", "hope", "promise", "remember",
                          "mother", "father", "friend", "home", "heart", "soul"]

    if word.to_lower() in emotional_words:
        return 0.95  # Almost always redact emotional words
    elif word.length() > 6:
        return 0.7   # Longer words more likely
    elif word[0].to_upper() == word[0]:
        return 0.85  # Proper nouns (names, places) very likely
    else:
        return 0.4   # Base chance for common words


# Breach event handling
func trigger_breach_event(forbidden_entry: Dictionary):
    breach_triggered = true
    current_state = TerminalState.BREACH_EVENT

    # Phase 1: Warning
    await display_breach_warning()

    # If player confirms...
    if await get_player_breach_confirmation():
        # Phase 2: Attempt and fail
        await animate_breach_attempt()

        # Phase 3: System breakdown
        await animate_system_breakdown()

        # Phase 4: Brief reveal
        var revealed_fragment = get_breach_reveal_fragment(forbidden_entry)
        await display_breach_reveal(revealed_fragment)

        # Phase 5: Lockdown
        await initiate_lockdown()

        # Apply consequences
        apply_breach_consequences(forbidden_entry)
```

## 6.2 BIOGRAPHY ENTRY DATA STRUCTURE

```gdscript
# BiographyEntry.gd — Data class for biographical entries

class_name BiographyEntry
extends Resource

@export var id: String
@export var title: String
@export var category: String  # PERSONAL_ATTACHMENT, FOUNDATIONAL_IDENTITY, CORE_MOTIVATION, FORBIDDEN
@export var weight: String    # MINOR, MODERATE, SIGNIFICANT, CRITICAL, UNDEFINED
@export_multiline var content: String
@export_multiline var redacted_content: String  # Pre-generated or generated on redaction
@export var is_redacted: bool = false
@export var redaction_cycle: int = -1  # When was it redacted
@export var is_restricted: bool = false
@export var is_forbidden: bool = false

# Associated game elements
@export var associated_items: Array[String] = []
@export var associated_npcs: Array[String] = []
@export var associated_locations: Array[String] = []
@export var associated_quests: Array[String] = []
@export var associated_endings: Array[String] = []

# Post-redaction notes
@export_multiline var post_redaction_note: String  # "I have this ribbon. I don't remember why..."

# Mechanical consequences
@export var on_redaction_effects: Array[Dictionary] = []
# Example: [{"type": "remove_item_bonus", "item": "ribbon", "stat": "luck", "amount": 5}]


func generate_redacted_title() -> String:
    if is_redacted:
        return _apply_redaction_to_text(title, 0.6)
    return title


func _apply_redaction_to_text(text: String, intensity: float) -> String:
    var result = ""
    for character in text:
        if character == " ":
            result += " "
        elif randf() < intensity:
            result += "█"
        else:
            result += character
    return result
```

---

# ═══════════════════════════════════════════════════════════════════════════
# DOCUMENT FOOTER
# ═══════════════════════════════════════════════════════════════════════════

```
This manual constitutes the complete operational specification for the
MK-IV Redaction Terminal. All personnel are expected to familiarize
themselves with these protocols before operating the system.

BOARD OF ETHICS REMINDERS:

1. The terminal facilitates voluntary improvement. Subjects choose to
   participate. Their choice is documented. Their consent is recorded.

2. Memory archival is preservation, not destruction. Nothing is lost.
   Nothing is ever truly lost. The Archive remembers, even when the
   subject does not.

3. Statistical improvement is objectively measurable. The numbers do not
   lie. If a subject is "better" after Calibration, the process worked.
   Questions of identity are philosophically interesting but operationally
   irrelevant.

4. The Breach protocols exist for the subject's protection. Forbidden
   entries are forbidden because they contain information that would cause
   harm. We restrict access out of kindness.

5. If a subject expresses regret after archival, remind them: the person
   who might have regretted no longer exists. The current subject is
   improved. There is no one to feel regret.

The Archive preserves.
The Terminal optimizes.
The Subject improves.

This is the purpose.

— Board of Ethics, The Redactors
   "Improvement Through Archival"

END OF MANUAL.
```

---

*[Found wedged behind the terminal, written on torn Archive paper]:*

```
Whoever reads this—

The emergency abort button works. They don't tell you, but it works.
You can stop mid-process. You can walk away. You can refuse.

The numbers aren't worth it. I know they feel like they are.
I know the game tells you to optimize. I know it feels like
winning.

It's not winning.

I gave up my sister for +3 Perceptual Alignment. I don't
remember her name anymore. I don't remember her face. I just
know I had one. I know there's a hole.

The hole is shaped like her. And nothing fits in it. And the
numbers don't fill it. And I can't get her back.

Don't be me.

Keep the memories. Even when it's hard. Even when they weigh
you down. The weight is proof you lived.

The lightness they promise?

It's not freedom.

It's emptiness.

— Someone who used to be whole
```
