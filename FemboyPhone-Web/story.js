// ─── Dialogue tree data for all three characters ───────────────────────────

const STORY_DATA = {
  riley: {
    start: "start",
    nodes: {
      start: {
        lines: ["heyyy!! 🎮", "omg you actually texted back!! i was starting to think you lost my number lol"],
        choices: [
          { id: "c1a", text: "Of course! How could I forget you?", next: "r1_sweet", af: 2 },
          { id: "c1b", text: "Took me a while to find it ngl",      next: "r1_tease", af: 0 },
          { id: "c1c", text: "Who is this?",                        next: "r1_cold",  af: -1 },
        ],
      },
      r1_sweet: {
        lines: ["awww 🥺💕", "okay that's really cute of you to say", "anyway!! i've been grinding ranked all day and i FINALLY hit diamond omg"],
        choices: [
          { id: "c2a", text: "Diamond?? That's insane, congrats!! 🎉", next: "r2_hype",    af: 2 },
          { id: "c2b", text: "Haha what game?",                        next: "r2_curious", af: 1 },
        ],
      },
      r1_tease: {
        lines: ["EXCUSE ME 😤", "jkjk lmao i know you're busy", "i've been grinding ranked all day btw!! hit diamond finally 🎮"],
        choices: [
          { id: "c2a", text: "Diamond?? That's insane, congrats!! 🎉", next: "r2_hype",    af: 2 },
          { id: "c2b", text: "Haha what game?",                        next: "r2_curious", af: 1 },
        ],
      },
      r1_cold: {
        lines: ["...riley? from the cafe?? 🙄", "we literally talked for like two hours"],
        choices: [
          { id: "ca", text: "Oh! Riley! Sorry, new phone lol", next: "r1_forgive", af: 1 },
          { id: "cb", text: "Oh right. Hey.",                   next: "r1_upset",   af: -2 },
        ],
      },
      r1_forgive: {
        lines: ["okay fine i'll believe you 😤", "new phone or not you should have saved my contact immediately lol", "anyway! i hit diamond today!!"],
        choices: [
          { id: "c2a", text: "Diamond?? That's insane, congrats!! 🎉", next: "r2_hype",    af: 2 },
          { id: "c2b", text: "Haha what game?",                        next: "r2_curious", af: 1 },
        ],
      },
      r1_upset: {
        lines: ["wow okay 😒", "you know what? forget it", "talk to me when you actually feel like being a person"],
        auto: "r1_upset_end",
      },
      r1_upset_end: {
        lines: ["[Riley has gone offline]"],
      },
      r2_hype: {
        lines: ["RIGHT?? i've been trying for three seasons omg 😭", "my hands were literally shaking on the final match lol", "you should come watch me stream sometime!! 🎀"],
        choices: [
          { id: "c3a", text: "I'd love to! Send me the link 🔗", next: "r3_stream",   af: 3 },
          { id: "c3b", text: "Maybe! I'm not huge into streams",  next: "r3_hesitant", af: 0 },
        ],
      },
      r2_curious: {
        lines: ["Valorant!! 💖", "i main Jett obviously lol", "i've been grinding for three seasons to hit diamond and i finally did it today omg"],
        choices: [
          { id: "c3a", text: "That's so cool, I'd love to watch you play!", next: "r3_stream",   af: 3 },
          { id: "c3b", text: "Nice! I barely know Valorant tbh",             next: "r3_hesitant", af: 0 },
        ],
      },
      r3_stream: {
        lines: ["omg YES okay i'm sending it rn", "it's riley_plays on twitch 🌸", "you better show up i will literally cry if you don't lmao"],
        auto: "r3_end", af: 1,
      },
      r3_hesitant: {
        lines: ["nooo it's okay!!", "i get that streams aren't everyone's thing 😊", "we could just hang and play together sometime instead?"],
        choices: [
          { id: "c4a", text: "That actually sounds really fun 🎮", next: "r3_end", af: 2 },
          { id: "c4b", text: "Maybe sometime!",                    next: "r3_end", af: 0 },
        ],
      },
      r3_end: {
        lines: ["okay i gotta go eat dinner now but", "thanks for actually talking to me 🥺", "you make me happy, you know? 💕"],
      },
    },
  },

  kai: {
    start: "start",
    nodes: {
      start: {
        lines: ["oh.. hey", "sorry i'm awkward over text lol"],
        choices: [
          { id: "c1a", text: "Don't worry, I think it's cute 😊", next: "k1_sweet",  af: 2 },
          { id: "c1b", text: "Lol same honestly",                  next: "k1_relate", af: 1 },
        ],
      },
      k1_sweet: {
        lines: ["...cute?", "okay now i'm even more nervous 😳"],
        choices: [
          { id: "c2a", text: "In a good way! 💜",                      next: "k2_art", af: 2 },
          { id: "c2b", text: "Haha sorry didn't mean to be weird", next: "k2_art", af: 0 },
        ],
      },
      k1_relate: {
        lines: ["oh thank god", "i've been staring at this conversation for like ten minutes trying to figure out what to say lol"],
        auto: "k2_art", af: 1,
      },
      k2_art: {
        lines: ["i've been drawing all day actually", "just finished a piece i'm kind of proud of for once 🖊️", "i almost never like my own work so this is new lol"],
        choices: [
          { id: "c3a", text: "Can I see it?? 👀",                  next: "k3_share", af: 3 },
          { id: "c3b", text: "What kind of art do you do?", next: "k3_genre", af: 1 },
        ],
      },
      k3_share: {
        lines: ["oh gosh", "okay fine but don't judge me lol", "🖼️ [Kai sent an image: a soft watercolor portrait, delicate and detailed]", "...it's me, kind of. in a way i wish i looked"],
        choices: [
          { id: "c4a", text: "Kai, this is genuinely beautiful 💜",     next: "k4_touched", af: 4 },
          { id: "c4b", text: "You already look like this though?", next: "k4_blush",   af: 3 },
        ],
      },
      k3_genre: {
        lines: ["mostly digital + watercolor", "soft things. cottagecore, a little fantasy", "i draw myself sometimes but i never show those lol"],
        choices: [
          { id: "c3a2", text: "You should! I bet they're lovely",          next: "k3_share", af: 2 },
          { id: "c3b2", text: "That sounds really peaceful actually", next: "k4_end",   af: 1 },
        ],
      },
      k4_touched: {
        lines: ["...", "thank you", "genuinely. that means a lot coming from you 🥺"],
        auto: "k4_end", af: 1,
      },
      k4_blush: {
        lines: ["STOP", "you can't just say things like that lol", "you're going to make me cry actually 😭💜"],
        auto: "k4_end", af: 2,
      },
      k4_end: {
        lines: ["i'm really glad we're talking btw", "i don't really open up to people but", "you're easy to talk to 🌿"],
      },
    },
  },

  ash: {
    start: "start",
    nodes: {
      start: {
        lines: ["okay hi 💅", "you literally passed by me in the mall today and didn't say anything??", "rude but also iconic so i'll allow it lol"],
        choices: [
          { id: "c1a", text: "I was too nervous to say hi honestly",       next: "a1_honest", af: 2 },
          { id: "c1b", text: "I didn't see you! I'm so sorry 😭",           next: "a1_excuse", af: 1 },
          { id: "c1c", text: "Iconic is my brand, thanks for noticing", next: "a1_banter", af: 2 },
        ],
      },
      a1_honest: {
        lines: ["okay THAT is genuinely the sweetest thing anyone has ever said to me", "you were nervous?? because of ME?? 💙", "that's literally adorable i can't"],
        auto: "a2_outfit", af: 1,
      },
      a1_excuse: {
        lines: ["mmhm sure sure 😏", "i was literally in the best outfit today too so that's embarrassing for you lol", "jk jk. you're forgiven"],
        auto: "a2_outfit",
      },
      a1_banter: {
        lines: ["OH WOW", "okay i was NOT expecting that energy but i respect it so much 💙", "you might be the first person who's ever matched my vibe lol"],
        auto: "a2_outfit", af: 2,
      },
      a2_outfit: {
        lines: ["anyway i was at the mall because i found the most perfect skirt", "it's this deep blue pleated thing and it goes with EVERYTHING", "i've already planned three outfits around it 😌"],
        choices: [
          { id: "c3a", text: "Send pics!! I need to see 📸",                        next: "a3_pic",    af: 3 },
          { id: "c3b", text: "Three whole outfits, you're dedicated lol", next: "a3_laugh",  af: 1 },
        ],
      },
      a3_pic: {
        lines: ["i thought you'd never ask 😏", "📸 [Ash sent a mirror selfie: confident pose, stunning blue pleated skirt]", "yes i know. i look incredible. thank you."],
        choices: [
          { id: "c4a", text: "You literally look amazing 💙",                        next: "a4_end_sweet",  af: 3 },
          { id: "c4b", text: "The skirt's giving main character energy fr", next: "a4_end_banter", af: 2 },
        ],
      },
      a3_laugh: {
        lines: ["dedicated is my baseline lol", "fashion is self expression and i take that very seriously 💅", "also i could style you too if you ever wanted. just saying."],
        choices: [
          { id: "c4c", text: "I'd actually be really into that 😳", next: "a4_end_sweet",  af: 3 },
          { id: "c4d", text: "Bold offer haha, maybe!",              next: "a4_end_banter", af: 1 },
        ],
      },
      a4_end_sweet: {
        lines: ["okay you're seriously too sweet 🥺💙", "don't go making me soft, i have a reputation"],
        auto: "a4_final",
      },
      a4_end_banter: {
        lines: ["EXACTLY omg you get it 💙", "okay i think i like you"],
        auto: "a4_final",
      },
      a4_final: {
        lines: ["we should hang sometime btw", "i'll pick the place obviously because your taste is unknown to me", "but i'm willing to find out 😌"],
      },
    },
  },
};
