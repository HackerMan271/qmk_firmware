// ─── Game state ──────────────────────────────────────────────

const CHARACTERS = [
  { id: 'riley', name: 'Riley', avatar: '🎮', color: '#ff73a8', label: 'pink'   },
  { id: 'kai',   name: 'Kai',   avatar: '🖊️',  color: '#a673ff', label: 'purple' },
  { id: 'ash',   name: 'Ash',   avatar: '💅', color: '#4da8ff', label: 'blue'   },
];

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

class GameState {
  constructor() {
    this._chars = CHARACTERS.map(c => ({
      ...c,
      affinity:   0,
      currentNode: STORY_DATA[c.id].start,
      messages:   [],
      hasUnread:  true,
    }));
    this.screen     = 'home';   // 'home' | 'messages' | 'chat'
    this.chatID     = null;
    this.isTyping   = false;
    this.choices    = [];
    this._listeners = {};
    this._typing    = null;     // AbortController for ongoing typing
  }

  // ── Pub/sub ────────────────────────────────────────────
  on(event, fn) {
    (this._listeners[event] ??= []).push(fn);
  }
  _emit(event, data) {
    (this._listeners[event] ?? []).forEach(fn => fn(data));
  }

  // ── Accessors ──────────────────────────────────────────
  get chars() { return this._chars; }

  char(id) { return this._chars.find(c => c.id === id); }

  charColor(id) {
    return CHARACTERS.find(c => c.id === id)?.color ?? '#fff';
  }

  affinityLabel(c) {
    if (c.affinity < 0)   return 'Awkward';
    if (c.affinity < 3)   return 'Strangers';
    if (c.affinity < 6)   return 'Acquaintances';
    if (c.affinity < 10)  return 'Friends';
    if (c.affinity < 15)  return 'Close';
    return 'Besties 💕';
  }

  affinityPct(c) {
    return Math.min(100, Math.max(0, (c.affinity / 15) * 100));
  }

  unreadCount() {
    return this._chars.filter(c => c.hasUnread).length;
  }

  // ── Navigation ─────────────────────────────────────────
  goHome() {
    this._cancelTyping();
    this.screen = 'home';
    this._emit('navigate', { screen: 'home', dir: 'back' });
  }

  goMessages() {
    this._cancelTyping();
    this.screen = 'messages';
    this._emit('navigate', { screen: 'messages', dir: this.screen === 'chat' ? 'back' : 'forward' });
  }

  openChat(id) {
    const c = this.char(id);
    if (!c) return;
    c.hasUnread = false;
    this.chatID = id;
    this.screen = 'chat';
    this._emit('navigate', { screen: 'chat', characterID: id, dir: 'forward' });
    if (c.messages.length === 0) {
      this._advance(id);
    }
  }

  // ── Dialogue engine ───────────────────────────────────
  selectChoice(choiceID) {
    const c = this.char(this.chatID);
    if (!c) return;
    const choice = this.choices.find(ch => ch.id === choiceID);
    if (!choice) return;

    c.messages.push({ text: choice.text, sender: 'player', id: Date.now() });
    c.affinity += choice.af ?? 0;
    c.currentNode = choice.next;
    this.choices = [];
    this._emit('choices', []);
    this._emit('message', { characterID: c.id });
    this._emit('affinity', { characterID: c.id });
    this._advance(c.id);
  }

  _cancelTyping() {
    if (this._typing) { this._typing.abort = true; }
    this.isTyping = false;
    this.choices  = [];
  }

  async _advance(id) {
    const c = this.char(id);
    if (!c) return;

    const tree = STORY_DATA[id];
    const node = tree.nodes[c.currentNode];
    if (!node) return;

    const token = { abort: false };
    this._typing = token;
    this.isTyping = true;
    this.choices  = [];
    this._emit('typing', true);

    for (const line of node.lines) {
      await sleep(700);
      if (token.abort) return;
      c.messages.push({ text: line, sender: 'character', id: Date.now() + Math.random() });
      if (this.screen !== 'chat' || this.chatID !== id) c.hasUnread = true;
      this._emit('message', { characterID: id });
    }

    if (token.abort) return;
    c.affinity += node.af ?? 0;
    this._emit('affinity', { characterID: id });
    this.isTyping = false;
    this._emit('typing', false);

    if (node.choices?.length) {
      this.choices = node.choices;
      this._emit('choices', node.choices);
    } else if (node.auto) {
      c.currentNode = node.auto;
      this._advance(id);
    } else {
      this._emit('end', { characterID: id });
    }
  }
}

const state = new GameState();
