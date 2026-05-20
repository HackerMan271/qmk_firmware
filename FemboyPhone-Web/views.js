// ─── SVG helpers ────────────────────────────────────────────────

const svg = {
  chevron: `<svg viewBox="0 0 10 16"><path d="M8 1L2 8l6 7" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" fill="none"/></svg>`,
  message: `<svg viewBox="0 0 24 24"><path d="M20 2H4c-1.1 0-2 .9-2 2v18l4-4h14c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2z"/></svg>`,
  search:  `<svg viewBox="0 0 24 24"><path d="M21 21l-4.35-4.35M17 11A6 6 0 1 1 5 11a6 6 0 0 1 12 0z" stroke="currentColor" stroke-width="2" stroke-linecap="round" fill="none"/></svg>`,
  wifi:    `<svg viewBox="0 0 24 24"><path d="M5 12.55a11 11 0 0 1 14.08 0M1.42 9a16 16 0 0 1 21.16 0M8.53 16.11a6 6 0 0 1 6.95 0M12 20h.01" stroke="currentColor" stroke-width="2" stroke-linecap="round" fill="none"/></svg>`,
  battery: `<svg viewBox="0 0 24 24"><rect x="2" y="7" width="18" height="11" rx="2" stroke="currentColor" stroke-width="1.5" fill="none"/><path d="M20 11h2v3h-2z" fill="currentColor"/><rect x="4" y="9" width="14" height="7" rx="1" fill="currentColor"/></svg>`,
  video:   `<svg viewBox="0 0 24 24"><polygon points="23 7 16 12 23 17 23 7"/><rect x="1" y="5" width="15" height="14" rx="2" ry="2"/></svg>`,
  phone:   `<svg viewBox="0 0 24 24"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.75 13 19.79 19.79 0 0 1 1.68 4.4 2 2 0 0 1 3.65 2.22h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L7.91 9.91a16 16 0 0 0 6.09 6.09l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z" stroke="currentColor" stroke-width="2" fill="none"/></svg>`,
  pencil:  `<svg viewBox="0 0 24 24"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z" stroke="currentColor" stroke-width="2" stroke-linecap="round" fill="none"/></svg>`,
  camera:  `<svg viewBox="0 0 24 24"><path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z" stroke="currentColor" stroke-width="2" fill="none"/><circle cx="12" cy="13" r="4" stroke="currentColor" stroke-width="2" fill="none"/></svg>`,
  map:     `<svg viewBox="0 0 24 24"><polygon points="1 6 1 22 8 18 16 22 23 18 23 2 16 6 8 2 1 6" stroke="currentColor" stroke-width="2" stroke-linecap="round" fill="none"/><line x1="8" y1="2" x2="8" y2="18" stroke="currentColor" stroke-width="2"/><line x1="16" y1="6" x2="16" y2="22" stroke="currentColor" stroke-width="2"/></svg>`,
  heart:   `<svg viewBox="0 0 24 24"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" stroke="currentColor" stroke-width="2" fill="none"/></svg>`,
  gear:    `<svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83-2.83l.06-.06A1.65 1.65 0 0 0 4.68 15a1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 2.83-2.83l.06.06A1.65 1.65 0 0 0 9 4.68a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 2.83l-.06.06A1.65 1.65 0 0 0 19.4 9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z" stroke="currentColor" stroke-width="2" fill="none"/></svg>`,
  music:   `<svg viewBox="0 0 24 24"><path d="M9 18V5l12-2v13" stroke="currentColor" stroke-width="2" stroke-linecap="round" fill="none"/><circle cx="6" cy="18" r="3" stroke="currentColor" stroke-width="2" fill="none"/><circle cx="18" cy="16" r="3" stroke="currentColor" stroke-width="2" fill="none"/></svg>`,
};

// ─── Status bar ──────────────────────────────────────────────

function renderStatusBar() {
  const now = new Date();
  const h = now.getHours() % 12 || 12;
  const m = String(now.getMinutes()).padStart(2, '0');
  return `
    <div class="status-bar">
      <span>${h}:${m}</span>
      <span class="status-bar__icons">
        ${svg.wifi}${svg.battery}
      </span>
    </div>`;
}

// ─── Home screen ────────────────────────────────────────────

