let map;
let currentLine;
let userLocation = null;
let userMarker = null;

let nodes = {};
let currentPath = [];
let destination = null;
let destinationMarker = null;

// ✅ TOUR STATE
let tourMode = false;
let tourStops = [];
let tourIndex = 0;
let tourMarkers = [];

function getDestinationFromURL() {
  const params = new URLSearchParams(window.location.search);
  return params.get("dest");
}

function getTourFromURL() {
  const params = new URLSearchParams(window.location.search);
  const raw = params.get("tour");
  if (!raw) return null;
  try {
    return JSON.parse(decodeURIComponent(raw));
  } catch { return null; }
}

function getDistance(lat1, lng1, lat2, lng2) {
  const R = 6371e3;
  const φ1 = lat1 * Math.PI / 180;
  const φ2 = lat2 * Math.PI / 180;
  const Δφ = (lat2 - lat1) * Math.PI / 180;
  const Δλ = (lng2 - lng1) * Math.PI / 180;
  const a = Math.sin(Δφ/2)**2 + Math.cos(φ1)*Math.cos(φ2)*Math.sin(Δλ/2)**2;
  return Math.round(R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)));
}

async function initMap() {
  map = new google.maps.Map(document.getElementById("map"), {
    center: { lat: 30.352086, lng: 76.373830 },
    zoom: 17,
    mapTypeId: "satellite"
  });

  await loadNodes();

  // ✅ CHECK FOR TOUR
  const tourData = getTourFromURL();
  if (tourData && tourData.length > 0) {
    tourMode = true;
    tourStops = tourData.map(s => s.toLowerCase());
    startTour();
    return;
  }

  // NORMAL MODE
  destination = getDestinationFromURL();
  if (!destination) { alert("No destination provided"); return; }
  destination = destination.toLowerCase();
  trackUserLive();
}

async function loadNodes() {
  const res = await fetch("/nodes");
  const data = await res.json();

  data.forEach(place => {
    const lat = parseFloat(place.lat);
    const lng = parseFloat(place.lng);
    nodes[place.place_name] = [lat, lng];

    if (place.remark !== "main road" && place.remark !== "road") {
      const marker = new google.maps.Marker({
        position: { lat, lng },
        map: map,
        icon: "http://maps.google.com/mapfiles/ms/icons/yellow-dot.png",
        label: {
          text: String(place.place_name),
          color: "black",
          fontSize: "12px",
          fontWeight: "bold"
        }
      });
/*marker.addListener("mouseover", () => {
  marker.setAnimation(google.maps.Animation.BOUNCE);
});

marker.addListener("mouseout", () => {
  marker.setAnimation(null);
});*/
      marker.addListener("click", () => {
        window.location.href = `/map/info?place=${encodeURIComponent(place.place_name)}`;
      });
    }
  });
}

function findNearestNode(lat, lng) {
  let min = Infinity;
  let nearest = null;
  for (let name in nodes) {
    const [nLat, nLng] = nodes[name];
    const dist = getDistance(lat, lng, nLat, nLng);
    if (dist < min) { min = dist; nearest = name; }
  }
  return nearest;
}

function smoothPath(path) {
  let smooth = [];
  for (let i = 0; i < path.length - 1; i++) {
    const a = nodes[path[i]];
    const b = nodes[path[i+1]];
    if (!a || !b) continue;
    for (let t = 0; t <= 1; t += 0.2) {
      smooth.push({
        lat: a[0] + (b[0]-a[0])*t,
        lng: a[1] + (b[1]-a[1])*t
      });
    }
  }
  return smooth;
}

// ================= TOUR MODE =================

function startTour() {
  // Draw all stop markers with numbers
  tourStops.forEach((stop, idx) => {
    if (!nodes[stop]) return;
    const [lat, lng] = nodes[stop];
    const marker = new google.maps.Marker({
      position: { lat, lng },
      map: map,
      label: {
        text: String(idx + 1),
        color: "white",
        fontWeight: "bold"
      },
      icon: {
        path: google.maps.SymbolPath.CIRCLE,
        scale: 18,
        fillColor: idx === 0 ? "#de7c33" : "#2b2b2b",
        fillOpacity: 1,
        strokeColor: "white",
        strokeWeight: 2
      },
      zIndex: 10
    });
    tourMarkers.push(marker);
  });

  updateTourUI();
  trackUserLiveTour();
}

function updateTourUI() {
  const stop = tourStops[tourIndex];
  const total = tourStops.length;

  document.getElementById("distanceLeft").textContent =
    `🗺️ Stop ${tourIndex + 1} of ${total}: ${stop}`;
  document.getElementById("status").textContent =
    `🚶 Head to: ${stop}`;

  // Highlight current marker orange
  tourMarkers.forEach((m, i) => {
    m.setIcon({
      path: google.maps.SymbolPath.CIRCLE,
      scale: 18,
      fillColor: i === tourIndex ? "#de7c33" : i < tourIndex ? "#a3ad9b" : "#2b2b2b",
      fillOpacity: 1,
      strokeColor: "white",
      strokeWeight: 2
    });
  });
}

