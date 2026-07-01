import '../../core/database_helper.dart';
import '../models/focus_session_model.dart';

abstract class FocusLocalDataSource {
  Future<int> addFocusSession(FocusSessionModel session);

  Future<List<FocusSessionModel>> getFocusSessions();

  Future<void> updateFocusSession(FocusSessionModel session);

  Future<void> deleteFocusSession(int id);
}

class FocusLocalDataSourceImpl implements FocusLocalDataSource {
  final DatabaseHelper databaseHelper;

  FocusLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<int> addFocusSession(FocusSessionModel session) async {
    return await databaseHelper.insert("focus_table", session.toMap());
  }

  @override
  Future<List<FocusSessionModel>> getFocusSessions() async {
    final data = await databaseHelper.queryAll("focus_table");

    return data.map((e) => FocusSessionModel.fromMap(e)).toList();
  }

  @override
  Future<void> updateFocusSession(FocusSessionModel session) async {
    await databaseHelper.update("focus_table", session.toMap(), "id = ?", [
      session.id,
    ]);
  }

  @override
  Future<void> deleteFocusSession(int id) async {
    await databaseHelper.delete("focus_table", "id = ?", [id]);
  }
}
