# AgriFusion - Complete Setup Guide

AgriFusion is a fully functional intelligent agricultural assistance application with Flutter frontend and Node.js backend connected to Supabase database.

## 📋 Project Structure

```
AgriFusion/
├── backend/              # Node.js Express API server
│   ├── config/          # Database and Supabase configuration
│   ├── controllers/     # API endpoint logic
│   ├── middleware/      # Authentication middleware
│   ├── routes/          # API routes
│   ├── .env            # Environment variables (Supabase credentials)
│   ├── server.js       # Main server file
│   └── supabase_schema.sql  # Database schema
├── lib/                 # Flutter application source code
│   ├── presentation/   # UI screens
│   ├── services/       # API services
│   ├── core/          # Core utilities
│   ├── routes/        # App routing
│   └── main.dart      # App entry point
└── pubspec.yaml        # Flutter dependencies
```

## 🚀 Quick Start

### Step 1: Database Setup (Supabase)

1. Go to your Supabase Dashboard:
   https://supabase.com/dashboard/project/pfkoaoudwmunypzyzcsr

2. Click on **SQL Editor** in the left sidebar

3. Open `backend/supabase_schema.sql` file

4. Copy the entire SQL script and paste it into the Supabase SQL Editor

5. Click **RUN** to execute the script

6. Verify tables were created by going to **Table Editor** - you should see:
   - users
   - plant_diagnoses
   - voice_queries
   - chat_history
   - weather_data
   - farm_statistics
   - user_preferences

### Step 2: Start Backend Server

```bash
cd backend
npm install
npm start
```

The backend will start on `http://localhost:3000`

You should see:
```
✅ Server running on port 3000
📍 API Base URL: http://localhost:3000
```

### Step 3: Run Flutter App

```bash
# From the project root directory
flutter pub get
flutter run
```

For web:
```bash
flutter run -d chrome
```

For mobile (with device/emulator connected):
```bash
flutter run
```

## 🔐 Environment Variables

The `.env` file in the backend directory contains:

```env
SUPABASE_URL=https://pfkoaoudwmunypzyzcsr.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
PORT=3000
JWT_SECRET=agrifusion_secret_key_2024
```

⚠️ **IMPORTANT**: These credentials are already configured. Do not share them publicly.

## 📱 Features & Data Flow

### 1. User Registration & Authentication
- Users register with name, email/phone, password, and farm details
- Data saved to `users` table in Supabase
- JWT token generated for authenticated requests
- Token stored locally on device

### 2. Plant Disease Diagnosis
- User captures/uploads plant image
- Diagnosis results saved to `plant_diagnoses` table
- Includes disease name, severity, confidence, treatments
- Supports bookmarking and history

### 3. Voice Queries (AI Assistant)
- Voice queries transcribed to text
- Saved to `voice_queries` table
- Conversation history with AI responses
- Multi-language support

### 4. Chat History
- All chat conversations saved to `chat_history` table
- Linked to user account
- Searchable and filterable

### 5. Weather Insights
- Weather data cached in `weather_data` table
- Location-based forecasts
- Agricultural alerts
- Hourly and weekly predictions

## 🔌 API Integration

The Flutter app connects to the backend via HTTP services located in `lib/services/`:

- `user_service.dart` - User authentication and profile
- `diagnosis_service.dart` - Plant diagnosis operations
- `voice_service.dart` - Voice queries and chat
- `weather_service.dart` - Weather data

All services use the base API URL configured in `lib/services/api_constants.dart`:
```dart
static const String baseUrl = 'http://localhost:3000/api';
```

**For production/deployment**, update this URL to your deployed backend URL.

## 📊 Database Schema

### Users Table
```sql
- id (UUID, primary key)
- full_name (text)
- email (text, unique)
- phone (text, unique)
- password_hash (text)
- farm_size (numeric)
- farm_location (text)
- crop_types (text[])
- language_preference (text)
- created_at (timestamp)
- updated_at (timestamp)
```

### Plant Diagnoses Table
```sql
- id (UUID, primary key)
- user_id (UUID, foreign key)
- image_url (text)
- disease_name (text)
- disease_severity (text)
- confidence (numeric)
- description (text)
- treatments (jsonb)
- is_bookmarked (boolean)
- created_at (timestamp)
```

See `backend/supabase_schema.sql` for complete schema.

## 🧪 Testing the Application

### 1. Test Backend API

```bash
# Health check
curl http://localhost:3000/health

# Register a user
curl -X POST http://localhost:3000/api/users/register \
  -H "Content-Type: application/json" \
  -d '{
    "fullName": "Test Farmer",
    "email": "test@farm.com",
    "password": "test123",
    "farmLocation": "Maharashtra"
  }'
```

### 2. Test Flutter App

1. Launch the app
2. Complete registration with your details
3. Navigate through different features:
   - Home Dashboard
   - Camera Diagnosis
   - Voice Query
   - Weather Insights
   - Profile Settings

All data will be saved to Supabase database!

## 🛠️ Troubleshooting

### Backend Issues

**Port already in use:**
```bash
# Kill process on port 3000
lsof -ti:3000 | xargs kill -9
# Or change PORT in .env file
```

**Database connection errors:**
- Verify Supabase credentials in `.env`
- Check Supabase project status
- Ensure schema was created successfully

### Flutter Issues

**Package errors:**
```bash
flutter clean
flutter pub get
```

**Build errors:**
```bash
# For Android
cd android && ./gradlew clean && cd ..

# For iOS
cd ios && pod install && cd ..
```

**API connection errors:**
- Ensure backend server is running
- Check API URL in `lib/services/api_constants.dart`
- Verify network connectivity

## 📝 Important Notes

1. **Authentication**: All user data operations require authentication token
2. **Data Persistence**: All data is saved to Supabase PostgreSQL database
3. **Real-time**: The app uses REST API (not real-time subscriptions)
4. **Offline Mode**: Currently requires internet connection
5. **Image Storage**: Images should be uploaded to Supabase Storage (or external CDN)

## 🔄 Next Steps for Production

1. **Deploy Backend**:
   - Deploy to Heroku, Railway, or Render
   - Update API_URL in Flutter app

2. **Image Storage**:
   - Set up Supabase Storage bucket
   - Implement image upload in diagnosis flow

3. **Environment Configuration**:
   - Use flutter_dotenv for environment variables
   - Separate dev/prod configurations

4. **Security**:
   - Enable RLS policies in Supabase
   - Implement rate limiting
   - Add input validation

5. **Testing**:
   - Add unit tests
   - Add integration tests
   - Test on multiple devices

## 📞 Support

For issues:
1. Check backend logs: `cd backend && npm start`
2. Check Flutter logs: `flutter run -v`
3. Verify Supabase dashboard for data

## ✅ Checklist

- [ ] Supabase tables created
- [ ] Backend server running
- [ ] Flutter dependencies installed
- [ ] App running on device/emulator
- [ ] User registration working
- [ ] Data saving to database
- [ ] Authentication working
- [ ] All features functional

Your AgriFusion app is now fully functional with database integration! 🎉
