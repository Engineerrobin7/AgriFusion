import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/analysis_progress_widget.dart';
import './widgets/bottom_navigation_widget.dart';
import './widgets/camera_overlay_widget.dart';
import './widgets/diagnosis_results_widget.dart';
import './widgets/image_preview_widget.dart';

class CameraDiagnosis extends StatefulWidget {
  const CameraDiagnosis({super.key});

  @override
  State<CameraDiagnosis> createState() => _CameraDiagnosisState();
}

class _CameraDiagnosisState extends State<CameraDiagnosis> {
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  bool _isCameraInitialized = false;
  bool _isFlashOn = false;
  bool _isFrontCamera = false;
  String? _capturedImagePath;
  bool _isAnalyzing = false;
  Map<String, dynamic>? _diagnosisResults;
  int _currentNavIndex = 2; // Camera tab is active

  // Mock diagnosis data
  final List<Map<String, dynamic>> _mockDiagnosisData = [
    {
      "disease": {
        "name": "Tomato Late Blight",
        "severity": "Moderate",
        "description":
            "Late blight is a destructive disease caused by the fungus Phytophthora infestans. It affects leaves, stems, and fruits, causing dark, water-soaked lesions that rapidly expand. The disease thrives in cool, humid conditions and can spread quickly through wind and rain.",
        "healthyImage":
            "https://images.unsplash.com/photo-1481724247231-768cc9267abf",
        "diseasedImage":
            "https://images.unsplash.com/photo-1481724247231-768cc9267abf"
      },
      "confidence": 0.87,
      "analyzedImage":
          "https://images.pexels.com/photos/4750270/pexels-photo-4750270.jpeg?auto=compress&cs=tinysrgb&w=800",
      "treatments": [
        {
          "type": "Organic",
          "name": "Copper-based Fungicide",
          "description":
              "Apply copper sulfate or copper hydroxide spray to affected areas. This organic treatment helps prevent spore germination and reduces disease spread.",
          "application": "Spray every 7-10 days",
          "timing": "Early morning or evening"
        },
        {
          "type": "Chemical",
          "name": "Mancozeb Fungicide",
          "description":
              "A broad-spectrum fungicide effective against late blight. Provides protective action against fungal infections.",
          "application": "2-3 grams per liter",
          "timing": "Before rain or irrigation"
        }
      ]
    },
    {
      "disease": {
        "name": "Wheat Rust Disease",
        "severity": "Severe",
        "description":
            "Wheat rust is caused by fungal pathogens that create orange-red pustules on leaves and stems. It can significantly reduce grain yield and quality if left untreated.",
        "healthyImage":
            "https://images.unsplash.com/photo-1481724247231-768cc9267abf",
        "diseasedImage":
            "https://images.unsplash.com/photo-1481724247231-768cc9267abf"
      },
      "confidence": 0.92,
      "analyzedImage":
          "https://images.pexels.com/photos/4750271/pexels-photo-4750271.jpeg?auto=compress&cs=tinysrgb&w=800",
      "treatments": [
        {
          "type": "Chemical",
          "name": "Propiconazole",
          "description":
              "Systemic fungicide that provides excellent control of rust diseases. Penetrates plant tissue for long-lasting protection.",
          "application": "1ml per liter of water",
          "timing": "At first sign of infection"
        },
        {
          "type": "Organic",
          "name": "Neem Oil Treatment",
          "description":
              "Natural fungicide with systemic properties. Helps boost plant immunity and reduces fungal growth.",
          "application": "5ml per liter, weekly",
          "timing": "Evening application preferred"
        }
      ]
    }
  ];

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      // Request camera permission
      if (!kIsWeb) {
        final status = await Permission.camera.request();
        if (!status.isGranted) {
          _showErrorMessage('Camera permission is required');
          return;
        }
      }

