# Level Design

> Hand-drawn room layouts and puzzle maps are saved in [pdfs/](../pdfs/). `OneNote.pdf` has level layouts for Mars, Deimos, Ceres, and Asteroid Belt. `onenoteframe.aspx.pdf` has numbered puzzle walkthrough maps.

## Design Principles

- Have one main harder puzzle near the end of each level/map
- Vary up each sub-area within a level — even if portions use the same mechanic, each should differ in sub-elements (e.g., on Mars, mostly type 0/1 map designs but each should include pressure plates, lasers, throwing, etc.)
- Each level uses some combination (not all) of mechanics introduced in previous levels, plus at least one new mechanic

---

## Intro — Moon

### Mechanics Introduced
- Tether (Jet is tethered to the ship, can't go further unless untethered)
- Consider intro-ing the ability to untether and use oxygen pack
- Switch characters to play as Bot — walk over to next tether and bring back to Jet
- Simpler puzzles to get player used to main mechanics
- Implement a trivially easy pressure plate or two — just to introduce the mechanic for later use

### Background
- Introduce the storyline and demonstrate gameplay
- Travel to the moon as a pit stop before exploring the universe
- Pick up some slim jims & moon cheese
- Jet finds an interesting piece that looks familiar but doesn't know why (used later to unlock messages)

### Goals
- Tutorial: teach the player about oxygen, food, and basic survival
- Get food from the pit stop

### Design Walkthrough

1. **Landing**: You land on the moon, step out of the shuttle and immediately die — need to put on your helmet, dummy
   - When that info is given, tell the player the ship is a "restore point" — if you need oxygen/whatever, just go back to the ship. That way when done at the pit stop, the player knows to head back.

2. **Finding food**: Go to pick up food from pit stop — door is locked. Have to find crowbar to break in.
   - Ship Robot dialog welcomes you to the moon
   - Nobody is in the pit stop because there's no space travel anymore

3. **Oxygen tutorial**: Need to find oxygen/food on the way or you die. Guide with terrain/fences.
   - Have oxygen canisters within sight in the intro so the player sees them and investigates
   - After collecting the first canister, play small noise and display message: "That thing I just picked up seems to give me more oxygen. Better keep finding them..."

4. **Return**: After getting food, Bot tells you it's time to get back on the ship and fly to the next stop
   - Either have more oxygen canisters on the way back or not — the player should know after dying once that they can walk back to the ship as long as they don't run out

### Sample Dialogue

> **Bot**: Welcome to the moon, Cadet. Why are we stopping? Ship's destination is Mars.
>
> **Jet**: Cmon Bot, we had to make a pit stop for the ultimate travel snack.
>
> **Bot**: Snacks?
>
> **Jet**: Indeed my metal friend! And nothing hits the spot during space travel like slim jims and moon cheese. It's my Rocket fuel!
>
> **Bot**: Humans don't require Rocket fuel for survival.
>
> **Jet**: It's Rocket fuel for my soul, Bot.
>
> **Bot**: What evidence has been procured that humans have souls? And that soul sustenance is slim jims and moon chee—
>
> **Jet**: Shut it! What are you, a recycled Feel-bot? I refuse to debate philosophy on an empty stomach. Onward to my precious slims!
>
> **Bot**: Don't forget hel—
>
> **Jet**: Hell!? Did you not just hear me?! No slims, no soul talk! Ship, open the side hatch! I always wanted my moon landing to be the Hero entrance! Like in the old Avengers!
>
> **Bot**: But you nee—
>
> **Jet**: Not butt! You're supposed to land on your knee, supposedly less painful. Well here it goes. Moon, your hero is her— *gag gag fall bleh...* (Jet dies and respawns)
>
> **Bot**: A helmet is necessary for human survival on the moon's surface. Helps maintain proper oxygen levels in your suit. I thought this was obvious to you.
>
> **Ship**: To help you better understand, I will reference a historical 'meme'. Congratulations, you played yourself.

---

## Cinematic: Moon to Mars
- Dialog with Bot or Lizz about what to do on Mars

---

## Level 1 — Mars

### Mechanics Introduced
- Sliding rock mechanic (not as direct puzzles yet, but to allow Bot to travel more freely)
- Encourage untethered movement to make it more interesting
- More complex pressure plate puzzles
- Jet finds a laser gun — used to fight off aliens
- **Backtracking solutions** (pick one):
  - Can only travel back after completing puzzle? Pressure plate at end activates door near opening that you can walk towards (untethered) with just enough time to get back
  - Tether at the end of each "objective" puzzle is only reachable after going through the puzzle. After reaching it, the length is long enough to make it back to previous checkpoint. Some corridors won't allow Bot to travel through depending on the goal.

### Background
- Introduce shooting mechanic here?
- This level is a bit empty right now. Maybe first alien interaction: player finds little alien being attacked by bigger creatures.
  - Player can shoot at bigger creatures and save the alien's life
  - Alien looks at player then scampers off — could come up later in the story (alien returns with bigger buddies to save you)
- After complete, begin traveling to Deimos (moon of Mars). Lizz says a probe carrying food and emergency supplies crashed here in 2068.

### Goals
- Get the last hypercore for the Solar drive to travel at Lightspeed (4 pieces make the entire hypercore)
- Collect oxygen canisters along the way (checkpoints)

### Limitations
- Collect hypercore in 4 pieces, carry 2 at a time
- Oxygen limitation

### Design Walkthrough
1. Land on Mars. Bot reminds you mockingly to not forget your helmet.
2. Dialog with Bot reminding you what you need to do.
3. Walk through the level searching for hypercore pieces — no survival reminders needed (taught in Intro).
4. After reaching the cave, short dialog/cinematic about the small creature being attacked. Continue displaying dialog indicating the creature is in pain — should prompt the player to help.

---

## Cinematic: Mars to Deimos
- Dialog with Lizz about what you've done and what you're planning on doing

---

## Level 2 — Deimos

### Mechanics Introduced
- Build upon sliding rock mechanic with actual sliding rock puzzles
- Introduce the oxygen area idea (use one as a place where the food was supposed to be)
- Use newly acquired laser gun to fight off bad aliens
- Use map design #5 as end puzzle

### Background
- Find source of sustenance — get enough food to last the rest of exploration
- Discover probe has been pilfered. Follow footprints in moondust to caves where food packages are hanging on walls like paintings. Collect food packs.

### Goals
- Eventually find enough food, fill up space ship and continue traveling

### Limitations
- Discover alien beasts in cave attempting to kill you on your way out
- Oxygen limitation

### Design Walkthrough
1. Land on Deimos, use tracker to find weak emergency signal toward the probe
2. Signal leads through a cave — encounter hostile aliens
   - Quick on-screen dialog/sounds indicating hostility
   - Aliens start charging and attacking
3. After defeating aliens, signal leads to the pilfered probe
   - Dialog with character talking to himself / radio back to Lizz
4. Leave cave to continue looking for food
5. Encounter more aliens throughout the level
6. Keep searching until "food meter" is filled
7. Quick way back to ship (e.g., cave opening near landing site) instead of backtracking

---

## Cinematic: Deimos to Ceres
- Dialog with Lizz — talk about what to do next (video footage)
- Look out the window at the asteroid belt
- Maybe have difficulty landing / dialog about where to land

---

## Level 3 — Ceres

### Mechanics Introduced
- Ceres is a small moon, so nothing major — not too difficult to get to despite being in the asteroid belt
- Ship doesn't get damaged until flying to the next asteroid (next level)

### Background
- Scout the Asteroid Belt (God's Belt / Satan's Belt) for a clear flight path
- Maybe have to land on 2-4 different asteroids
- Salvaged logs reveal Gyarados 3 made it farther than the first 2, but radars lost sight after the halfway point

### Goals
- Download video/camera footage from the Telescope Tower to compile 20+ years of asteroid belt data for a clear flight path / best departure time

### Limitations
- En route to tower, overwhelmingly vulnerable — unable to defend yourself against native hostile creatures/aliens

### Design Walkthrough
1. Get reminder to start looking for the telescope tower
2. Find a scratched-up sign — at first might indicate telescope tower but could be a depot (mislead the player)
3. Encounter hostile aliens
4. Find a locked door that might lead to the tower
   - Find key to open (can also shoot the door open — no hints about this, it's too easy!)
5. Travel up stairs (small cinematic)
6. Reach top level — creepy abandoned telescope tower (flickering lights, creepy music)
   - Encounter hostile aliens
   - Oxygen refill stations in the tower
   - Maybe one malfunctions when you need it most (during a fight) — then after surviving, find another that works

---

## Cinematic: Ceres to Asteroid Belt

---

## Level 4 — Asteroid Belt Flight

### Mechanics Introduced
- Emergency land on first asteroid after ship is damaged by debris
- Find alien markings that direct to another asteroid where aliens may inhabit that can help

### Background
- Reveal to Lizz that your mom was Slyfer, Commander of Gyarados 3. You swear she was too good of a pilot to be destroyed by asteroids. You theorize comms dropped because of the debris in the belt.
- As you see clear space ahead, your ship's wing is clipped by a rock — forced to land on Jupiter
- Friendly aliens help you devise a ship forcefield for asteroid travel

### Goals
- Dodge rocks

### Limitations
- Rocks

---

## Level 5 — Jupiter

### Mechanics Introduced
- No solid surface on Jupiter; gravity is 2.5x Earth
- Flying fortresses (like Cloud City in Star Wars)
- Portals to gain access to parts of the map
- Rearrange cables/chutes that connect each floating mass

### Background
- Repair ship wing
- Dialogue: Jet is super pumped to make it through, then ship scanner picks up signal of emergency beacon from Gyarados 3
- Introduce planet vehicle or setting up refill stations
- Find notes/journal/files saying Mom took a shuttle to Saturn. Why would she go there?
- Notes about Super Light?

### Goals
- Make your way to ruined ship, searching for clues of your mother's disappearance

---

## Level 6 — Saturn

### Mechanics Introduced
- Fog mechanic (nice transition after gassy Jupiter where you couldn't circumvent cloudy areas)
- Begin introducing ice mechanic (not fully, since Uranus is colder/more icy)

### Background
- Searching for the signal of the shuttle
- Make contact with the Saturnites — alien race that made a deal with the Gyarados crew to provide hyperspace travel in return for collecting materials:
  - Uranus soil
  - Neptune fluid
  - Plutons (ice cold enough to keep temperatures stable)

### Goals
- Make contact with the Saturnites

---

## Level 7 — Uranus

### Mechanics Introduced
- Ice planet — most of the level has ice ground with cracks

### Goals
- Get soil

---

## Level 8 — Neptune

### Mechanics Introduced
- Strong winds — maybe create a mechanic based on that

### Goals
- Get fluid

---

## Level 9 — Pluto

### Background
- Discover Plutons — ice natural to Pluto, cold enough to keep the Hyperdrive at stable temperature for a Hyper Lightspeed Jump

---

## Level 10 — Return Flight (Hyper Lightspeed Jump)

### Background
- Dodge space debris and asteroids to return to earth and bury your mom's remains next to your dad's

---

## Open Questions

- How will we implement story on screen? Screen montage replay system for cinematic?
- At what point will story interact with character? Speech bubbles? Wall of text?
- Every time the player travels on the ship, Lizz can send a transmission to give the player an update on the mission and/or info to help with the next level
- Is the bot the player's companion throughout?
