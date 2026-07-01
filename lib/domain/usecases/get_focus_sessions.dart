import '../entities/focus_session_entity.dart';
import '../repositories/focus_repository.dart';

class GetFocusSessions {
  final FocusRepository repository;

  GetFocusSessions(this.repository);

  Future<List<FocusSessionEntity>> call() async {
    return await repository.getFocusSessions();
  }
}
