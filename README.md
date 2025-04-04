# 🧠 AI Assistant Flutter App

![video_2025-04-04_08-54-44-ezgif com-optimize (1)](https://github.com/user-attachments/assets/473b5714-ad7e-4328-8a7e-5ca292eedd62)

This is a Flutter-based mobile application that acts as a smart AI assistant. It leverages powerful AI models to chat with users and generate images based on textual prompts.

## ✨ Features

- 💬 Chat with an AI model (powered by Hugging Face)
- 🖼️ Generate images from text using AI
- 🔀 Tabbed UI for smooth navigation between Chat and Image tools
- 📱 Clean and responsive Flutter UI
- 🌐 Backend API powered by Node.js

---

## 🚀 Technologies Used

### 🔧 Frontend
- **Flutter**
- **Dart**
- **Material UI Widgets**

### 🧠 Backend (Node.js)
- **Express.js**
- **Hugging Face Inference API**

---

## 🤖 AI Models Used

1. **Chat Model**  
   - Model: `mistralai/Mixtral-8x7B-Instruct-v0.1` *(or your specific model)*
   - Hosted via: Hugging Face Inference API

2. **Image Generation Model**  
   - Model: `stabilityai/stable-diffusion-2`
   - Hosted via: Hugging Face Inference API

---

## 📱 UI Structure

- **Sidebar**: Navigation to Home, Sign In, Settings, Logout
- **Tabs**: `Chat` and `Image` tabs using `TabController`
- **Chat Page**: Input field + text response
- **Image Page**: Input field + image display (base64 decoded)

---
