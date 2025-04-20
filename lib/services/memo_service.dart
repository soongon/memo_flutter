import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/memo.dart';

class MemoService {
  final CollectionReference memos =
      FirebaseFirestore.instance.collection('memos');

  Future<void> addMemo(Memo memo) async {
    await memos.doc(memo.id).set(memo.toMap());
  }

  Future<void> deleteMemo(String id) async {
    await memos.doc(id).delete();
  }

  Stream<List<Memo>> getMemoStream() {
    return memos.orderBy('createdAt', descending: true).snapshots().map(
          (snapshot) {
        return snapshot.docs.map((doc) {
          return Memo.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      },
    );
  }
}