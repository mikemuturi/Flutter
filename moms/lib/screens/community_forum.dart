import 'package:flutter/material.dart';

class ForumPost {
  final String id;
  final String title;
  final String content;
  final String author;
  final DateTime timestamp;
  final List<ForumReply> replies;

  ForumPost({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.timestamp,
    this.replies = const [],
  });
}

class ForumReply {
  final String id;
  final String content;
  final String author;
  final DateTime timestamp;

  ForumReply({
    required this.id,
    required this.content,
    required this.author,
    required this.timestamp,
  });
}

class CommunityForumScreen extends StatefulWidget {
  @override
  _CommunityForumScreenState createState() => _CommunityForumScreenState();
}

class _CommunityForumScreenState extends State<CommunityForumScreen> {
  List<ForumPost> discussions = [
    ForumPost(
      id: '1',
      title: 'Dealing with Nausea in First Trimester',
      content: 'I\'ve been experiencing severe nausea. Any tips?',
      author: 'Sarah',
      timestamp: DateTime.now().subtract(Duration(hours: 2)),
      replies: [
        ForumReply(
          id: '1',
          content: 'Try eating small, frequent meals throughout the day.',
          author: 'Emily',
          timestamp: DateTime.now().subtract(Duration(hours: 1)),
        ),
        ForumReply(
          id: '2',
          content: 'Ginger tea helped me a lot with morning sickness.',
          author: 'Jessica',
          timestamp: DateTime.now().subtract(Duration(minutes: 30)),
        ),
      ],
    ),

    ForumPost(
      id: '2',
      title: 'Best Prenatal Exercises',
      content: 'What are some safe exercises during pregnancy?',
      author: 'Lisa',
      timestamp: DateTime.now().subtract(Duration(hours: 5)),
      replies: [
        ForumReply(
          id: '3',
          content: 'Walking and swimming are great low-impact options.',
          author: 'Rachel',
          timestamp: DateTime.now().subtract(Duration(hours: 4)),
        ),
      ],
    ),
    // Add more sample posts here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.navigate_before, color: Colors.white, size: 34),
        ),
        title: Text(
          'Community Forum',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
        itemCount: discussions.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(discussions[index].title),
              subtitle: Text(
                '${discussions[index].replies.length} replies • Last active ${_getTimeAgo(discussions[index].timestamp)}',
              ),
              onTap: () => _navigateToDiscussion(context, discussions[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCreatePost(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }

  String _getTimeAgo(DateTime timestamp) {
    final difference = DateTime.now().difference(timestamp);
    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  void _navigateToDiscussion(BuildContext context, ForumPost post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiscussionScreen(post: post, onReply: _addReply),
      ),
    );
  }

  void _navigateToCreatePost(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreatePostScreen(onPost: _addPost),
      ),
    );
  }

  void _addPost(ForumPost newPost) {
    setState(() {
      discussions.insert(0, newPost);
    });
  }

  void _addReply(String postId, ForumReply newReply) {
    setState(() {
      final postIndex = discussions.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        discussions[postIndex].replies.add(newReply);
      }
    });
  }
}

class DiscussionScreen extends StatelessWidget {
  final ForumPost post;
  final Function(String, ForumReply) onReply;

  DiscussionScreen({required this.post, required this.onReply});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discussion'),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                Text(
                  post.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(post.content),
                SizedBox(height: 16),
                Text('Replies',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ...post.replies.map((reply) => _buildReplyCard(reply)).toList(),
              ],
            ),
          ),
          _ReplyInput(onSubmit: (content) => _submitReply(context, content)),
        ],
      ),
    );
  }

  Widget _buildReplyCard(ForumReply reply) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(reply.author, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(reply.content),
          ],
        ),
      ),
    );
  }

  void _submitReply(BuildContext context, String content) {
    final newReply = ForumReply(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      author: 'Current User', // Replace with actual user name
      timestamp: DateTime.now(),
    );
    onReply(post.id, newReply);
    Navigator.pop(context);
  }
}

class CreatePostScreen extends StatefulWidget {
  final Function(ForumPost) onPost;

  CreatePostScreen({required this.onPost});

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.navigate_before,
              color: Colors.white,
              size: 34,
            )),
        title: Text(
          'Create a New Post',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitPost,
              child: Text(
                'Post',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            ),
          ],
        ),
      ),
    );
  }

  void _submitPost() {
    if (_titleController.text.isNotEmpty &&
        _contentController.text.isNotEmpty) {
      final newPost = ForumPost(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        content: _contentController.text,
        author: 'Current User', // Replace with actual user name
        timestamp: DateTime.now(),
      );
      widget.onPost(newPost);
      Navigator.pop(context);
    }
  }
}

class _ReplyInput extends StatefulWidget {
  final Function(String) onSubmit;

  _ReplyInput({required this.onSubmit});

  @override
  __ReplyInputState createState() => __ReplyInputState();
}

class __ReplyInputState extends State<_ReplyInput> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: 'Write a reply...'),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                widget.onSubmit(_controller.text);
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
