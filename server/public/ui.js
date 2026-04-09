const sessionId = Math.random().toString(36).slice(2);
const input = document.getElementById("userInput");

const placeholders = [
  "Where do you want to go?",
  "What do you want to do?",
  "Find a place to study 📚",
  "Looking for sports area? ⚽",
  "Need food? Try cafeteria 🍔"
];

let i = 0;
let allPlaces = [];

function changePlaceholder() {
  input.classList.add("fade-out");
  setTimeout(() => {
    input.placeholder = placeholders[i];
    i = (i + 1) % placeholders.length;
    input.classList.remove("fade-out");
    setTimeout(changePlaceholder, 3000);
  }, 500);
}
changePlaceholder();

function qs(val) {
  input.value = val;
  document.getElementById("searchBtn").click();
}

async function loadAllPlaces() {
  try {
    const res = await fetch("http://localhost:1200/nodes");
    allPlaces = await res.json();
  } catch (err) {
    console.error("Failed to load places:", err);
  }
}

document.getElementById("searchBtn").addEventListener("click", searchPlace);

async function searchPlace() {
  const userText = document.getElementById("userInput").value;
  if (!userText) { alert("Enter something"); return; }

  appendMessage("user", userText);
  document.getElementById("userInput").value = "";

  try {
    const res = await fetch("http://localhost:1200/api", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ message: userText, sessionId })
    });

    const data = await res.json();

    if (data.message) appendMessage("ai", data.message);

    // ✅ TOUR MODE
    if (data.tour && data.stops && data.stops.length > 0) {
      const encoded = encodeURIComponent(JSON.stringify(data.stops));
      setTimeout(() => {
        window.location.href = `/map?tour=${encoded}`;
      }, 1500);
      return;
    }

    if (data.options && data.options.length > 0) showResults(data.options);

  } catch (err) {
    console.error(err);
    appendMessage("ai", "Sorry, something went wrong. Try again!");
  }
}

function appendMessage(role, text) {
  const chatBox = document.getElementById("chatBox");
  const msg = document.createElement("div");
  msg.classList.add("chat-msg", role === "user" ? "chat-user" : "chat-ai");
  msg.innerText = text;
  chatBox.appendChild(msg);
  chatBox.scrollTop = chatBox.scrollHeight;
}

function showResults(options) {
  const chatBox = document.getElementById("chatBox");
  const wrapper = document.createElement("div");
  wrapper.classList.add("result-wrapper");

  options.forEach(place => {
    const match = allPlaces.find(p =>
      p.place_name && p.place_name.toLowerCase() === place.toLowerCase()
    );
    const image_url = match?.image_url || null;
    const description = match?.description || null;

    const card = document.createElement("div");
    card.classList.add("result-card");
    card.innerHTML = `
      ${image_url
        ? `<img class="result-card-img" src="${image_url}" alt="${place}" onerror="this.style.display='none'"/>`
        : ``
      }
      <div class="result-card-body">
        <h3 class="result-card-name">${place}</h3>
        ${description ? `<p class="result-card-desc">${description}</p>` : ""}
        <button class="result-card-btn" onclick="window.location.href='/map?dest=${encodeURIComponent(place)}'">
          Navigate →
        </button>
      </div>
    `;
    wrapper.appendChild(card);
  });

  chatBox.appendChild(wrapper);
  chatBox.scrollTop = chatBox.scrollHeight;
}

document.getElementById("userInput").addEventListener("keydown", (e) => {
  if (e.key === "Enter") searchPlace();
});

// ✅ Load places on startup
loadAllPlaces();