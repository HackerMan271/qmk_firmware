// ─── Bootstrap ─────────────────────────────────────────────────

const phone   = document.getElementById('phone-screen');

// Render the full phone screen content
function setScreen(html) {
  phone.innerHTML = html;
}

// ─── Navigation handlers ────────────────────────────────────────

state.on('navigate', ({ screen, characterID, dir }) => {
  if (screen === 'home') {
    setScreen(renderHome(state));
  } else if (screen === 'messages') {
    setScreen(renderMessagesList(state, dir));
  } else if (screen === 'chat') {
    const c = state.char(characterID);
    setScreen(renderChatShell(c, state));
    // Render existing messages (returning to a started convo)
    const list = document.getElementById('msg-list');
    if (list && c.messages.length) {
      list.innerHTML = c.messages.map(m => renderBubble(m, c)).join('');
      if (state.isTyping) list.insertAdjacentHTML('beforeend', renderTyping(c));
      scrollBottom();
    }
    // Render pending choices
    const panel = document.getElementById('choices-panel');
    if (panel && state.choices.length) {
      panel.innerHTML = renderChoices(state.choices);
    }
  }
});

// ─── Live chat updates ──────────────────────────────────────────

state.on('message', ({ characterID }) => {
  if (state.screen !== 'chat' || state.chatID !== characterID) return;
  const c    = state.char(characterID);
  const list = document.getElementById('msg-list');
  if (!list) return;
  // Remove typing indicator if present
  document.getElementById('typing-indicator')?.remove();
  // Append latest message
  const lastMsg = c.messages[c.messages.length - 1];
  list.insertAdjacentHTML('beforeend', renderBubble(lastMsg, c));
  // Re-add typing indicator if still going
  if (state.isTyping) list.insertAdjacentHTML('beforeend', renderTyping(c));
  scrollBottom();
});

state.on('typing', (isTyping) => {
  if (state.screen !== 'chat') return;
  const c    = state.char(state.chatID);
  const list = document.getElementById('msg-list');
  if (!list || !c) return;
  document.getElementById('typing-indicator')?.remove();
  if (isTyping) {
    list.insertAdjacentHTML('beforeend', renderTyping(c));
    scrollBottom();
  }
});

state.on('choices', (choices) => {
  if (state.screen !== 'chat') return;
  const panel = document.getElementById('choices-panel');
  if (!panel) return;
  panel.innerHTML = renderChoices(choices);
});

state.on('affinity', ({ characterID }) => {
  if (state.screen !== 'chat' || state.chatID !== characterID) return;
  const c = state.char(characterID);
  const fill  = document.getElementById('affinity-fill');
  const label = document.getElementById('affinity-label');
  const num   = document.getElementById('affinity-num');
  const status = document.getElementById('chat-status');
  if (fill)  fill.style.width = state.affinityPct(c) + '%';
  if (label) label.textContent = state.affinityLabel(c);
  if (num)   num.textContent   = c.affinity;
  if (status) status.textContent = state.affinityLabel(c);
});

state.on('end', () => {
  if (state.screen !== 'chat') return;
  const panel = document.getElementById('choices-panel');
  if (panel) panel.innerHTML = '<div class="chat-end">✨ End of chapter ✨</div>';
});

// ─── Event delegation ───────────────────────────────────────────

document.addEventListener('click', e => {
  const el = e.target.closest('[data-action]');
  if (!el) return;
  const { action, id } = el.dataset;

  switch (action) {
    case 'home':     state.goHome();       break;
    case 'messages': state.goMessages();   break;
    case 'chat':     state.openChat(id);   break;
    case 'choice':   state.selectChoice(id); break;
  }
});

// Prevent rubber-band scroll on iOS when touch starts inside non-scrollable areas
document.addEventListener('touchmove', e => {
  if (!e.target.closest('.msg-scroll') && !e.target.closest('.messages-list')) {
    e.preventDefault();
  }
}, { passive: false });

// ─── Helpers ────────────────────────────────────────────────────

function scrollBottom() {
  const list = document.getElementById('msg-list');
  if (list) list.scrollTop = list.scrollHeight;
}

// ─── Initial render ─────────────────────────────────────────────

setScreen(renderHome(state));

// ─── Service worker registration ────────────────────────────────

if ('serviceWorker' in navigator) {
  window.addEventListener('load', () => {
    navigator.serviceWorker.register('sw.js').catch(() => {});
  });
}
