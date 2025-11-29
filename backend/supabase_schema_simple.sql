-- Simplified AgriFusion Database Schema for Supabase
-- Run this script in your Supabase SQL Editor if you're having schema cache issues

-- Drop existing tables (optional - uncomment if you want fresh start)
-- DROP TABLE IF EXISTS user_preferences CASCADE;
-- DROP TABLE IF EXISTS farm_statistics CASCADE;
-- DROP TABLE IF EXISTS weather_data CASCADE;
-- DROP TABLE IF EXISTS chat_history CASCADE;
-- DROP TABLE IF EXISTS voice_queries CASCADE;
-- DROP TABLE IF EXISTS plant_diagnoses CASCADE;
-- DROP TABLE IF EXISTS users CASCADE;

-- Users table (simplified)
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  full_name TEXT NOT NULL,
  email TEXT UNIQUE,
  phone TEXT UNIQUE,
  password TEXT,
  farm_location TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Plant diagnoses table
CREATE TABLE IF NOT EXISTS plant_diagnoses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  image_url TEXT NOT NULL,
  disease_name TEXT NOT NULL,
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
  is_bookmarked BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Chat history table
CREATE TABLE IF NOT EXISTS chat_history (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  message TEXT NOT NULL,
  response TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Weather data table
CREATE TABLE IF NOT EXISTS weather_data (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  location TEXT NOT NULL,
  data JSONB,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_diagnoses_user ON plant_diagnoses(user_id);
CREATE INDEX IF NOT EXISTS idx_voice_queries_user ON voice_queries(user_id);

-- Enable RLS
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE plant_diagnoses ENABLE ROW LEVEL SECURITY;
ALTER TABLE voice_queries ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE weather_data ENABLE ROW LEVEL SECURITY;

-- Create simple policies
CREATE POLICY "Enable all for users" ON users FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Enable all for diagnoses" ON plant_diagnoses FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Enable all for queries" ON voice_queries FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Enable all for chats" ON chat_history FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Enable all for weather" ON weather_data FOR ALL USING (true) WITH CHECK (true);

SELECT 'AgriFusion simplified schema created!' as message;