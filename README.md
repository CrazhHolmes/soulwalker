# Soulwalker

A mystical 2D top-down RPG built with Godot 4.5, featuring enterable buildings, merchant interactions, and a trust-based progression system.

## 🎮 Game Concept

Explore the Sanctuary - a mysterious realm where three arcane merchants offer guidance, artifacts, and secrets. Each merchant represents a different path of esoteric knowledge:

- **Apothecary** - Folk magic, herbs, physical artifacts
- **Archivist** - Secrets, documents, mind control  
- **Gatekeeper** - Rituals, astral projection, gateways

## 🗂️ Project Structure

```
soulwalker/
├── actors/
│   └── player/           # Player character (CharacterBody2D)
├── autoload/
│   ├── GameState.gd      # Global game state, vendor trust
│   ├── SceneLoader.gd    # Scene loading utilities
│   └── SceneTransition.gd/.tscn  # Fade transitions
├── scenes/
│   ├── interiors/        # Building interior scenes
│   │   ├── InteriorBase.gd
│   │   ├── InteriorMerchant.gd
│   │   ├── ApothecaryInterior.tscn
│   │   ├── ArchivistInterior.tscn
│   │   └── GatekeeperInterior.tscn
│   ├── ui/               # UI scenes (title, menus)
│   └── world/            # World scenes
│       ├── WorldScene2D.tscn    # Main world hub
│       └── WorldScene2D.gd
├── systems/
│   └── interact/         # Interaction scripts
│       ├── BuildingEntrance.gd  # Building door triggers
│       ├── ExitDoor.gd          # Interior exit triggers
│       └── Interactable.gd      # Base interactable
└── Sprites/              # Image assets
```

## 🎯 Core Systems

### Vendor Trust System
Each merchant has a trust level that increases through interactions:
```gdscript
GameState.vendor_trust = {"apothecary": 0, "archivist": 0, "gatekeeper": 0}
```

### Scene Transitions
Smooth fade transitions when entering/exiting buildings:
```gdscript
SceneTransition.transition_to("res://path/to/scene.tscn")
```

### Building Entry
Walk to a building door and press E to enter. Press E at exit door to return.

## 🕹️ Controls

| Action | Key |
|--------|-----|
| Move | WASD / Arrow Keys |
| Interact | E / Space |

## 🚀 Running the Project

1. Open with Godot 4.5+
2. Press F5 or click Play

## 📋 Development Notes

- Main scene: `res://scenes/ui/TitleScene.tscn`
- World hub: `res://scenes/world/WorldScene2D.tscn`
- Player is in `"player"` group for detection

## 🔮 Planned Features

- [ ] Expanded world landscape with multiple areas
- [ ] Day/night cycle
- [ ] Merchant inventory and services
- [ ] Quest system
- [ ] Save/load functionality
