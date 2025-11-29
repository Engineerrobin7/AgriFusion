const express = require('express');
const router = express.Router();
const authenticateToken = require('../middleware/auth');
const {
  saveDiagnosis,
  getUserDiagnoses,
  getDiagnosisById,
  toggleBookmark,
  getBookmarkedDiagnoses,
  deleteDiagnosis
} = require('../controllers/diagnosisController');

router.post('/', authenticateToken, saveDiagnosis);
router.get('/', authenticateToken, getUserDiagnoses);
router.get('/bookmarked', authenticateToken, getBookmarkedDiagnoses);
router.get('/:id', authenticateToken, getDiagnosisById);
router.patch('/:id/bookmark', authenticateToken, toggleBookmark);
router.delete('/:id', authenticateToken, deleteDiagnosis);

module.exports = router;
