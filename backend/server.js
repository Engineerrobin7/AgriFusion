const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
require('dotenv').config();

const { initializeDatabase } = require('./config/database');
const userRoutes = require('./routes/userRoutes');
const diagnosisRoutes = require('./routes/diagnosisRoutes');
const voiceRoutes = require('./routes/voiceRoutes');
const weatherRoutes = require('./routes/weatherRoutes');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(bodyParser.json({ limit: '50mb' }));
app.use(bodyParser.urlencoded({ extended: true, limit: '50mb' }));

app.get('/', (req, res) => {
  res.json({
    message: 'AgriFusion API Server',
    version: '1.0.0',
    status: 'Running',
    endpoints: {
      users: '/api/users',
      diagnoses: '/api/diagnoses',
      voice: '/api/voice',
      weather: '/api/weather'
    }
  });
});

app.get('/health', (req, res) => {
  res.json({ status: 'healthy', timestamp: new Date().toISOString() });
});

app.use('/api/users', userRoutes);
app.use('/api/diagnoses', diagnosisRoutes);
app.use('/api/voice', voiceRoutes);
app.use('/api/weather', weatherRoutes);

app.use((err, req, res, next) => {
  console.error('Error:', err);
  res.status(500).json({ error: 'Internal server error', message: err.message });
});

app.use((req, res) => {
  res.status(404).json({ error: 'Route not found' });
});

async function startServer() {
  try {
    console.log('Starting AgriFusion API Server...');
    
    await initializeDatabase();
    
    app.listen(PORT, '0.0.0.0', () => {
      console.log(`\n✅ Server running on port ${PORT}`);
      console.log(`📍 API Base URL: http://localhost:${PORT}`);
      console.log(`📍 Health Check: http://localhost:${PORT}/health`);
      console.log('\n📚 Available Endpoints:');
      console.log('  POST   /api/users/register');
      console.log('  POST   /api/users/login');
      console.log('  GET    /api/users/profile');
      console.log('  PUT    /api/users/profile');
      console.log('  POST   /api/diagnoses');
      console.log('  GET    /api/diagnoses');
      console.log('  POST   /api/voice/query');
      console.log('  GET    /api/voice/query');
      console.log('  POST   /api/voice/chat');
      console.log('  GET    /api/voice/chat');
      console.log('  POST   /api/weather');
      console.log('  GET    /api/weather');
      console.log('\n🔒 Protected routes require Authorization header with Bearer token');
      console.log('\n');
    });
  } catch (error) {
    console.error('Failed to start server:', error);
    process.exit(1);
  }
}

startServer();

module.exports = app;
