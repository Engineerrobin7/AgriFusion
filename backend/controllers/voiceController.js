const { supabase } = require('../config/supabase');

const saveVoiceQuery = async (req, res) => {
  try {
    const userId = req.user.userId;
    const { queryText, responseText, language } = req.body;

    if (!queryText) {
      return res.status(400).json({ error: 'Query text required' });
    }

    const { data, error } = await supabase
      .from('voice_queries')
      .insert([
        {
          user_id: userId,
          query_text: queryText,
          response_text: responseText || null,
          language: language || 'English'
        }
      ])
      .select()
      .single();

    if (error) {
      console.error('Save voice query error:', error);
      return res.status(400).json({ error: error.message });
    }

    res.status(201).json({
      success: true,
      message: 'Voice query saved successfully',
      query: data
    });
  } catch (error) {
    console.error('Save voice query error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

const getUserVoiceQueries = async (req, res) => {
  try {
    const userId = req.user.userId;
    const { limit = 50, offset = 0 } = req.query;

    const { data, error, count } = await supabase
      .from('voice_queries')
      .select('*', { count: 'exact' })
      .eq('user_id', userId)
      .order('created_at', { ascending: false })
      .range(offset, offset + limit - 1);

    if (error) {
      return res.status(400).json({ error: error.message });
    }

    res.json({
      success: true,
      queries: data,
      total: count,
      limit: parseInt(limit),
      offset: parseInt(offset)
    });
  } catch (error) {
    console.error('Get voice queries error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

const toggleVoiceQueryBookmark = async (req, res) => {
  try {
    const { id } = req.params;
    const userId = req.user.userId;

    const { data: existing } = await supabase
      .from('voice_queries')
      .select('is_bookmarked')
      .eq('id', id)
      .eq('user_id', userId)
      .single();

    if (!existing) {
      return res.status(404).json({ error: 'Voice query not found' });
    }

    const { data, error } = await supabase
      .from('voice_queries')
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
      query: data
    });
  } catch (error) {
    console.error('Toggle bookmark error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

const getBookmarkedVoiceQueries = async (req, res) => {
  try {
    const userId = req.user.userId;

    const { data, error } = await supabase
      .from('voice_queries')
      .select('*')
      .eq('user_id', userId)
      .eq('is_bookmarked', true)
      .order('created_at', { ascending: false });

    if (error) {
      return res.status(400).json({ error: error.message });
    }

    res.json({
      success: true,
      queries: data
    });
  } catch (error) {
    console.error('Get bookmarked queries error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

const saveChatMessage = async (req, res) => {
  try {
    const userId = req.user.userId;
    const { message, response, messageType } = req.body;

    if (!message) {
      return res.status(400).json({ error: 'Message required' });
    }

    const { data, error } = await supabase
      .from('chat_history')
      .insert([
        {
          user_id: userId,
          message: message,
          response: response || null,
          message_type: messageType || 'text'
        }
      ])
      .select()
      .single();

    if (error) {
      console.error('Save chat message error:', error);
      return res.status(400).json({ error: error.message });
    }

    res.status(201).json({
      success: true,
      message: 'Chat message saved successfully',
      chat: data
    });
  } catch (error) {
    console.error('Save chat message error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

const getChatHistory = async (req, res) => {
  try {
    const userId = req.user.userId;
    const { limit = 100, offset = 0 } = req.query;

    const { data, error, count } = await supabase
      .from('chat_history')
      .select('*', { count: 'exact' })
      .eq('user_id', userId)
      .order('created_at', { ascending: false })
      .range(offset, offset + limit - 1);

    if (error) {
      return res.status(400).json({ error: error.message });
    }

    res.json({
      success: true,
      chats: data,
      total: count,
      limit: parseInt(limit),
      offset: parseInt(offset)
    });
  } catch (error) {
    console.error('Get chat history error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

const deleteVoiceQuery = async (req, res) => {
  try {
    const { id } = req.params;
    const userId = req.user.userId;

    const { error } = await supabase
      .from('voice_queries')
      .delete()
      .eq('id', id)
      .eq('user_id', userId);

    if (error) {
      return res.status(400).json({ error: error.message });
    }

    res.json({
      success: true,
      message: 'Voice query deleted successfully'
    });
  } catch (error) {
    console.error('Delete voice query error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

module.exports = {
  saveVoiceQuery,
  getUserVoiceQueries,
  toggleVoiceQueryBookmark,
  getBookmarkedVoiceQueries,
  saveChatMessage,
  getChatHistory,
  deleteVoiceQuery
};