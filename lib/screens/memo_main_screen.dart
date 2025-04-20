import 'package:flutter/material.dart';
import '../services/memo_service.dart';
import '../models/memo.dart';

class MemoMainScreen extends StatelessWidget {
  final MemoService _memoService = MemoService();

  MemoMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('메모 앱')),
      body: Column(
        children: [
          // 입력 영역
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _MemoInputField(memoService: _memoService),
          ),
          const Divider(height: 1),
          // 실시간 목록
          Expanded(
            child: StreamBuilder<List<Memo>>(
              stream: _memoService.getMemoStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final memos = snapshot.data ?? [];
                if (memos.isEmpty) {
                  return const Center(child: Text('메모가 없습니다.'));
                }
                return ListView.builder(
                  itemCount: memos.length,
                  itemBuilder: (context, index) {
                    final memo = memos[index];
                    return ListTile(
                      title: Text(memo.text),
                      subtitle: Text(memo.createdAt.toString()),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _memoService.deleteMemo(memo.id);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MemoInputField extends StatefulWidget {
  final MemoService memoService;

  const _MemoInputField({required this.memoService});

  @override
  State<_MemoInputField> createState() => _MemoInputFieldState();
}

class _MemoInputFieldState extends State<_MemoInputField> {
  final TextEditingController _controller = TextEditingController();

  void _submit() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      final memo = Memo(text: text);
      widget.memoService.addMemo(memo);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: '메모를 입력하세요',
            ),
            onSubmitted: (_) => _submit(),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: _submit,
        )
      ],
    );
  }
}