function trackUserLiveTour() {
  navigator.geolocation.watchPosition(async pos => {
    userLocation = { lat: pos.coords.latitude, lng: pos.coords.longitude };

    if (userMarker) userMarker.setMap(null);
    userMarker = new google.maps.Marker({
      position: userLocation,
      map: map,
      icon: "http://maps.google.com/mapfiles/ms/icons/blue-dot.png"
    });
    map.setCenter(userLocation);

    const currentStop = tourStops[tourIndex];
    if (!currentStop || !nodes[currentStop]) return;

    // Route to current stop
    const start = findNearestNode(userLocation.lat, userLocation.lng);
    const res = await fetch("/route", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ start, end: currentStop })
    });
    const data = await res.json();
    if (data.path && data.path.length > 0) {
      currentPath = data.path;
      drawPath(currentPath);
    }

    // ✅ AUTO-ADVANCE when within 15 meters
    const [stopLat, stopLng] = nodes[currentStop];
    const distToStop = getDistance(userLocation.lat, userLocation.lng, stopLat, stopLng);

    document.getElementById("distanceLeft").textContent =
      `🗺️ Stop ${tourIndex+1}/${tourStops.length}: ${currentStop} — ${distToStop}m away`;

    if (distToStop < 15) {
      if (tourIndex < tourStops.length - 1) {
        tourIndex++;
        updateTourUI();
        document.getElementById("status").textContent =
          `✅ Arrived! Moving to stop ${tourIndex + 1}: ${tourStops[tourIndex]}`;
      } else {
        // Tour complete
        document.getElementById("distanceLeft").textContent = `🎉 Tour Complete!`;
        document.getElementById("status").textContent = `✅ You've seen all the stops!`;
        if (currentLine) currentLine.setMap(null);
      }
    }
  });
}

// ================= NORMAL MODE =================

function trackUserLive() {
  navigator.geolocation.watchPosition(pos => {
    userLocation = { lat: pos.coords.latitude, lng: pos.coords.longitude };

    if (userMarker) userMarker.setMap(null);
    userMarker = new google.maps.Marker({
      position: userLocation,
      map: map,
      icon: "http://maps.google.com/mapfiles/ms/icons/blue-dot.png"
    });
    map.setCenter(userLocation);

    if (destination && !currentPath.length) startRouting();
    updateNavigation();
  });
}

async function startRouting() {
  if (!userLocation) return;
  const start = findNearestNode(userLocation.lat, userLocation.lng);

  const res = await fetch("https://localhost:1200/route", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ start, end: destination })
  });

  const data = await res.json();
  currentPath = data.path;

  if (!currentPath || currentPath.length === 0) {
    alert("No route found to " + destination);
    return;
  }

  if (!nodes[destination]) {
    console.error("Destination not in nodes:", destination);
    return;
  }

  const [lat, lng] = nodes[destination];
  if (destinationMarker) destinationMarker.setMap(null);
  destinationMarker = new google.maps.Marker({
    position: { lat, lng },
    map: map,
    icon: "http://maps.google.com/mapfiles/ms/icons/red-dot.png"
  });

  drawPath(currentPath);
}

function drawPath(path) {
  const latlngs = smoothPath(path);
  if (currentLine) currentLine.setMap(null);
  currentLine = new google.maps.Polyline({
    path: latlngs,
    strokeColor: "#de7c33",
    strokeWeight: 5,
    strokeOpacity: 0.9
  });
  currentLine.setMap(map);
}

async function updateNavigation() {
  if (!currentPath.length || !userLocation) return;

  let minDist = Infinity;
  let closestIndex = 0;

  currentPath.forEach((node, i) => {
    if (!nodes[node]) return;
    const [lat, lng] = nodes[node];
    const dist = getDistance(userLocation.lat, userLocation.lng, lat, lng);
    if (dist < minDist) { minDist = dist; closestIndex = i; }
  });

  let remaining = 0;
  for (let i = closestIndex; i < currentPath.length - 1; i++) {
    if (!nodes[currentPath[i]] || !nodes[currentPath[i+1]]) continue;
    const [aLat, aLng] = nodes[currentPath[i]];
    const [bLat, bLng] = nodes[currentPath[i+1]];
    remaining += getDistance(aLat, aLng, bLat, bLng);
  }

  document.getElementById("distanceLeft").textContent = `📍 Remaining: ${remaining} meters`;

  const destNode = nodes[destination];
  const distToDest = destNode
    ? getDistance(userLocation.lat, userLocation.lng, destNode[0], destNode[1])
    : remaining;

  if (distToDest < 15) {
    document.getElementById("status").textContent = `✅ Status: You have arrived!`;
  } else if (minDist > 30) {
    document.getElementById("status").textContent = `🔄 Status: Recalculating...`;
  } else {
    document.getElementById("status").textContent = `🚶 Navigating to: ${destination}`;
  }

  if (minDist > 30) {
    const newStart = findNearestNode(userLocation.lat, userLocation.lng);
    const res = await fetch("https://localhost:1200/route", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ start: newStart, end: destination })
    });
    const data = await res.json();
    currentPath = data.path;
    drawPath(currentPath);
    return;
  }

  drawPath(currentPath.slice(closestIndex));
}