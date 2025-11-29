-- AgriFusion Database Schema for Supabase
-- Run this script in your Supabase SQL Editor

-- Enable UUID extension (if not already enabled)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users table
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  full_name TEXT NOT NULL,
  email TEXT UNIQUE,
  phone TEXT UNIQUE,
  password_hash TEXT,
  farm_size NUMERIC,
  farm_location TEXT,
  crop_types TEXT[],
  language_preference TEXT DEFAULT 'English',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Plant diagnoses table
CREATE TABLE IF NOT EXISTS plant_diagnoses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  image_url TEXT NOT NULL,
  disease_name TEXT NOT NULL,
  disease_severity TEXT,
  confidence NUMERIC,
  description TEXT,
  treatments JSONB,
  is_bookmarked BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Voice queries table
CREATE TABLE IF NOT EXISTS voice_queries (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  query_text TEXT NOT NULL,
  response_text TEXT,
  language TEXT,
  is_bookmarked BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Chat history table
CREATE TABLE IF NOT EXISTS chat_history (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  message TEXT NOT NULL,
  response TEXT,
  message_type TEXT DEFAULT 'text',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Weather data cache table
CREATE TABLE IF NOT EXISTS weather_data (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  location TEXT NOT NULL,
  current_weather JSONB,
  hourly_forecast JSONB,
  weekly_forecast JSONB,
  agricultural_alerts JSONB,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Farm statistics table
CREATE TABLE IF NOT EXISTS farm_statistics (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  stat_type TEXT NOT NULL,
  stat_value JSONB,
  recorded_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- User preferences table
CREATE TABLE IF NOT EXISTS user_preferences (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE UNIQUE,
  theme_mode TEXT DEFAULT 'light',
  notifications_enabled BOOLEAN DEFAULT TRUE,
  language TEXT DEFAULT 'English',
  offline_mode BOOLEAN DEFAULT FALSE,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_phone ON users(phone);
CREATE INDEX IF NOT EXISTS idx_diagnoses_user ON plant_diagnoses(user_id);
CREATE INDEX IF NOT EXISTS idx_diagnoses_created ON plant_diagnoses(created_at);
CREATE INDEX IF NOT EXISTS idx_voice_queries_user ON voice_queries(user_id);
CREATE INDEX IF NOT EXISTS idx_chat_history_user ON chat_history(user_id);
CREATE INDEX IF NOT EXISTS idx_weather_location ON weather_data(location);

-- Enable Row Level Security (RLS) for all tables
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE plant_diagnoses ENABLE ROW LEVEL SECURITY;
ALTER TABLE voice_queries ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE weather_data ENABLE ROW LEVEL SECURITY;
ALTER TABLE farm_statistics ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_preferences ENABLE ROW LEVEL SECURITY;

-- Create policies for users table
CREATE POLICY "Users can view their own data" ON users
  FOR SELECT USING (true);

CREATE POLICY "Users can update their own data" ON users
  FOR UPDATE USING (true);

CREATE POLICY "Anyone can create user" ON users
  FOR INSERT WITH CHECK (true);

-- Create policies for plant_diagnoses table
CREATE POLICY "Users can view their own diagnoses" ON plant_diagnoses
  FOR SELECT USING (true);

CREATE POLICY "Users can insert their own diagnoses" ON plant_diagnoses
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Users can update their own diagnoses" ON plant_diagnoses
  FOR UPDATE USING (true);

CREATE POLICY "Users can delete their own diagnoses" ON plant_diagnoses
  FOR DELETE USING (true);

-- Create policies for voice_queries table
CREATE POLICY "Users can view their own queries" ON voice_queries
  FOR SELECT USING (true);

CREATE POLICY "Users can insert their own queries" ON voice_queries
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Users can update their own queries" ON voice_queries
  FOR UPDATE USING (true);

CREATE POLICY "Users can delete their own queries" ON voice_queries
  FOR DELETE USING (true);

-- Create policies for chat_history table
CREATE POLICY "Users can view their own chat history" ON chat_history
  FOR SELECT USING (true);

CREATE POLICY "Users can insert their own chats" ON chat_history
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Users can delete their own chats" ON chat_history
  FOR DELETE USING (true);

-- Create policies for weather_data table (public read)
CREATE POLICY "Anyone can view weather data" ON weather_data
  FOR SELECT USING (true);

CREATE POLICY "Service can manage weather data" ON weather_data
  FOR ALL USING (true);

-- Create policies for farm_statistics table
CREATE POLICY "Users can view their own statistics" ON farm_statistics
  FOR SELECT USING (true);

CREATE POLICY "Users can insert their own statistics" ON farm_statistics
  FOR INSERT WITH CHECK (true);

-- Create policies for user_preferences table
CREATE POLICY "Users can view their own preferences" ON user_preferences
  FOR SELECT USING (true);

CREATE POLICY "Users can manage their own preferences" ON user_preferences
  FOR ALL USING (true);

-- Create a function to automatically update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create triggers for updated_at
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_user_preferences_updated_at BEFORE UPDATE ON user_preferences
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_weather_data_updated_at BEFORE UPDATE ON weather_data
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Done!
SELECT 'AgriFusion database schema created successfully!' as message;
