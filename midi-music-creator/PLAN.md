# MIDI Music Creator — Implementation Plan

A browser-based music creation app delivered as a **single self-contained HTML file**
(`midi-music-creator/index.html`). No build step, no external dependencies, no network
access required — open it in any modern browser and start composing.

## Decisions (locked in)

| Area | Choice |
|---|---|
| Sound engine | Web Audio API synthesis (oscillators + envelopes + filters) |
| Composer UI | Piano roll editor |
| Save/export | Project JSON, Standard MIDI (.mid), WAV render, MP3 |
| Packaging | One self-contained `.html` file, vanilla JS/CSS embedded |

## 1. Data model

Everything the app knows about a song lives in one serializable `project` object —
this is also exactly what gets saved as the project file.

```js
project = {
  version: 1,
  name: "Untitled",
  tempo: 120,              // BPM
  timeSignature: [4, 4],
  ppq: 480,                // ticks per quarter note (MIDI-friendly)
  loop: { enabled: false, startTick, endTick },
  tracks: [{
    id, name, color,
    instrument: "piano",   // preset id
    volume: 0.8, pan: 0,
    mute: false, solo: false,
    notes: [{ pitch: 60, startTick, durationTick, velocity: 100 }]
  }]
}
```

Using ticks (not seconds) as the time unit makes tempo changes lossless and makes
MIDI export a direct mapping.

## 2. Synth engine (Web Audio)

- **Voice = one note**: oscillator(s) → ADSR gain envelope → lowpass filter → track bus.
- **Instrument presets** defined as data (waveform mix, detune, ADSR, filter, optional
  vibrato/noise): Piano-ish, Electric Piano, Organ, Saw Lead, Square Lead, Synth Bass,
  Strings Pad, Pluck, Bells, plus a **drum kit** (kick/snare/hat/tom synthesized from
  noise bursts and pitched sine drops, mapped to standard GM drum notes).
- **Per-track bus**: GainNode (volume) → StereoPannerNode (pan) → master.
- **Master chain**: master gain → soft limiter (DynamicsCompressorNode) → destination,
  with a simple send reverb (ConvolverNode with a generated impulse response).
- Same engine runs in real time *and* inside an `OfflineAudioContext` for rendering,
  so the WAV/MP3 export sounds identical to playback.

## 3. Transport & scheduling

- Lookahead scheduler (the standard "Tale of Two Clocks" pattern): a ~25 ms timer
  schedules all notes falling in the next ~120 ms at sample-accurate Web Audio times.
  Immune to UI jank.
- Play / pause / stop, loop region, adjustable tempo, metronome click.
- Playhead drawn via `requestAnimationFrame`, decoupled from audio timing.

## 4. Piano roll UI

Canvas-based for performance (hundreds of notes, smooth zoom/scroll).

- **Layout**: piano keyboard column on the left (clickable to audition pitches),
  bar/beat ruler on top, scrollable note grid; pitch range ~C1–C8.
- **Editing**:
  - Click empty cell → add note at current grid snap and default length.
  - Drag note → move (pitch + time); drag its right edge → resize (**note length**).
  - Drag on empty space → rubber-band multi-select; Delete removes selection.
  - Snap selector: 1/1 … 1/32 incl. triplets, or off.
  - **Velocity lane** under the grid: drag bars to shape per-note loudness (tone/dynamics).
  - Zoom horizontal/vertical; scroll via wheel/drag.
- **Tracks panel** (left sidebar): add/remove/rename tracks, instrument picker,
  volume/pan sliders, mute/solo, track color. Piano roll edits the selected track and
  ghosts the others faintly for context.
- **Undo/redo** (Ctrl+Z / Ctrl+Shift+Z) via snapshot stack of the project object.
- Keyboard shortcuts: space = play/stop, arrows nudge selection, Ctrl+C/V copy/paste.

## 5. File I/O

All saves are client-side downloads (Blob + `<a download>`); loads via file picker
and drag-and-drop onto the window.

1. **Project file `.mmcproj` (JSON)** — serialize the `project` object verbatim;
   loading restores the exact editing session ("pick up where I left off").
   Plus **autosave to `localStorage`** every few seconds with a restore prompt on launch.
2. **Standard MIDI `.mid`** — hand-written SMF Type 1 encoder: tempo/time-signature
   meta track + one track per app track, note-on/off with velocity, PPQ 480, drum
   track on channel 10. Opens in any DAW. (MIDI *import* is a stretch goal.)
3. **WAV** — render the whole song through `OfflineAudioContext`, encode 16-bit PCM
   stereo WAV in ~40 lines of hand-written code.
4. **MP3** — feed the same rendered PCM into an embedded minified copy of the
   `lamejs` encoder (~the one sizeable embedded chunk, ±150 KB; LGPL — fine for a
   personal tool, license header kept in the file).

## 6. Build order (milestones)

Each milestone leaves a working app.

1. **Core playback** — HTML skeleton, data model, synth voice + 3 presets, lookahead
   scheduler, minimal piano roll (add/move/resize/delete, snap), single track,
   play/stop. *The fun is already here.*
2. **Full editor** — multi-track + tracks panel, full preset set + drum kit,
   velocity lane, multi-select/copy/paste, undo/redo, loop region, zoom, metronome.
3. **Save & export** — project JSON save/load + autosave, MIDI export, WAV render.
4. **Polish & extras** — MP3 export (embed lamejs), MIDI import, on-screen/computer
   keyboard live input, nicer theming.

## 7. Risks & notes

- **Autoplay policy**: browsers require a user gesture before audio — AudioContext is
  created/resumed on first click (standard handling, just must not be forgotten).
- **File size**: app code ~100–150 KB; MP3 encoder roughly doubles it. Still a single
  portable file.
- **Canvas hit-testing** (note edges, selection) is the fiddliest UI code — isolated
  behind a small geometry helper so it stays testable.
- Works in current Chrome/Edge/Firefox/Safari; no server, fully offline.
