const { supabase } = require('../config/supabase');

const saveDiagnosis = async (req, res) => {
  try {
    const userId = req.user.userId;
    const {
      imageUrl,
      diseaseName,
      diseaseSeverity,
      confidence,
      description,
      treatments
    } = req.body;

    if (!imageUrl || !diseaseName) {
      return res.status(400).json({ error: 'Image URL and disease name required' });
    }

    const { data, error } = await supabase
      .from('plant_diagnoses')
      .insert([
        {
          user_id: userId,
          image_url: imageUrl,
          disease_name: diseaseName,
          disease_severity: diseaseSeverity,
          confidence: confidence,
          description: description,
          treatments: treatments || []
        }
      ])
      .select()
      .single();

    if (error) {
      console.error('Save diagnosis error:', error);
      return res.status(400).json({ error: error.message });
    }

    res.status(201).json({
      success: true,
      message: 'Diagnosis saved successfully',
      diagnosis: data
    });
  } catch (error) {
    console.error('Save diagnosis error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

const getUserDiagnoses = async (req, res) => {
  try {
    const userId = req.user.userId;
    const { limit = 20, offset = 0 } = req.query;

    const { data, error, count } = await supabase
      .from('plant_diagnoses')
      .select('*', { count: 'exact' })
      .eq('user_id', userId)
      .order('created_at', { ascending: false })
      .range(offset, offset + limit - 1);

    if (error) {
      return res.status(400).json({ error: error.message });
    }

    res.json({
      success: true,
      diagnoses: data,
      total: count,
      limit: parseInt(limit),
      offset: parseInt(offset)
    });
  } catch (error) {
    console.error('Get diagnoses error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

const getDiagnosisById = async (req, res) => {
  try {
    const { id } = req.params;
    const userId = req.user.userId;

    const { data, error } = await supabase
      .from('plant_diagnoses')
      .select('*')
      .eq('id', id)
      .eq('user_id', userId)
      .single();

    if (error || !data) {
      return res.status(404).json({ error: 'Diagnosis not found' });
    }

    res.json({
      success: true,
      diagnosis: data
    });
  } catch (error) {
    console.error('Get diagnosis error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

const toggleBookmark = async (req, res) => {
  try {
    const { id } = req.params;
    const userId = req.user.userId;

    const { data: existing } = await supabase
      .from('plant_diagnoses')
      .select('is_bookmarked')
      .eq('id', id)
      .eq('user_id', userId)
      .single();

    if (!existing) {
      return res.status(404).json({ error: 'Diagnosis not found' });
    }

    const { data, error } = await supabase
      .from('plant_diagnoses')
      .update({ is_bookmarked: !existing.is_bookmarked })
      .eq('id', id)
      .eq('user_id', userId)
      .select()
      .single();

    if (error) {
      return res.status(400).json({ error: error.message });
    }

    res.json({
      success: true,
      message: 'Bookmark toggled successfully',
      diagnosis: data
    });
  } catch (error) {
    console.error('Toggle bookmark error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

const getBookmarkedDiagnoses = async (req, res) => {
  try {
    const userId = req.user.userId;

    const { data, error } = await supabase
      .from('plant_diagnoses')
      .select('*')
      .eq('user_id', userId)
      .eq('is_bookmarked', true)
      .order('created_at', { ascending: false });

    if (error) {
      return res.status(400).json({ error: error.message });
    }

    res.json({
      success: true,
      diagnoses: data
    });
  } catch (error) {
    console.error('Get bookmarked diagnoses error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

const deleteDiagnosis = async (req, res) => {
  try {
    const { id } = req.params;
    const userId = req.user.userId;

    const { error } = await supabase
      .from('plant_diagnoses')
      .delete()
      .eq('id', id)
      .eq('user_id', userId);

    if (error) {
      return res.status(400).json({ error: error.message });
    }

    res.json({
      success: true,
      message: 'Diagnosis deleted successfully'
    });
  } catch (error) {
    console.error('Delete diagnosis error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

module.exports = {
  saveDiagnosis,
  getUserDiagnoses,
  getDiagnosisById,
  toggleBookmark,
  getBookmarkedDiagnoses,
  deleteDiagnosis
};