const { supabase } = require('../config/supabase');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const registerUser = async (req, res) => {
  try {
    const {
      fullName,
      email,
      phone,
      password,
      farmLocation
    } = req.body;

    if (!fullName || (!email && !phone)) {
      return res.status(400).json({ error: 'Required fields missing' });
    }

    const passwordHash = password ? await bcrypt.hash(password, 10) : null;

    const insertData = {
      full_name: fullName,
      email: email || null,
      phone: phone || null,
      password: passwordHash
    };

    if (farmLocation) insertData.farm_location = farmLocation;

    const { data, error } = await supabase
      .from('users')
      .insert([insertData])
      .select()
      .single();

    if (error) {
      console.error('Registration error:', error);
      return res.status(400).json({ error: error.message });
    }

    const token = jwt.sign(
      { userId: data.id, email: data.email },
      process.env.JWT_SECRET,
      { expiresIn: '30d' }
    );

    res.status(201).json({
      success: true,
      message: 'User registered successfully',
      user: {
        id: data.id,
        fullName: data.full_name,
        email: data.email,
        phone: data.phone
      },
      token
    });
  } catch (error) {
    console.error('Registration error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

const loginUser = async (req, res) => {
  try {
    const { email, phone, password } = req.body;

    if ((!email && !phone) || !password) {
      return res.status(400).json({ error: 'Email/phone and password required' });
    }

    let query = supabase.from('users').select('*');
    
    if (email) {
      query = query.eq('email', email);
    } else {
      query = query.eq('phone', phone);
    }

    const { data, error } = await query.single();

    if (error || !data) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }

    if (!data.password) {
      return res.status(401).json({ error: 'Password not set for this account' });
    }

    const isValidPassword = await bcrypt.compare(password, data.password);

    if (!isValidPassword) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }

    const token = jwt.sign(
      { userId: data.id, email: data.email },
      process.env.JWT_SECRET,
      { expiresIn: '30d' }
    );

    res.json({
      success: true,
      message: 'Login successful',
      user: {
        id: data.id,
        fullName: data.full_name,
        email: data.email,
        phone: data.phone,
        farmLocation: data.farm_location
      },
      token
    });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

const getUserProfile = async (req, res) => {
  try {
    const userId = req.user.userId;

    const { data, error } = await supabase
      .from('users')
      .select('*')
      .eq('id', userId)
      .single();

    if (error) {
      return res.status(404).json({ error: 'User not found' });
    }

    res.json({
      success: true,
      user: {
        id: data.id,
        fullName: data.full_name,
        email: data.email,
        phone: data.phone,
        farmLocation: data.farm_location
      }
    });
  } catch (error) {
    console.error('Get profile error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

const updateUserProfile = async (req, res) => {
  try {
    const userId = req.user.userId;
    const updates = req.body;

    const allowedFields = [
      'full_name',
      'email',
      'phone',
      'farm_location'
    ];

    const updateData = {};
    Object.keys(updates).forEach(key => {
      if (allowedFields.includes(key)) {
        updateData[key] = updates[key];
      }
    });

    const { data, error } = await supabase
      .from('users')
      .update(updateData)
      .eq('id', userId)
      .select()
      .single();

    if (error) {
      return res.status(400).json({ error: error.message });
    }

    res.json({
      success: true,
      message: 'Profile updated successfully',
      user: data
    });
  } catch (error) {
    console.error('Update profile error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

module.exports = {
  registerUser,
  loginUser,
  getUserProfile,
  updateUserProfile
};