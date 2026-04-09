const map = L.map('map').setView([30.354, 76.364], 17);

L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png')
  .addTo(map);

// same nodes here
const nodes = {
  gate: [30.3541, 76.3641],
  admin: [30.3545, 76.3645],
  library: [30.3550, 76.3650],
  hostel: [30.3535, 76.3635],
  canteen: [30.3538, 76.3648]
};

// show markers
for (let key in nodes) {
  L.marker(nodes[key]).addTo(map).bindPopup(key);
}

let currentLine;

// call backend
async function getRoute() {
  const res = await fetch("http://localhost:5051/route", {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      start: "gate",
      end: "library"
    })
  });

  const data = await res.json();

  drawRoute(data.path);
}

// draw path
function drawRoute(path) {
  if (currentLine) {
    map.removeLayer(currentLine);
  }

  const latlngs = path.map(node => nodes[node]);

  currentLine = L.polyline(latlngs, {
    color: "blue",
    weight: 5
  }).addTo(map);

  map.fitBounds(currentLine.getBounds());
}