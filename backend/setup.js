const { supabase } = require('./config/supabase');

async function createTables() {
  console.log('Creating database tables in Supabase...\n');

  const tables = [
    {
      name: 'users',
      sql: `
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
      `
    },
    {
      name: 'plant_diagnoses',
      sql: `
        CREATE TABLE IF NOT EXISTS plant_diagnoses (
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
        );
      `
    },
    {
      name: 'voice_queries',
      sql: `
        CREATE TABLE IF NOT EXISTS voice_queries (
          id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
          user_id UUID,
          query_text TEXT NOT NULL,
          response_text TEXT,
          language TEXT,
          is_bookmarked BOOLEAN DEFAULT FALSE,
          created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
        );
      `
    },
    {
      name: 'chat_history',
      sql: `
        CREATE TABLE IF NOT EXISTS chat_history (
          id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
          user_id UUID,
          message TEXT NOT NULL,
          response TEXT,
          message_type TEXT DEFAULT 'text',
          created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
        );
      `
    },
    {
      name: 'weather_data',
      sql: `
        CREATE TABLE IF NOT EXISTS weather_data (
          id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
          location TEXT NOT NULL,
          current_weather JSONB,
          hourly_forecast JSONB,
          weekly_forecast JSONB,
          agricultural_alerts JSONB,
          updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
        );
      `
    },
    {
      name: 'farm_statistics',
      sql: `
        CREATE TABLE IF NOT EXISTS farm_statistics (
          id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
          user_id UUID,
          stat_type TEXT NOT NULL,
          stat_value JSONB,
          recorded_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
        );
      `
    },
    {
      name: 'user_preferences',
      sql: `
        CREATE TABLE IF NOT EXISTS user_preferences (
          id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
          user_id UUID UNIQUE,
          theme_mode TEXT DEFAULT 'light',
          notifications_enabled BOOLEAN DEFAULT TRUE,
          language TEXT DEFAULT 'English',
          offline_mode BOOLEAN DEFAULT FALSE,
          updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
        );
      `
    }
  ];

  console.log('⚠️  IMPORTANT: Tables must be created via Supabase SQL Editor\n');
  console.log('Please follow these steps:\n');
  console.log('1. Go to: https://supabase.com/dashboard/project/pfkoaoudwmunypzyzcsr');
  console.log('2. Click on "SQL Editor" in the left sidebar');
  console.log('3. Copy and paste the contents of backend/supabase_schema.sql');
  console.log('4. Click "RUN" to execute the script\n');
  console.log('Once tables are created, the API will work correctly.\n');

  console.log('Checking if tables exist...\n');
  
  for (const table of tables) {
    try {
      const { data, error } = await supabase
        .from(table.name)
        .select('count', { count: 'exact', head: true });
      
      if (error) {
        console.log(`❌ Table "${table.name}" does not exist or is not accessible`);
      } else {
        console.log(`✅ Table "${table.name}" exists`);
      }
    } catch (err) {
      console.log(`❌ Table "${table.name}" error: ${err.message}`);
    }
  }
}

createTables().then(() => {
  console.log('\nSetup check complete!');
  process.exit(0);
}).catch(err => {
  console.error('Error:', err);
  process.exit(1);
});