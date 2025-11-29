const { supabase } = require('../config/supabase');

const saveWeatherData = async (req, res) => {
  try {
    const {
      location,
      currentWeather,
      hourlyForecast,
      weeklyForecast,
      agriculturalAlerts
    } = req.body;

    if (!location) {
      return res.status(400).json({ error: 'Location required' });
    }

    const { data: existing } = await supabase
      .from('weather_data')
      .select('id')
      .eq('location', location)
      .single();

    let data, error;

    if (existing) {
      const result = await supabase
        .from('weather_data')
        .update({
          current_weather: currentWeather,
          hourly_forecast: hourlyForecast,
          weekly_forecast: weeklyForecast,
          agricultural_alerts: agriculturalAlerts,
          updated_at: new Date().toISOString()
        })
        .eq('id', existing.id)
        .select()
        .single();
      
      data = result.data;
      error = result.error;
    } else {
      const result = await supabase
        .from('weather_data')
        .insert([
          {
            location,
            current_weather: currentWeather,
            hourly_forecast: hourlyForecast,
            weekly_forecast: weeklyForecast,
            agricultural_alerts: agriculturalAlerts
          }
        ])
        .select()
        .single();
      
      data = result.data;
      error = result.error;
    }

    if (error) {
      console.error('Save weather data error:', error);
      return res.status(400).json({ error: error.message });
    }

    res.status(201).json({
      success: true,
      message: 'Weather data saved successfully',
      weather: data
    });
  } catch (error) {
    console.error('Save weather data error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

const getWeatherData = async (req, res) => {
  try {
    const { location } = req.query;

    if (!location) {
      return res.status(400).json({ error: 'Location required' });
    }

    const { data, error } = await supabase
      .from('weather_data')
      .select('*')
      .eq('location', location)
      .single();

    if (error || !data) {
      return res.status(404).json({ 
        error: 'Weather data not found for this location',
        location 
      });
    }

    const updatedAt = new Date(data.updated_at);
    const now = new Date();
    const hoursSinceUpdate = (now - updatedAt) / (1000 * 60 * 60);

    res.json({
      success: true,
      weather: data,
      isStale: hoursSinceUpdate > 1
    });
  } catch (error) {
    console.error('Get weather data error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

const getAllLocations = async (req, res) => {
  try {
    const { data, error } = await supabase
      .from('weather_data')
      .select('location, updated_at')
      .order('updated_at', { ascending: false });

    if (error) {
      return res.status(400).json({ error: error.message });
    }

    res.json({
      success: true,
      locations: data
    });
  } catch (error) {
    console.error('Get locations error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

module.exports = {
  saveWeatherData,
  getWeatherData,
  getAllLocations
};