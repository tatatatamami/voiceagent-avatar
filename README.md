# Azure Voice Live Avatar Agent

A demo application for real-time voice AI agent with avatar video streaming using Azure Voice Live API.

## Features

- **Real-time Voice Interaction**: Process voice input from microphone in real-time
- **AI Avatar**: Real-time avatar video generation with Azure Voice Live
- **Knowledge Base Search**: Information retrieval with Azure AI Search integration
- **Japanese Language Support**: Natural conversation in Japanese

## Tech Stack

### Frontend
- React + TypeScript
- Vite
- WebRTC (Avatar video)
- Web Audio API (Audio processing)

### Backend
- Python FastAPI
- WebSocket (Real-time communication)
- Azure Voice Live API

### Infrastructure
- Azure Container Apps
- Azure Container Registry
- Azure Cognitive Services (Speech)
- Azure AI Search

## Local Development

### Prerequisites

- Node.js 18+
- Python 3.11+
- Azure CLI

### Setup

1. Clone the repository
2. Backend setup: cd backend && pip install -r requirements.txt
3. Frontend setup: cd frontend && npm install
4. Copy backend/.env.example to backend/.env and edit

### Run

1. Backend: uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
2. Frontend: npm run dev
3. Open http://localhost:5173

## Deploy to Azure

See deploy.sh for deployment instructions.

## Environment Variables

- AZURE_VOICE_LIVE_ENDPOINT: Azure Speech Service endpoint
- VOICE_LIVE_MODEL: Model to use (e.g., gpt-4o)
- AZURE_VOICE_AVATAR_ENABLED: Enable/disable avatar
- AZURE_VOICE_AVATAR_CHARACTER: Avatar character (e.g., lisa)
- AZURE_TTS_VOICE: TTS voice (e.g., ja-JP-AoiNeural)
- ai_search_url: Azure AI Search endpoint
- ai_search_key: Azure AI Search API key
- ai_index_name: Search index name

## License

MIT License

## Acknowledgments

This project uses Azure Voice Live API.
