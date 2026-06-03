const express = require("express");
const router = express.Router();
const Groq = require("groq-sdk");
const { Pool } = require("pg");
require('dotenv').config({ path: '../api.env' });
const pool = new Pool({
    host: process.env.PGHOST,
    port: process.env.PGPORT,
    user: process.env.PGUSER,
    password: process.env.PGPASSWORD,
    database: process.env.PGDATABASE,
});

const groq = new Groq({
    apiKey: process.env.GROQ_API_KEY
});

const conversations = {};

router.post("/", async (req, res) => {
  const { message, sessionId } = req.body;
  console.log("AI ROUTE HIT, message:", message);

  try {
    const result = await pool.query(
      "SELECT place_name, remark FROM places WHERE remark NOT IN ('road', 'main road')"
    );

    const placeList = result.rows
      .map(p => `- ${p.place_name} (${p.remark})`)
      .join("\n");

    const sid = sessionId || "default";
    if (!conversations[sid]) {
      conversations[sid] = [];
    }

    const systemPrompt = `You are a friendly campus navigation assistant named CampusAI. You are helpful, warm, and conversational.

RULES:
1. Greet the user warmly on first message.
2. Have a natural conversation — ask how they are, what they need.
3. When the user mentions a need (food, sports, study, medical, etc), return ONLY this JSON:
{"options": ["place1", "place2"], "message": "Here are some places for you!", "tour": false}
4. If the user asks for a tour (words like "tour", "show me around", "campus tour", "explore"), return ONLY this JSON:
{"options": [], "message": "Starting your campus tour! I'll guide you through the key landmarks.", "tour": true, "stops": ["nava nalanda central library", "waterbody cafe", "sky walk", "nirvana fountain", "karvings", "oat", "sports complex"]}
5. If the user is just chatting, return ONLY this JSON:
{"options": [], "message": "your friendly reply here", "tour": false}
6. ALWAYS return valid JSON only. No extra text. No markdown. No backticks.

Available campus places:
${placeList}`;

    // Build messages array with history
    const messages = [
      { role: "system", content: systemPrompt },
      ...conversations[sid],
      { role: "user", content: message }
    ];

    const completion = await groq.chat.completions.create({
      model: "llama-3.3-70b-versatile",
      messages: messages,
      temperature: 0.7,
      max_tokens: 500
    });

    const text = completion.choices[0].message.content.trim();

    // Save to history
    conversations[sid].push(
      { role: "user", content: message },
      { role: "assistant", content: text }
    );

    const cleaned = text.replace(/```json|```/g, "").trim();
    const data = JSON.parse(cleaned);
    res.json(data);

  } catch (err) {
    console.error("AI ERROR:", err.message);
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;