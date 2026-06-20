# 🎓 Campus AI

Campus AI is a smart campus navigation and event management platform that helps students explore the campus, navigate between buildings, discover ongoing events, and access important campus information through an interactive map interface.

---


live link :https://campus-ai-fe4y.onrender.com/
## 🚀 Features

### 🗺️ Smart Campus Navigation

* Interactive Google Maps integration
* Real-time campus navigation
* Route visualization between locations
* Distance tracking

### 🎉 Event Management

* Society-based event creation
* Event location markers on the campus map
* Click markers to view event details
* Event scheduling and management

### 🏢 Campus Exploration

* Building information
* Popular campus locations
* Smart search suggestions
* 360° campus view support

### 👥 Society Management

* Society registration and authentication
* Society profile management
* Social media integration

---

## 🛠️ Tech Stack

### Frontend

* HTML
* CSS
* JavaScript
* EJS

### Backend

* Node.js
* Express.js

### Database

* PostgreSQL

### APIs

* Google Maps JavaScript API

### Deployment

* Render

---

## 📂 Project Structure

```bash
campus-ai/
│
├── public/
│   ├── home.css
│   ├── events.css
│   ├── script.js
│   ├── events.js
│   └── logo.jpg
│
├── routes/
│   ├── ai.js
│   ├── event_routes.js
│   └── user.js
│
├── views/
│   ├── home.ejs
│   ├── events.ejs
│   ├── addevents.ejs
│   ├── login.ejs
│   └── get_info.ejs
│
├── server.js
├── package.json
└── README.md
```

---

## 🗄️ Database Schema

### Societies Table

```sql
CREATE TABLE societies (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    instagram VARCHAR(100),
    twitter VARCHAR(100),
    website VARCHAR(100)
);
```

### Events Table

```sql
CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    event_time TIMESTAMP NOT NULL,
    lat DOUBLE PRECISION NOT NULL,
    lng DOUBLE PRECISION NOT NULL,
    society_id INTEGER REFERENCES societies(id),
    created_at TIMESTAMP DEFAULT NOW()
);
```

---

## ⚙️ Installation

Clone the repository:

```bash
git clone https://github.com/devanshuR10/campus-ai.git
cd campus-ai
```

Install dependencies:

```bash
npm install
```

Run the application:

```bash
npm run dev
```

Server runs on:

```bash
http://localhost:8080
```

---

## 🌟 Future Enhancements

* AI-based route recommendations
* Indoor navigation
* Event notifications
* Attendance management
* Mobile application
* QR-based navigation
* Real-time crowd tracking

---

## 👨‍💻 Contributors

### Vijay Kiran

* Backend Development
* Event Management System
* Express.js Routes and APIs
* Navigation Logic
* UI Enhancements and Branding
* Event Visualization on Map

### Devanshu

* Backend Integration
* PostgreSQL Database Design
* Deployment and Configuration
* Google Maps Integration
* System Architecture
* Google Maps Integration
* Frontend Components
* Project Integration


## 📜 License

This project is developed for educational and academic purposes.

---
 live link :https://campus-ai-fe4y.onrender.com/
⭐ If you found this project useful, consider giving it a star.
