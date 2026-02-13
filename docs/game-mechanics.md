# Game Mechanics

## Core Mechanics

### Oxygen / Tether (d)
- Jet is able to walk untethered for a specified amount of time depending on canister capacity (might be upgradeable)
- **Current concern**: If Jet can breathe without a tether for any amount of time, the time would have to be pretty short to make the tether mechanic actually make sense. Unless there's a way to limit how often you can untether, this won't work great.

> **Status**: Tether system is implemented as the core constraint. Verlet rope physically limits player movement. Each post provides a one-time oxygen burst on connection.

## Companion Mechanics (Bot)

### Fog Clearing (a)
- Bot has a device to blow fog away and reveal more of the map

### Jump/Throw (b)
- Bot can throw Jet in certain situations (e.g., throwing over gaps)

### Battery Limitation (c)
- Bot has a battery pack that only allows him to travel so far
- When batteries run out, he uses remaining juice to RTB (return to base) via the quickest route

### Bot's Secret
- Bot was originally created by Jet's mom and specifically designed to help Jet
- Jet's mom wanted to send a message back to Jet but never could — she created a disc that could only be played by Bot. Meant to be found eventually.
- Could have message pieces scattered throughout the game as a **side mission** (collect each piece on each level to play on the sub-story)

## Puzzle Mechanics

### Ice (e)
- Planet(s) have ice which cracks if you walk over them too much — forces path planning
- Sliding on ice prevents normal movement — have to complete a slide before changing directions

### Sliding Rocks (f)
- Sliding rocks/terrain can be moved
- Allows Jet to open up paths for Bot
- May require Jet to rearrange the map to access necessary elements

### Portals/Teleportation (g)
- Portals as an additional puzzle element
- Random switcher — not always attached to same end. Use lights as indicators.

### Pressure Plates (h)
- Used in various puzzles to open doors / activate other elements
- Could be the main transition mechanic between puzzles:
  - One or two plates must be activated to reach the next puzzle
  - Small plate for Jet, larger plate for Bot — forces specific starting positions in the next puzzle area

### Lasers (i)
- Self-explanatory

### Mirrors
- Likely paired with lasers for reflection puzzles

### Rotating Pieces
- TBD

### Spinning Wheel
- TBD

### One-Way Paths/Entrances
- Paths that can only be traversed in one direction

## Meta Mechanics

### Timer (j)
- Aside from the battery mechanic, could have a race-like sequence where Jet is trying to get back to the ship ASAP because of aliens chasing him

### Map (k)
- Level-wide mechanic to give the player hints throughout the level
- Could also make the level somewhat mysterious and help drive the story
