import Foundation

// MARK: – Riley's story (energetic gamer femboy)
let rileyTree: DialogueTree = {
    let nodes: [DialogueNode] = [
        DialogueNode(
            id: "start",
            lines: ["heyyy!! 🎮", "omg you actually texted back!! i was starting to think you lost my number lol"],
            choices: [
                DialogueChoice(id: "c1a", text: "Of course! How could I forget you?", nextNodeID: "r1_sweet", affinityDelta: 2),
                DialogueChoice(id: "c1b", text: "Took me a while to find it ngl", nextNodeID: "r1_tease", affinityDelta: 0),
                DialogueChoice(id: "c1c", text: "Who is this?", nextNodeID: "r1_cold", affinityDelta: -1),
            ]
        ),
        DialogueNode(
            id: "r1_sweet",
            lines: ["awww 🥺💕", "okay that's really cute of you to say", "anyway!! i've been grinding ranked all day and i FINALLY hit diamond omg"],
            choices: [
                DialogueChoice(id: "c2a", text: "Diamond?? That's insane, congrats!! 🎉", nextNodeID: "r2_hype", affinityDelta: 2),
                DialogueChoice(id: "c2b", text: "Haha what game?", nextNodeID: "r2_curious", affinityDelta: 1),
            ]
        ),
        DialogueNode(
            id: "r1_tease",
            lines: ["EXCUSE ME 😤", "jkjk lmao i know you're busy", "i've been grinding ranked all day btw!! hit diamond finally 🎮"],
            choices: [
                DialogueChoice(id: "c2a", text: "Diamond?? That's insane, congrats!! 🎉", nextNodeID: "r2_hype", affinityDelta: 2),
                DialogueChoice(id: "c2b", text: "Haha what game?", nextNodeID: "r2_curious", affinityDelta: 1),
            ]
        ),
        DialogueNode(
            id: "r1_cold",
            lines: ["...riley? from the cafe?? 🙄", "we literally talked for like two hours"],
            choices: [
                DialogueChoice(id: "c_recall", text: "Oh! Riley! Sorry, new phone lol", nextNodeID: "r1_forgive", affinityDelta: 1),
                DialogueChoice(id: "c_bad", text: "Oh right. Hey.", nextNodeID: "r1_upset", affinityDelta: -2),
            ]
        ),
        DialogueNode(
            id: "r1_forgive",
            lines: ["okay fine i'll believe you 😤", "new phone or not you should have saved my contact immediately lol", "anyway! i hit diamond today!!"],
            choices: [
                DialogueChoice(id: "c2a", text: "Diamond?? That's insane, congrats!! 🎉", nextNodeID: "r2_hype", affinityDelta: 2),
                DialogueChoice(id: "c2b", text: "Haha what game?", nextNodeID: "r2_curious", affinityDelta: 1),
            ]
        ),
        DialogueNode(
            id: "r1_upset",
            lines: ["wow okay 😒", "you know what? forget it", "talk to me when you actually feel like being a person"],
            autoNext: "r1_upset_end"
        ),
        DialogueNode(
            id: "r1_upset_end",
            lines: ["[Riley has gone offline]"],
            autoNext: nil,
            affinityDelta: 0
        ),
        DialogueNode(
            id: "r2_hype",
            lines: ["RIGHT?? i've been trying for three seasons omg 😭", "my hands were literally shaking on the final match lol", "you should come watch me stream sometime!! 🎀"],
            choices: [
                DialogueChoice(id: "c3a", text: "I'd love to! Send me the link 🔗", nextNodeID: "r3_stream", affinityDelta: 3),
                DialogueChoice(id: "c3b", text: "Maybe! I'm not huge into streams", nextNodeID: "r3_hesitant", affinityDelta: 0),
            ]
        ),
        DialogueNode(
            id: "r2_curious",
            lines: ["Valorant!! 💖", "i main Jett obviously lol", "i've been grinding for three seasons to hit diamond and i finally did it today omg"],
            choices: [
                DialogueChoice(id: "c3a", text: "That's so cool, I'd love to watch you play!", nextNodeID: "r3_stream", affinityDelta: 3),
                DialogueChoice(id: "c3b", text: "Nice! I barely know Valorant tbh", nextNodeID: "r3_hesitant", affinityDelta: 0),
            ]
        ),
        DialogueNode(
            id: "r3_stream",
            lines: ["omg YES okay i'm sending it rn", "it's riley_plays on twitch 🌸", "you better show up i will literally cry if you don't lmao"],
            autoNext: "r3_end",
            affinityDelta: 1
        ),
        DialogueNode(
            id: "r3_hesitant",
            lines: ["nooo it's okay!!", "i get that streams aren't everyone's thing 😊", "we could just hang and play together sometime instead?"],
            choices: [
                DialogueChoice(id: "c4a", text: "That actually sounds really fun 🎮", nextNodeID: "r3_end", affinityDelta: 2),
                DialogueChoice(id: "c4b", text: "Maybe sometime!", nextNodeID: "r3_end", affinityDelta: 0),
            ]
        ),
        DialogueNode(
            id: "r3_end",
            lines: ["okay i gotta go eat dinner now but", "thanks for actually talking to me 🥺", "you make me happy, you know? 💕"],
            autoNext: nil
        ),
    ]
    var dict: [String: DialogueNode] = [:]
    nodes.forEach { dict[$0.id] = $0 }
    return DialogueTree(nodes: dict, startNodeID: "start")
}()

