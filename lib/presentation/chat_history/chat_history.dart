import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/chat_item_widget.dart';
import './widgets/empty_state_widget.dart';
import './widgets/filter_chips_widget.dart';
import './widgets/search_bar_widget.dart';

class ChatHistory extends StatefulWidget {
  const ChatHistory({super.key});

  @override
  State<ChatHistory> createState() => _ChatHistoryState();
}

class _ChatHistoryState extends State<ChatHistory> {
  String _searchQuery = '';
  String _selectedFilter = 'All';
  bool _isLoading = false;

  final List<String> _filters = [
    'All',
    'Bookmarked',
    'Disease',
    'Fertilizer',
    'Weather',
    'Schemes',
    'General',
  ];

  final List<Map<String, dynamic>> _mockChatHistory = [
    {
      "id": 1,
      "title": "Wheat Leaf Rust Treatment",
      "preview":
          "AI: Based on the image you shared, your wheat crop shows signs of leaf rust. I recommend applying a fungicide containing...",
      "timestamp": "2 hours ago",
      "type": "Disease",
      "isBookmarked": true,
      "hasVoice": true,
      "hasImage": true,
      "fullConversation": [
        {
          "sender": "user",
          "message":
              "My wheat leaves are showing orange spots. What should I do?",
          "timestamp": "2025-10-22 07:26:33",
          "hasImage": true,
          "imageUrl":
              "https://images.unsplash.com/photo-1562089405-e796b64eb497",
          "semanticLabel":
              "Close-up of wheat leaves showing orange rust spots and disease symptoms"
        },
        {
          "sender": "ai",
          "message":
              "Based on the image you shared, your wheat crop shows signs of leaf rust. I recommend applying a fungicide containing propiconazole or tebuconazole. Spray during early morning or evening hours.",
          "timestamp": "2025-10-22 07:27:15",
          "hasVoice": true
        }
      ]
    },
    {
      "id": 2,
      "title": "NPK Fertilizer for Rice",
      "preview":
          "AI: For your rice crop in the vegetative stage, I recommend using NPK 20-10-10 at a rate of 100kg per hectare...",
      "timestamp": "1 day ago",
      "type": "Fertilizer",
      "isBookmarked": false,
      "hasVoice": false,
      "hasImage": false,
      "fullConversation": [
        {
          "sender": "user",
          "message":
              "What fertilizer should I use for rice in vegetative stage?",
          "timestamp": "2025-10-21 14:30:00",
          "hasImage": false
        },
        {
          "sender": "ai",
          "message":
              "For your rice crop in the vegetative stage, I recommend using NPK 20-10-10 at a rate of 100kg per hectare. Apply it 3 weeks after transplanting for optimal growth.",
          "timestamp": "2025-10-21 14:30:45",
          "hasVoice": false
        }
      ]
    },
    {
      "id": 3,
      "title": "Weather Alert - Heavy Rain",
      "preview":
          "AI: Weather forecast shows heavy rainfall expected in your area for the next 3 days. I recommend covering your crops...",
      "timestamp": "2 days ago",
      "type": "Weather",
      "isBookmarked": true,
      "hasVoice": true,
      "hasImage": false,
      "fullConversation": [
        {
          "sender": "user",
          "message": "Will it rain this week? Should I harvest my tomatoes?",
          "timestamp": "2025-10-20 09:15:00",
          "hasImage": false
        },
        {
          "sender": "ai",
          "message":
              "Weather forecast shows heavy rainfall expected in your area for the next 3 days. I recommend covering your crops and harvesting ripe tomatoes immediately to prevent damage.",
          "timestamp": "2025-10-20 09:15:30",
          "hasVoice": true
        }
      ]
    },
    {
      "id": 4,
      "title": "PM-KISAN Scheme Benefits",
      "preview":
          "AI: The PM-KISAN scheme provides ₹6,000 per year to eligible farmers. You can apply online through the official portal...",
      "timestamp": "3 days ago",
      "type": "Schemes",
      "isBookmarked": false,
      "hasVoice": false,
      "hasImage": false,
      "fullConversation": [
        {
          "sender": "user",
          "message": "Tell me about PM-KISAN scheme eligibility and benefits",
          "timestamp": "2025-10-19 16:45:00",
          "hasImage": false
        },
        {
          "sender": "ai",
          "message":
              "The PM-KISAN scheme provides ₹6,000 per year to eligible farmers. You can apply online through the official portal. Small and marginal farmers with up to 2 hectares of land are eligible.",
          "timestamp": "2025-10-19 16:45:45",
          "hasVoice": false
        }
      ]
    },
    {
      "id": 5,
      "title": "Organic Pest Control Methods",
      "preview":
          "AI: For organic pest control, you can use neem oil spray, companion planting with marigolds, and beneficial insects...",
      "timestamp": "1 week ago",
      "type": "General",
      "isBookmarked": true,
      "hasVoice": false,
      "hasImage": false,
      "fullConversation": [
        {
          "sender": "user",
          "message":
              "What are some organic methods to control pests in vegetables?",
          "timestamp": "2025-10-15 11:20:00",
          "hasImage": false
        },
        {
          "sender": "ai",
          "message":
              "For organic pest control, you can use neem oil spray, companion planting with marigolds, and beneficial insects like ladybugs. These methods are safe and effective for vegetable crops.",
          "timestamp": "2025-10-15 11:20:30",
          "hasVoice": false
        }
      ]
    },
    {
      "id": 6,
      "title": "Tomato Blight Disease",
      "preview":
          "AI: The symptoms you described indicate late blight in tomatoes. Remove affected leaves immediately and apply copper-based fungicide...",
      "timestamp": "1 week ago",
      "type": "Disease",
      "isBookmarked": false,
      "hasVoice": true,
      "hasImage": true,
      "fullConversation": [
        {
          "sender": "user",
          "message":
              "My tomato plants have dark spots on leaves and fruits are rotting",
          "timestamp": "2025-10-15 08:30:00",
          "hasImage": true,
          "imageUrl":
              "https://images.unsplash.com/photo-1675406265301-35ca608ad2be",
          "semanticLabel":
              "Tomato plant with dark brown spots on leaves showing signs of blight disease"
        },
        {
          "sender": "ai",
          "message":
              "The symptoms you described indicate late blight in tomatoes. Remove affected leaves immediately and apply copper-based fungicide. Ensure good air circulation and avoid overhead watering.",
          "timestamp": "2025-10-15 08:31:00",
          "hasVoice": true
        }
      ]
    }
  ];