function renderHome(s) {
  const unread = s.unreadCount();
  const stars = Array.from({ length: 38 }, (_, i) => {
    const x = (i * 23 + 17) % 355;
    const y = (i * 37 + 60) % 640;
    const r = 0.8 + (i % 3) * 0.7;
    const op = 0.3 + (i % 5) * 0.14;
    return `<span style="left:${x}px;top:${y}px;width:${r*2}px;height:${r*2}px;opacity:${op}"></span>`;
  }).join('');

  const grid = [
    { icon: svg.message, label: 'Messages', bg: '#25c940', action: 'messages', badge: unread },
    { icon: svg.camera,  label: 'Photos',   bg: '#ff5470', action: '' },
    { icon: svg.wifi,    label: 'Safari',   bg: '#2b6be6', action: '' },
    { icon: svg.music,   label: 'Music',    bg: '#f0304a', action: '' },
    { icon: svg.camera,  label: 'Camera',   bg: '#383848', action: '' },
    { icon: svg.map,     label: 'Maps',     bg: '#25c080', action: '' },
    { icon: svg.heart,   label: 'Health',   bg: '#ff3b4a', action: '' },
    { icon: svg.gear,    label: 'Settings', bg: '#606070', action: '' },
  ].map(app => `
    <button class="app-icon" ${app.action ? `data-action="${app.action}"` : 'disabled'}>
      <div class="app-icon__bg" style="background:${app.bg}">
        ${app.icon}
        ${app.badge ? `<div class="badge">${app.badge}</div>` : ''}
      </div>
      <span class="app-icon__label">${app.label}</span>
    </button>`).join('');

  return `
    <div class="home screen-enter">
      <div class="wallpaper"></div>
      <div class="stars">${stars}</div>
      <div class="home__content">
        ${renderStatusBar()}
        <div class="home__greeting">
          <div class="home__subtitle">FEMBOYPHONE</div>
          <div class="home__title">Your Phone ✨</div>
        </div>
        ${unread ? `
        <button class="home__notification" data-action="messages">
          ${svg.message}
          <span>${unread} new message${unread > 1 ? 's' : ''} waiting...</span>
        </button>` : ''}
        <div class="home__spacer"></div>
        <div class="app-grid">${grid}</div>
        <div class="dock">
          <button class="dock-icon" style="background:#2fcc50" disabled>${svg.phone}</button>
          <button class="dock-icon" style="background:#25c940" data-action="messages">${svg.message}</button>
          <button class="dock-icon" style="background:#2255e0" disabled>${svg.pencil}</button>
          <button class="dock-icon" style="background:#f0304a" disabled>${svg.music}</button>
        </div>
      </div>
    </div>`;
}

// ─── Messages list ────────────────────────────────────────────

function renderMessagesList(s, dir = 'forward') {
  const rows = s.chars.map(c => `
    <button class="convo-row" data-action="chat" data-id="${c.id}">
      <div class="avatar" style="background:${c.color}22;border:1.5px solid ${c.color}55">${c.avatar}</div>
      <div class="convo-info">
        <div class="convo-header">
          <span class="convo-name ${c.hasUnread ? 'unread' : ''}">${c.name}</span>
          <span class="convo-time">now</span>
        </div>
        <div class="convo-preview ${c.hasUnread ? 'unread' : ''}">
          ${c.messages.length ? escHtml(c.messages[c.messages.length - 1].text) : 'Tap to start chatting…'}
        </div>
      </div>
      ${c.hasUnread ? '<div class="unread-dot"></div>' : ''}
    </button>`).join('');

  return `
    <div class="${dir === 'back' ? 'screen-back' : 'screen-enter'}" style="display:flex;flex-direction:column;height:100%;background:var(--bg)">
      <div class="nav-bar" style="position:relative">
        <button class="nav-bar__back" data-action="home">${svg.chevron} Back</button>
        <span class="nav-bar__title">Messages</span>
        <button class="nav-bar__action" disabled>${svg.pencil}</button>
      </div>
      <button class="search-bar" disabled>
        ${svg.search} <span>Search</span>
      </button>
      <div class="messages-list">${rows}</div>
    </div>`;
}

// ─── Chat screen shell ────────────────────────────────────────────
// (messages, typing, choices updated in-place by app.js)

function renderChatShell(c, s) {
  const pct   = s.affinityPct(c);
  const label = s.affinityLabel(c);
  return `
    <div class="chat-screen screen-enter" id="chat-screen">
      <div class="chat-nav">
        <button class="chat-nav__back" data-action="messages">‹</button>
        <div class="chat-nav__avatar" style="background:${c.color}33;border:1.5px solid ${c.color}66">${c.avatar}</div>
        <div class="chat-nav__info">
          <div class="chat-nav__name">${c.name}</div>
          <div class="chat-nav__status" style="color:${c.color}" id="chat-status">${label}</div>
        </div>
        <div class="chat-nav__actions">
          <button disabled>${svg.video}</button>
          <button disabled>${svg.phone}</button>
        </div>
      </div>
      <div class="msg-scroll" id="msg-list"></div>
      <div class="affinity-bar">
        <span id="affinity-label">${label}</span>
        <div class="affinity-track">
          <div class="affinity-fill" id="affinity-fill" style="width:${pct}%;background:${c.color}"></div>
        </div>
        <span id="affinity-num">${c.affinity}</span>
      </div>
      <div id="choices-panel"></div>
    </div>`;
}

// ─── Individual message bubble ────────────────────────────────

function renderBubble(msg, c) {
  const isPlayer = msg.sender === 'player';
  return `
    <div class="bubble-row ${isPlayer ? 'player' : 'character'}">
      <div class="bubble ${isPlayer ? 'player' : 'character'}"
           style="${isPlayer ? '' : `background:${c.color}22;border:1px solid ${c.color}44`}">
        ${escHtml(msg.text)}
      </div>
    </div>`;
}

function renderTyping(c) {
  return `
    <div class="typing-row" id="typing-indicator">
      <div class="typing-bubble" style="background:${c.color}22;border:1px solid ${c.color}44">
        <span style="background:${c.color}"></span>
        <span style="background:${c.color}"></span>
        <span style="background:${c.color}"></span>
      </div>
    </div>`;
}

function renderChoices(choices) {
  if (!choices.length) return '';
  return `
    <div class="choices">
      ${choices.map(ch =>
        `<button class="choice-btn" data-action="choice" data-id="${ch.id}">${escHtml(ch.text)}</button>`
      ).join('')}
    </div>`;
}

// ─── Utility ───────────────────────────────────────────────────

function escHtml(str) {
  return str
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}