// MARK: – Kai's story (shy artistic femboy)
let kaiTree: DialogueTree = {
    let nodes: [DialogueNode] = [
        DialogueNode(
            id: "start",
            lines: ["oh.. hey", "sorry i'm awkward over text lol"],
            choices: [
                DialogueChoice(id: "c1a", text: "Don't worry, I think it's cute 😊", nextNodeID: "k1_sweet", affinityDelta: 2),
                DialogueChoice(id: "c1b", text: "Lol same honestly", nextNodeID: "k1_relate", affinityDelta: 1),
            ]
        ),
        DialogueNode(
            id: "k1_sweet",
            lines: ["...cute?", "okay now i'm even more nervous 😳"],
            choices: [
                DialogueChoice(id: "c2a", text: "In a good way! 💜", nextNodeID: "k2_art", affinityDelta: 2),
                DialogueChoice(id: "c2b", text: "Haha sorry didn't mean to be weird", nextNodeID: "k2_art", affinityDelta: 0),
            ]
        ),
        DialogueNode(
            id: "k1_relate",
            lines: ["oh thank god", "i've been staring at this conversation for like ten minutes trying to figure out what to say lol"],
            autoNext: "k2_art",
            affinityDelta: 1
        ),
        DialogueNode(
            id: "k2_art",
            lines: ["i've been drawing all day actually", "just finished a piece i'm kind of proud of for once 🖊️", "i almost never like my own work so this is new lol"],
            choices: [
                DialogueChoice(id: "c3a", text: "Can I see it?? 👀", nextNodeID: "k3_share", affinityDelta: 3),
                DialogueChoice(id: "c3b", text: "What kind of art do you do?", nextNodeID: "k3_genre", affinityDelta: 1),
            ]
        ),
        DialogueNode(
            id: "k3_share",
            lines: ["oh gosh", "okay fine but don't judge me lol", "[Kai sent an image: a soft watercolor portrait, delicate and detailed]", "...it's me, kind of. in a way i wish i looked"],
            choices: [
                DialogueChoice(id: "c4a", text: "Kai, this is genuinely beautiful 💜", nextNodeID: "k4_touched", affinityDelta: 4),
                DialogueChoice(id: "c4b", text: "You already look like this though?", nextNodeID: "k4_blush", affinityDelta: 3),
            ]
        ),
        DialogueNode(
            id: "k3_genre",
            lines: ["mostly digital + watercolor", "soft things. cottagecore, a little fantasy", "i draw myself sometimes but i never show those lol"],
            choices: [
                DialogueChoice(id: "c3a2", text: "You should! I bet they're lovely", nextNodeID: "k3_share", affinityDelta: 2),
                DialogueChoice(id: "c3b2", text: "That sounds really peaceful actually", nextNodeID: "k4_end", affinityDelta: 1),
            ]
        ),
        DialogueNode(
            id: "k4_touched",
            lines: ["...", "thank you", "genuinely. that means a lot coming from you 🥺"],
            autoNext: "k4_end",
            affinityDelta: 1
        ),
        DialogueNode(
            id: "k4_blush",
            lines: ["STOP", "you can't just say things like that lol", "you're going to make me cry actually 😭💜"],
            autoNext: "k4_end",
            affinityDelta: 2
        ),
        DialogueNode(
            id: "k4_end",
            lines: ["i'm really glad we're talking btw", "i don't really open up to people but", "you're easy to talk to 🌿"],
            autoNext: nil
        ),
    ]
    var dict: [String: DialogueNode] = [:]
    nodes.forEach { dict[$0.id] = $0 }
    return DialogueTree(nodes: dict, startNodeID: "start")
}()

