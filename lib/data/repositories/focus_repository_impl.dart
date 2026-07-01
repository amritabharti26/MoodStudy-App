import '../../domain/entities/focus_session_entity.dart';
import '../../domain/repositories/focus_repository.dart';
import '../database/focus_local_data_source.dart';
import '../models/focus_session_model.dart';

class FocusRepositoryImpl implements FocusRepository {
  final FocusLocalDataSource localDataSource;

  FocusRepositoryImpl(this.localDataSource);

  @override
  Future<int> addFocusSession(FocusSessionEntity session) async {
    return await localDataSource.addFocusSession(
      FocusSessionModel(
        id: session.id,
        mood: session.mood,
        allocatedSeconds: session.allocatedSeconds,
        studiedSeconds: session.studiedSeconds,
        status: session.status,
        date: session.date,
      ),
    );
  }

  @override
  Future<List<FocusSessionEntity>> getFocusSessions() async {
    return await localDataSource.getFocusSessions();
  }

  @override
  Future<void> updateFocusSession(FocusSessionEntity session) async {
    await localDataSource.updateFocusSession(
      FocusSessionModel(
        id: session.id,
        mood: session.mood,
        allocatedSeconds: session.allocatedSeconds,
        studiedSeconds: session.studiedSeconds,
        status: session.status,
        date: session.date,
      ),
    );
  }

  @override
  Future<void> deleteFocusSession(int id) async {
    await localDataSource.deleteFocusSession(id);
  }
}
