# Azure Voice Live Avatar Agent

Azure Voice Live APIを使用したリアルタイム音声AIエージェントとアバター映像ストリーミングのチE��アプリケーションです、E
## 🎥 チE��

**チE�Eロイ済みアプリ**: [https://voice-live-avatar-app.braveriver-6621931b.eastus2.azurecontainerapps.io](https://voice-live-avatar-app.braveriver-6621931b.eastus2.azurecontainerapps.io)

## ✨ 機�E

- 🎤 **リアルタイム音声対話**: マイクからの音声入力をリアルタイムで処琁E- 🎭 **AIアバター**: Azure Voice Liveによるリアルタイムアバター映像生戁E- 🔍 **ナレチE��ベ�Eス検索**: Azure AI Searchと連携した惁E��検索
- 🗣�E�E**日本語対忁E*: 日本語での自然な会話が可能

## 🛠�E�E技術スタチE��

### フロントエンチE- React + TypeScript
- Vite
- WebRTC (アバター映僁E
- Web Audio API (音声処琁E

### バックエンチE- Python FastAPI
- WebSocket (リアルタイム通信)
- Azure Voice Live API

### インフラ
- Azure Container Apps
- Azure Container Registry
- Azure Cognitive Services (Speech)
- Azure AI Search

## 📁 プロジェクト構�E

```
├── frontend/           # React フロントエンチE━E  ├── src/
━E  ━E  ├── App.tsx    # メインコンポ�EネンチE━E  ━E  └── styles.css # スタイル
━E  └── package.json
├── backend/            # FastAPI バックエンチE━E  ├── app/
━E  ━E  ├── main.py           # APIエンド�EインチE━E  ━E  ├── voice_live_client.py  # Azure Voice Live クライアンチE━E  ━E  ├── session_manager.py    # セチE��ョン管琁E━E  ━E  └── tools.py          # AI Search チE�Eル
━E  └── requirements.txt
├── Dockerfile          # マルチスチE�EジビルチE├── deploy.sh           # チE�Eロイスクリプト
└── start.sh            # 起動スクリプト
```

## 🚀 ローカル開発

### 前提条件

- Node.js 18+
- Python 3.11+
- Azure CLI

### セチE��アチE�E

1. **リポジトリのクローン**
   ```bash
   git clone https://github.com/tatatatamami/voiceagent-avatar.git
   cd voiceagent-avatar
   ```

2. **バックエンド�EセチE��アチE�E**
   ```bash
   cd backend
   python -m venv venv
   source venv/bin/activate  # Windows: venv\Scripts\activate
   pip install -r requirements.txt
   ```

3. **環墁E��数の設宁E*
   ```bash
   cp backend/.env.example backend/.env
   # .envファイルを編雁E��て忁E��な値を設宁E   ```

4. **フロントエンド�EセチE��アチE�E**
   ```bash
   cd frontend
   npm install
   ```

### 起勁E
1. **バックエンド起勁E*
   ```bash
   cd backend
   uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
   ```

2. **フロントエンド起勁E*
   ```bash
   cd frontend
   npm run dev
   ```

3. ブラウザで http://localhost:5173 にアクセス

## ☁E��EAzure へのチE�Eロイ

### 前提条件

- Azure サブスクリプション
- Azure CLI インスト�Eル済み
- Docker インスト�Eル済み

### チE�Eロイ手頁E
1. **Azure にログイン**
   ```bash
   az login
   ```

2. **チE�Eロイスクリプトの設定を編雁E*
   ```bash
   # deploy.sh の RESOURCE_GROUP などを編雁E   ```

3. **チE�Eロイ実衁E*
   ```bash
   ./deploy.sh
   ```

   また�E手動で:
   ```bash
   # ACR にビルチE& プッシュ
   az acr build --registry <your-acr> --image voice-live-avatar:latest .

   # Container App を更新
   az containerapp update --name <your-app> --resource-group <your-rg> \
       --image <your-acr>.azurecr.io/voice-live-avatar:latest
   ```

## ⚙︁E環墁E��数

| 変数吁E| 説昁E|
|--------|------|
| `AZURE_VOICE_LIVE_ENDPOINT` | Azure Speech Service のエンド�EインチE|
| `VOICE_LIVE_MODEL` | 使用するモチE�� (侁E gpt-4o) |
| `AZURE_VOICE_AVATAR_ENABLED` | アバターの有効/無効 (true/false) |
| `AZURE_VOICE_AVATAR_CHARACTER` | アバターキャラクター (侁E lisa) |
| `AZURE_TTS_VOICE` | 音声合�Eの声 (侁E ja-JP-AoiNeural) |
| `ai_search_url` | Azure AI Search のエンド�EインチE|
| `ai_search_key` | Azure AI Search のAPIキー |
| `ai_index_name` | 検索インチE��クス吁E|

## 📝 ライセンス

MIT License

## 🙏 謝辁E
こ�Eプロジェクト�E [Azure Voice Live API](https://learn.microsoft.com/azure/ai-services/speech-service/) を使用してぁE��す、E4. **Direct Connection**: Frontend establishes direct WebRTC connection to Azure Voice Live
5. **Video Streaming**: Avatar video streams directly from Azure to browser (bypassing backend)
6. **ICE Server Configuration**: Backend provides TURN/STUN servers via WebSocket for NAT traversal

🔧 FUNCTION CALLS:
GPT Realtime ↁEFastAPI Tools ↁEBusiness APIs ↁEResponse ↁEGPT Realtime

1. **AI Decision**: GPT-4 Realtime Model (accessed via Azure Voice Live API) determines when to call functions based on conversation
2. **Function Execution**: Backend receives function calls from Azure Voice Live API and executes them:
   - Azure AI Search for knowledge queries
   - E-commerce APIs for product searches and orders
   - Logic Apps for shipments and call logging
3. **Result Return**: Backend sends function results back to Azure Voice Live API
4. **Response Generation**: GPT-4 Realtime Model (via Azure Voice Live API) incorporates results into conversational response

Function call outputs are posted back to the realtime session so the model can continue the conversation seamlessly.


