function initMap() {
  const center = { lat: 30.353, lng: 76.37 };

  const map = new google.maps.Map(document.getElementById("map"), {
    zoom: 16,
    center: center,
    mapTypeId: "satellite"
  });

  // 🎨 Colors for markers
  const colors = [
    "red",
    "blue",
    "green",
    "purple",
    "orange",
    "pink",
    "yellow"
  ];

  const locations = {};

  // 📍 Group events by same lat/lng
  events.forEach(event => {
    const lat = parseFloat(event.lat);
    const lng = parseFloat(event.lng);

    const key = `${lat},${lng}`;
    if (!locations[key]) locations[key] = [];

    locations[key].push(event);
  });

  let colorIndex = 0;

  // 🔁 Loop grouped locations
  Object.keys(locations).forEach(key => {
    const eventList = locations[key];
    const lat = parseFloat(eventList[0].lat);
    const lng = parseFloat(eventList[0].lng);

    // 🎯 Assign different color per location
    const color = colors[colorIndex % colors.length];
    colorIndex++;

    const marker = new google.maps.Marker({
      position: { lat, lng },
      map,
      icon: `http://maps.google.com/mapfiles/ms/icons/${color}-dot.png`
    });

    // 🧠 Click → show ALL events at that location
    marker.addListener("click", () => {
      let html = `
        <h2 style="color: var(--orange);">
          Events at this location
        </h2>
      `;

      eventList.forEach(e => {
        html += `
          <div style="margin-bottom:12px;">
            <strong>${e.title}</strong><br>
            <span>${e.description || ""}</span><br>
            <span style="color: var(--muted); font-size: 12px;">
              ${e.society_name} • ${new Date(e.event_time).toLocaleString()}
            </span>
          </div>
        `;
      });

      document.getElementById("eventDetails").innerHTML = html;
    });
  });
}