  List<Map<String, dynamic>> get _filteredChats {
    List<Map<String, dynamic>> filtered = _mockChatHistory;

    // Apply filter
    if (_selectedFilter != 'All') {
      if (_selectedFilter == 'Bookmarked') {
        filtered =
            filtered.where((chat) => chat['isBookmarked'] == true).toList();
      } else {
        filtered = filtered
            .where((chat) =>
                chat['type'].toString().toLowerCase() ==
                _selectedFilter.toLowerCase())
            .toList();
      }
    }

    // Apply search
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((chat) {
        final title = chat['title'].toString().toLowerCase();
        final preview = chat['preview'].toString().toLowerCase();
        final type = chat['type'].toString().toLowerCase();
        final query = _searchQuery.toLowerCase();

        return title.contains(query) ||
            preview.contains(query) ||
            type.contains(query);
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          SearchBarWidget(
            onSearchChanged: (query) {
              setState(() {
                _searchQuery = query;
              });
            },
            onVoiceSearch: _handleVoiceSearch,
            hintText: 'Search conversations in Hindi, English...',
          ),
          FilterChipsWidget(
            filters: _filters,
            selectedFilter: _selectedFilter,
            onFilterSelected: (filter) {
              setState(() {
                _selectedFilter = filter;
              });
            },
          ),
          Expanded(
            child: _buildChatList(),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: CustomIconWidget(
          iconName: 'arrow_back',
          color: AppTheme.textPrimaryLight,
          size: 6.w,
        ),
      ),
      title: Text(
        'Chat History',
        style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
          color: AppTheme.textPrimaryLight,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          onPressed: _showSortOptions,
          icon: CustomIconWidget(
            iconName: 'sort',
            color: AppTheme.textPrimaryLight,
            size: 6.w,
          ),
        ),
        IconButton(
          onPressed: _showMoreOptions,
          icon: CustomIconWidget(
            iconName: 'more_vert',
            color: AppTheme.textPrimaryLight,
            size: 6.w,
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: AppTheme.lightTheme.dividerColor.withValues(alpha: 0.2),
          height: 1.0,
        ),
      ),
    );
  }

  Widget _buildChatList() {
    final filteredChats = _filteredChats;

    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: AppTheme.lightTheme.colorScheme.primary,
        ),
      );
    }

    if (filteredChats.isEmpty) {
      if (_searchQuery.isNotEmpty) {
        return EmptyStateWidget(
          title: 'No conversations found',
          subtitle:
              'Try adjusting your search terms or filters to find what you\'re looking for.',
          buttonText: 'Clear Search',
          onButtonPressed: () {
            setState(() {
              _searchQuery = '';
              _selectedFilter = 'All';
            });
          },
        );
      } else if (_selectedFilter == 'Bookmarked') {
        return EmptyStateWidget(
          title: 'No bookmarked conversations',
          subtitle:
              'Bookmark important conversations by swiping right or using the context menu.',
          buttonText: 'Start New Consultation',
          onButtonPressed: () => Navigator.pushNamed(context, '/voice-query'),
        );
      } else {
        return EmptyStateWidget(
          title: 'Start Your First Consultation',
          subtitle:
              'Ask our AI assistant about crop diseases, fertilizers, weather updates, and farming best practices in your regional language.',
          buttonText: 'Ask AI Assistant',
          onButtonPressed: () => Navigator.pushNamed(context, '/voice-query'),
        );
      }
    }

    return RefreshIndicator(
      onRefresh: _refreshChatHistory,
      color: AppTheme.lightTheme.colorScheme.primary,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: filteredChats.length,
        itemBuilder: (context, index) {
          final chat = filteredChats[index];
          return ChatItemWidget(
            chatData: chat,
            onTap: () => _openChatDetail(chat),
            onBookmark: () => _toggleBookmark(chat['id']),
            onShare: () => _shareConversation(chat),
            onDelete: () => _deleteConversation(chat['id']),
            onContinue: () => _continueConversation(chat),
          );
        },
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () => Navigator.pushNamed(context, '/voice-query'),
      backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      foregroundColor: AppTheme.lightTheme.colorScheme.onPrimary,
      icon: CustomIconWidget(
        iconName: 'mic',
        color: AppTheme.lightTheme.colorScheme.onPrimary,
        size: 6.w,
      ),
      label: Text(
        'Ask AI',
        style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
          color: AppTheme.lightTheme.colorScheme.onPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _handleVoiceSearch() {
    // Voice search functionality would integrate with speech recognition
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Voice search activated. Speak your query...',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onInverseSurface,
          ),
        ),
        backgroundColor: AppTheme.lightTheme.colorScheme.inverseSurface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _openChatDetail(Map<String, dynamic> chat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _ChatDetailScreen(chatData: chat),
      ),
    );
  }

  void _toggleBookmark(int chatId) {
    setState(() {
      final chatIndex =
          _mockChatHistory.indexWhere((chat) => chat['id'] == chatId);
      if (chatIndex != -1) {
        _mockChatHistory[chatIndex]['isBookmarked'] =
            !(_mockChatHistory[chatIndex]['isBookmarked'] ?? false);
      }
    });

    final isBookmarked = _mockChatHistory
        .firstWhere((chat) => chat['id'] == chatId)['isBookmarked'];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isBookmarked ? 'Conversation bookmarked' : 'Bookmark removed',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onInverseSurface,
          ),
        ),
        backgroundColor: AppTheme.lightTheme.colorScheme.inverseSurface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _shareConversation(Map<String, dynamic> chat) {
    // Share functionality would integrate with platform sharing
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Sharing: ${chat['title']}',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onInverseSurface,
          ),
        ),
        backgroundColor: AppTheme.lightTheme.colorScheme.inverseSurface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _deleteConversation(int chatId) {
    setState(() {
      _mockChatHistory.removeWhere((chat) => chat['id'] == chatId);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Conversation deleted',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onInverseSurface,
          ),
        ),
        backgroundColor: AppTheme.lightTheme.colorScheme.inverseSurface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        action: SnackBarAction(
          label: 'Undo',
          textColor: AppTheme.lightTheme.colorScheme.primary,
          onPressed: () {
            // Undo functionality would restore the deleted conversation
          },
        ),
      ),
    );
  }

  void _continueConversation(Map<String, dynamic> chat) {
    Navigator.pushNamed(context, '/voice-query');
  }

  Future<void> _refreshChatHistory() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12.w,
                height: 0.5.h,
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Sort Conversations',
                style: AppTheme.lightTheme.textTheme.titleMedium,
              ),
              SizedBox(height: 2.h),
              _buildSortOption('Most Recent', 'access_time'),
              _buildSortOption('Oldest First', 'history'),
              _buildSortOption('Most Relevant', 'star'),
              _buildSortOption('By Type', 'category'),
              SizedBox(height: 2.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSortOption(String title, String iconName) {
    return ListTile(
      leading: CustomIconWidget(
        iconName: iconName,
        color: AppTheme.textPrimaryLight,
        size: 6.w,
      ),
      title: Text(
        title,
        style: AppTheme.lightTheme.textTheme.bodyMedium,
      ),
      onTap: () {
        Navigator.pop(context);
        // Sort functionality would be implemented here
      },
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12.w,
                height: 0.5.h,
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 2.h),
              _buildMoreOption('Export All Conversations', 'file_download'),
              _buildMoreOption('Clear Search History', 'clear_all'),
              _buildMoreOption('Backup to Cloud', 'cloud_upload'),
              _buildMoreOption('Settings', 'settings'),
              SizedBox(height: 2.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMoreOption(String title, String iconName) {
    return ListTile(
      leading: CustomIconWidget(
        iconName: iconName,
        color: AppTheme.textPrimaryLight,
        size: 6.w,
      ),
      title: Text(
        title,
        style: AppTheme.lightTheme.textTheme.bodyMedium,
      ),
      onTap: () {
        Navigator.pop(context);
        // Option functionality would be implemented here
      },
    );
  }
}

// Chat Detail Screen for viewing full conversations
class _ChatDetailScreen extends StatelessWidget {
  final Map<String, dynamic> chatData;

  const _ChatDetailScreen({required this.chatData});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> conversation = chatData['fullConversation'] ?? [];

    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.lightTheme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.textPrimaryLight,
            size: 6.w,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chatData['title'] ?? '',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.textPrimaryLight,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              chatData['timestamp'] ?? '',
              style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                color: AppTheme.textSecondaryLight,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Share conversation
            },
            icon: CustomIconWidget(
              iconName: 'share',
              color: AppTheme.textPrimaryLight,
              size: 6.w,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(4.w),
        itemCount: conversation.length,
        itemBuilder: (context, index) {
          final message = conversation[index];
          final isUser = message['sender'] == 'user';

          return Container(
            margin: EdgeInsets.symmetric(vertical: 1.h),
            child: Row(
              mainAxisAlignment:
                  isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isUser) ...[
                  Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CustomIconWidget(
                      iconName: 'smart_toy',
                      color: AppTheme.lightTheme.colorScheme.onPrimary,
                      size: 6.w,
                    ),
                  ),
                  SizedBox(width: 2.w),
                ],
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: isUser
                          ? AppTheme.lightTheme.colorScheme.primary
                          : AppTheme.lightTheme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: !isUser
                          ? Border.all(
                              color: AppTheme.lightTheme.dividerColor
                                  .withValues(alpha: 0.3),
                            )
                          : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (message['hasImage'] == true &&
                            message['imageUrl'] != null)
                          Container(
                            margin: EdgeInsets.only(bottom: 2.h),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CustomImageWidget(
                                imageUrl: message['imageUrl'],
                                width: 60.w,
                                height: 20.h,
                                fit: BoxFit.cover,
                                semanticLabel: message['semanticLabel'] ??
                                    'Uploaded image',
                              ),
                            ),
                          ),
                        Text(
                          message['message'] ?? '',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: isUser
                                ? AppTheme.lightTheme.colorScheme.onPrimary
                                : AppTheme.textPrimaryLight,
                          ),
                        ),
                        if (message['hasVoice'] == true)
                          Padding(
                            padding: EdgeInsets.only(top: 1.h),
                            child: Row(
                              children: [
                                CustomIconWidget(
                                  iconName: 'play_arrow',
                                  color: isUser
                                      ? AppTheme
                                          .lightTheme.colorScheme.onPrimary
                                          .withValues(alpha: 0.7)
                                      : AppTheme.textSecondaryLight,
                                  size: 4.w,
                                ),
                                SizedBox(width: 1.w),
                                Text(
                                  'Audio message',
                                  style: AppTheme
                                      .lightTheme.textTheme.labelSmall
                                      ?.copyWith(
                                    color: isUser
                                        ? AppTheme
                                            .lightTheme.colorScheme.onPrimary
                                            .withValues(alpha: 0.7)
                                        : AppTheme.textSecondaryLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (isUser) ...[
                  SizedBox(width: 2.w),
                  Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.secondary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CustomIconWidget(
                      iconName: 'person',
                      color: AppTheme.lightTheme.colorScheme.onSecondary,
                      size: 6.w,
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: AppTheme.lightTheme.dividerColor.withValues(alpha: 0.3),
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/voice-query');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.lightTheme.colorScheme.primary,
                  foregroundColor: AppTheme.lightTheme.colorScheme.onPrimary,
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconWidget(
                      iconName: 'chat',
                      color: AppTheme.lightTheme.colorScheme.onPrimary,
                      size: 5.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Continue Discussion',
                      style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
