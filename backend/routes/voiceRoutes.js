const express = require('express');
const router = express.Router();
const authenticateToken = require('../middleware/auth');
const {
  saveVoiceQuery,
  getUserVoiceQueries,
  toggleVoiceQueryBookmark,
  getBookmarkedVoiceQueries,
  saveChatMessage,
  getChatHistory,
  deleteVoiceQuery
} = require('../controllers/voiceController');

router.post('/query', authenticateToken, saveVoiceQuery);
router.get('/query', authenticateToken, getUserVoiceQueries);
router.get('/query/bookmarked', authenticateToken, getBookmarkedVoiceQueries);
router.patch('/query/:id/bookmark', authenticateToken, toggleVoiceQueryBookmark);
router.delete('/query/:id', authenticateToken, deleteVoiceQuery);

router.post('/chat', authenticateToken, saveChatMessage);
router.get('/chat', authenticateToken, getChatHistory);

module.exports = router;