      // Get available cameras
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        _showErrorMessage('No cameras available');
        return;
      }

      // Select appropriate camera
      final camera = kIsWeb
          ? _cameras.firstWhere(
              (c) => c.lensDirection == CameraLensDirection.front,
              orElse: () => _cameras.first,
            )
          : _cameras.firstWhere(
              (c) => c.lensDirection == CameraLensDirection.back,
              orElse: () => _cameras.first,
            );

      // Initialize camera controller
      _cameraController = CameraController(
        camera,
        kIsWeb ? ResolutionPreset.medium : ResolutionPreset.high,
        enableAudio: false,
      );

      await _cameraController!.initialize();

      // Apply camera settings (skip unsupported features on web)
      if (!kIsWeb) {
        try {
          await _cameraController!.setFocusMode(FocusMode.auto);
          await _cameraController!.setFlashMode(FlashMode.auto);
        } catch (e) {
          // Ignore unsupported features
        }
      }

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      _showErrorMessage('Failed to initialize camera');
    }
  }

  Future<void> _capturePhoto() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    try {
      final XFile photo = await _cameraController!.takePicture();
      setState(() {
        _capturedImagePath = photo.path;
      });
    } catch (e) {
      _showErrorMessage('Failed to capture photo');
    }
  }

  Future<void> _selectFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        // Crop image if not on web
        if (!kIsWeb) {
          final croppedFile = await ImageCropper().cropImage(
            sourcePath: image.path,
            aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
            uiSettings: [
              AndroidUiSettings(
                toolbarTitle: 'Crop Plant Image',
                toolbarColor: AppTheme.lightTheme.primaryColor,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.square,
                lockAspectRatio: false,
              ),
              IOSUiSettings(
                title: 'Crop Plant Image',
                aspectRatioLockEnabled: false,
              ),
            ],
          );

          if (croppedFile != null) {
            setState(() {
              _capturedImagePath = croppedFile.path;
            });
          }
        } else {
          setState(() {
            _capturedImagePath = image.path;
          });
        }
      }
    } catch (e) {
      _showErrorMessage('Failed to select image');
    }
  }

  void _toggleFlash() {
    if (kIsWeb || _cameraController == null) return;

    try {
      setState(() {
        _isFlashOn = !_isFlashOn;
      });
      _cameraController!
          .setFlashMode(_isFlashOn ? FlashMode.torch : FlashMode.off);
    } catch (e) {
      // Flash not supported
    }
  }

  Future<void> _flipCamera() async {
    if (_cameras.length < 2 || _cameraController == null) return;

    try {
      setState(() {
        _isFrontCamera = !_isFrontCamera;
        _isCameraInitialized = false;
      });

      await _cameraController!.dispose();

      final camera = _cameras.firstWhere(
        (c) =>
            c.lensDirection ==
            (_isFrontCamera
                ? CameraLensDirection.front
                : CameraLensDirection.back),
        orElse: () => _cameras.first,
      );

      _cameraController = CameraController(
        camera,
        kIsWeb ? ResolutionPreset.medium : ResolutionPreset.high,
        enableAudio: false,
      );

      await _cameraController!.initialize();

      if (!kIsWeb) {
        try {
          await _cameraController!.setFocusMode(FocusMode.auto);
          await _cameraController!.setFlashMode(FlashMode.auto);
        } catch (e) {
          // Ignore unsupported features
        }
      }

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      _showErrorMessage('Failed to flip camera');
    }
  }

  void _retakePhoto() {
    setState(() {
      _capturedImagePath = null;
      _isAnalyzing = false;
      _diagnosisResults = null;
    });
  }

  void _confirmAndAnalyze() {
    setState(() {
      _isAnalyzing = true;
    });
  }

  void _onAnalysisComplete() {
    // Simulate AI analysis with mock data
    final randomIndex = DateTime.now().millisecond % _mockDiagnosisData.length;
    final mockResult =
        Map<String, dynamic>.from(_mockDiagnosisData[randomIndex]);
    mockResult['analyzedImage'] = _capturedImagePath!;

    setState(() {
      _isAnalyzing = false;
      _diagnosisResults = mockResult;
    });
  }

  void _bookmarkDiagnosis() {
    // Implement bookmark functionality
    _showSuccessMessage('Diagnosis bookmarked successfully');
  }

  void _shareDiagnosis() {
    // Implement share functionality
    _showSuccessMessage('Diagnosis shared successfully');
  }

  void _startNewDiagnosis() {
    setState(() {
      _capturedImagePath = null;
      _isAnalyzing = false;
      _diagnosisResults = null;
    });
  }

  void _showErrorMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppTheme.cropDiseased,
        ),
      );
    }
  }

  void _showSuccessMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppTheme.cropHealthy,
        ),
      );
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: _buildBody(),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildBody() {
    // Show diagnosis results
    if (_diagnosisResults != null) {
      return DiagnosisResultsWidget(
        diagnosisData: _diagnosisResults!,
        onBookmark: _bookmarkDiagnosis,
        onShare: _shareDiagnosis,
        onNewDiagnosis: _startNewDiagnosis,
      );
    }

    // Show analysis progress
    if (_isAnalyzing && _capturedImagePath != null) {
      return AnalysisProgressWidget(
        imagePath: _capturedImagePath!,
        onAnalysisComplete: _onAnalysisComplete,
      );
    }

    // Show image preview
    if (_capturedImagePath != null) {
      return ImagePreviewWidget(
        imagePath: _capturedImagePath!,
        onRetake: _retakePhoto,
        onConfirm: _confirmAndAnalyze,
      );
    }

    // Show camera view
    if (!_isCameraInitialized) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: AppTheme.lightTheme.primaryColor,
            ),
            SizedBox(height: 3.h),
            Text(
              'Initializing Camera...',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        // Camera preview
        Positioned.fill(
          child: _cameraController != null &&
                  _cameraController!.value.isInitialized
              ? CameraPreview(_cameraController!)
              : Container(
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      'Camera not available',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
        ),

        // Camera overlay with controls
        CameraOverlayWidget(
          isFlashOn: _isFlashOn,
          isFrontCamera: _isFrontCamera,
          onFlashToggle: _toggleFlash,
          onCameraFlip: _flipCamera,
          onGalleryTap: _selectFromGallery,
          onCapture: _capturePhoto,
        ),
      ],
    );
  }
}
