const locationInput = document.getElementById("locationInput");
const suggestionsBox = document.getElementById("suggestions");
const placeIdInput = document.getElementById("placeIdInput");

locationInput.addEventListener("input", async () => {
  const query = locationInput.value.trim();

  if (query.length < 2) {
    suggestionsBox.innerHTML = "";
    suggestionsBox.style.display = "none";
    return;
  }

  try {
    const res = await fetch(`/events/search-place?q=${encodeURIComponent(query)}`);
    const data = await res.json();

    console.log("Suggestions:", data); // DEBUG

    suggestionsBox.innerHTML = "";

    if (data.length === 0) {
      suggestionsBox.style.display = "none";
      return;
    }

    data.forEach(place => {
      const div = document.createElement("div");
      div.textContent = place.place_name;

      div.addEventListener("click", () => {
        locationInput.value = place.place_name;
        placeIdInput.value = place.place_id;   // ✅ IMPORTANT FIX
        suggestionsBox.style.display = "none";

        console.log("Selected:", place.place_id); // DEBUG
      });

      suggestionsBox.appendChild(div);
    });

    suggestionsBox.style.display = "block";

  } catch (err) {
    console.error("Autocomplete error:", err);
  }
});
const form = document.getElementById("eventForm");

form.addEventListener("submit", async (e) => {
  e.preventDefault(); // 🚨 VERY IMPORTANT

  const data = {
    title: document.querySelector("[name='title']").value,
    event_time: document.querySelector("[name='event_time']").value,
    description: document.querySelector("[name='description']").value,
    place_id: placeIdInput.value
  };

  console.log("Sending data:", data); // DEBUG

  if (!data.place_id) {
    alert("Please select a location from suggestions!");
    return;
  }

  try {
    const res = await fetch("/events/add", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(data)
    });

    const result = await res.json();
    console.log("Response:", result);

    if (result.success) {
      alert("Event added successfully ✅");
      form.reset();
      suggestionsBox.innerHTML = "";
    } else {
      alert("Failed to add event ❌");
    }

  } catch (err) {
    console.error("Submit error:", err);
    alert("Server error ❌");
  }
});