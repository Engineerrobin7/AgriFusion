const { supabase } = require('./supabase');

async function initializeDatabase() {
  console.log('Initializing Supabase database schema...');

  try {
    const { data, error } = await supabase.rpc('initialize_agrifusion_schema', {
      schema_sql: `
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
      `
    });

    if (error) {
      console.log('Note: RPC method not available. Creating tables directly...');
      await createTablesDirectly();
    } else {
      console.log('Database schema initialized successfully!');
    }
  } catch (err) {
    console.log('Initializing tables directly...');
    await createTablesDirectly();
  }
}

async function createTablesDirectly() {
  const tables = [
    {
      name: 'users',
      columns: `
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
      `
    },
    {
      name: 'plant_diagnoses',
      columns: `
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        user_id UUID,
        image_url TEXT NOT NULL,
        disease_name TEXT NOT NULL,
        disease_severity TEXT,
        confidence NUMERIC,
        description TEXT,
        treatments JSONB,
        is_bookmarked BOOLEAN DEFAULT FALSE,
        created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
      `
    },
    {
      name: 'voice_queries',
      columns: `
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        user_id UUID,
        query_text TEXT NOT NULL,
        response_text TEXT,
        language TEXT,
        is_bookmarked BOOLEAN DEFAULT FALSE,
        created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
      `
    },
    {
      name: 'chat_history',
      columns: `
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        user_id UUID,
        message TEXT NOT NULL,
        response TEXT,
        message_type TEXT DEFAULT 'text',
        created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
      `
    },
    {
      name: 'weather_data',
      columns: `
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        location TEXT NOT NULL,
        current_weather JSONB,
        hourly_forecast JSONB,
        weekly_forecast JSONB,
        agricultural_alerts JSONB,
        updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
      `
    },
    {
      name: 'farm_statistics',
      columns: `
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        user_id UUID,
        stat_type TEXT NOT NULL,
        stat_value JSONB,
        recorded_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
      `
    },
    {
      name: 'user_preferences',
      columns: `
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        user_id UUID UNIQUE,
        theme_mode TEXT DEFAULT 'light',
        notifications_enabled BOOLEAN DEFAULT TRUE,
        language TEXT DEFAULT 'English',
        offline_mode BOOLEAN DEFAULT FALSE,
        updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
      `
    }
  ];

  console.log('Tables will be created via Supabase Dashboard or SQL Editor.');
  console.log('Please run the following SQL in your Supabase SQL Editor:\n');
  
  tables.forEach(table => {
    console.log(`CREATE TABLE IF NOT EXISTS ${table.name} (${table.columns});`);
  });

  console.log('\nAPI server will start and work with existing tables.');
}

module.exports = { initializeDatabase };