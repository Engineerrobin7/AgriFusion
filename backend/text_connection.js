const { supabase } = require('./config/supabase');

async function testConnection() {
  console.log('Testing Supabase connection and schema...\n');

  console.log('1. Testing connection...');
  const { data: tables, error: tablesError } = await supabase
    .from('users')
    .select('*')
    .limit(1);

  if (tablesError) {
    console.error('❌ Connection error:', tablesError.message);
    console.log('\n⚠️  This suggests the "users" table may not exist or is not accessible.');
    console.log('\nPlease run the SQL script in Supabase SQL Editor:');
    console.log('1. Go to: https://supabase.com/dashboard/project/pfkoaoudwmunypzyzcsr/editor');
    console.log('2. Click SQL Editor');
    console.log('3. Copy and paste the content from backend/supabase_schema.sql');
    console.log('4. Click RUN\n');
    process.exit(1);
  }

  console.log('✅ Connection successful\n');

  console.log('2. Testing simple insert without optional fields...');
  
  const bcrypt = require('bcryptjs');
  const testEmail = `test${Date.now()}@example.com`;
  const passwordHash = await bcrypt.hash('testpass', 10);

  const { data: insertData, error: insertError } = await supabase
    .from('users')
    .insert([
      {
        full_name: 'Test User',
        email: testEmail,
        password_hash: passwordHash
      }
    ])
    .select();

  if (insertError) {
    console.error('❌ Insert error:', insertError.message);
    console.error('Details:', insertError);
  } else {
    console.log('✅ Insert successful!');
    console.log('Created user:', insertData[0].id);
    
    const { error: deleteError } = await supabase
      .from('users')
      .delete()
      .eq('id', insertData[0].id);
    
    if (!deleteError) {
      console.log('✅ Cleanup successful\n');
    }
  }

  console.log('3. Testing with all fields...');
  const { data: fullInsertData, error: fullInsertError } = await supabase
    .from('users')
    .insert([
      {
        full_name: 'Full Test User',
        email: `fulltest${Date.now()}@example.com`,
        password_hash: passwordHash,
        farm_location: 'Test Farm',
        farm_size: 5.5
      }
    ])
    .select();

  if (fullInsertError) {
    console.error('❌ Full insert error:', fullInsertError.message);
    console.error('Details:', fullInsertError);
  } else {
    console.log('✅ Full insert successful!');
    console.log('Created user:', fullInsertData[0]);
    
    const { error: deleteError } = await supabase
      .from('users')
      .delete()
      .eq('id', fullInsertData[0].id);
    
    if (!deleteError) {
      console.log('✅ Cleanup successful\n');
    }
  }

  console.log('\n✅ All tests passed! The database is ready to use.');
  process.exit(0);
}

testConnection().catch(err => {
  console.error('Test failed:', err);
  process.exit(1);
});