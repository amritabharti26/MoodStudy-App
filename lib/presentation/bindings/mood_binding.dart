import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../core/database_helper.dart';
import '../../data/database/focus_local_data_source.dart';
import '../../data/database/mood_local_datasource.dart';
import '../../data/repositories/focus_repository_impl.dart';
import '../../data/repositories/mood_repository_impl.dart';
import '../../domain/usecases/add_focus_session.dart';
import '../../domain/usecases/add_mood.dart';
import '../../domain/usecases/delete_focus_session.dart';
import '../../domain/usecases/delete_mood.dart';
import '../../domain/usecases/get_focus_sessions.dart';
import '../../domain/usecases/get_mood.dart';
import '../../domain/usecases/update_focus_session.dart';
import '../controllers/focus_controller.dart';
import '../controllers/mood_controller.dart';

class MoodBinding extends Bindings {
  @override
  void dependencies() {
    final moodLocalDataSource = MoodLocalDataSourceImpl();
    final moodRepository = MoodRepositoryImpl(moodLocalDataSource);

    final focusLocalDataSource = FocusLocalDataSourceImpl(
      DatabaseHelper.instance,
    );

    final focusRepository = FocusRepositoryImpl(focusLocalDataSource);

    Get.lazyPut<FocusController>(
      () => FocusController(
        addFocusSession: AddFocusSession(focusRepository),
        getFocusSessions: GetFocusSessions(focusRepository),
        updateFocusSession: UpdateFocusSession(focusRepository),
        deleteFocusSession: DeleteFocusSession(focusRepository),
      ),
    );

    Get.lazyPut<MoodController>(
      () => MoodController(
        addMoodUseCase: AddMood(moodRepository),
        getMoodUseCase: GetMood(moodRepository),
        deleteMoodUseCase: DeleteMood(moodRepository),
      ),
    );
  }
}