// MARK: – Ash's story (confident fashionable femboy)
let ashTree: DialogueTree = {
    let nodes: [DialogueNode] = [
        DialogueNode(
            id: "start",
            lines: ["okay hi 💅", "you literally passed by me in the mall today and didn't say anything??", "rude but also iconic so i'll allow it lol"],
            choices: [
                DialogueChoice(id: "c1a", text: "I was too nervous to say hi honestly", nextNodeID: "a1_honest", affinityDelta: 2),
                DialogueChoice(id: "c1b", text: "I didn't see you! I'm so sorry 😭", nextNodeID: "a1_excuse", affinityDelta: 1),
                DialogueChoice(id: "c1c", text: "Iconic is my brand, thanks for noticing", nextNodeID: "a1_banter", affinityDelta: 2),
            ]
        ),
        DialogueNode(
            id: "a1_honest",
            lines: ["okay THAT is genuinely the sweetest thing anyone has ever said to me", "you were nervous?? because of ME?? 💙", "that's literally adorable i can't"],
            autoNext: "a2_outfit",
            affinityDelta: 1
        ),
        DialogueNode(
            id: "a1_excuse",
            lines: ["mmhm sure sure 😏", "i was literally in the best outfit today too so that's embarrassing for you lol", "jk jk. you're forgiven"],
            autoNext: "a2_outfit",
            affinityDelta: 0
        ),
        DialogueNode(
            id: "a1_banter",
            lines: ["OH WOW", "okay i was NOT expecting that energy but i respect it so much 💙", "you might be the first person who's ever matched my vibe lol"],
            autoNext: "a2_outfit",
            affinityDelta: 2
        ),
        DialogueNode(
            id: "a2_outfit",
            lines: ["anyway i was at the mall because i found the most perfect skirt", "it's this deep blue pleated thing and it goes with EVERYTHING", "i've already planned three outfits around it 😌"],
            choices: [
                DialogueChoice(id: "c3a", text: "Send pics!! I need to see 📸", nextNodeID: "a3_pic", affinityDelta: 3),
                DialogueChoice(id: "c3b", text: "Three whole outfits, you're dedicated lol", nextNodeID: "a3_laugh", affinityDelta: 1),
            ]
        ),
        DialogueNode(
            id: "a3_pic",
            lines: ["i thought you'd never ask 😏", "[Ash sent an image: a mirror selfie, confident pose, stunning blue pleated skirt]", "yes i know. i look incredible. thank you."],
            choices: [
                DialogueChoice(id: "c4a", text: "You literally look amazing 💙", nextNodeID: "a4_end_sweet", affinityDelta: 3),
                DialogueChoice(id: "c4b", text: "The skirt's giving main character energy fr", nextNodeID: "a4_end_banter", affinityDelta: 2),
            ]
        ),
        DialogueNode(
            id: "a3_laugh",
            lines: ["dedicated is my baseline lol", "fashion is self expression and i take that very seriously 💅", "also i could style you too if you ever wanted. just saying."],
            choices: [
                DialogueChoice(id: "c4c", text: "I'd actually be really into that 😳", nextNodeID: "a4_end_sweet", affinityDelta: 3),
                DialogueChoice(id: "c4d", text: "Bold offer haha, maybe!", nextNodeID: "a4_end_banter", affinityDelta: 1),
            ]
        ),
        DialogueNode(
            id: "a4_end_sweet",
            lines: ["okay you're seriously too sweet 🥺💙", "don't go making me soft, i have a reputation"],
            autoNext: "a4_final"
        ),
        DialogueNode(
            id: "a4_end_banter",
            lines: ["EXACTLY omg you get it 💙", "okay i think i like you"],
            autoNext: "a4_final"
        ),
        DialogueNode(
            id: "a4_final",
            lines: ["we should hang sometime btw", "i'll pick the place obviously because your taste is unknown to me", "but i'm willing to find out 😌"],
            autoNext: nil
        ),
    ]
    var dict: [String: DialogueNode] = [:]
    nodes.forEach { dict[$0.id] = $0 }
    return DialogueTree(nodes: dict, startNodeID: "start")
}()

// MARK: – Registry
let allDialogueTrees: [String: DialogueTree] = [
    "riley": rileyTree,
    "kai":   kaiTree,
    "ash":   ashTree,
]
