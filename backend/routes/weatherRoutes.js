const express = require('express');
const router = express.Router();
const authenticateToken = require('../middleware/auth');
const {
  saveWeatherData,
  getWeatherData,
  getAllLocations
} = require('../controllers/weatherController');

router.post('/', authenticateToken, saveWeatherData);
router.get('/', getWeatherData);
router.get('/locations', getAllLocations);

module.exports = router;