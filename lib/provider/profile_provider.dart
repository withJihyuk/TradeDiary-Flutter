import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_diary/model/profile.dart';
import 'package:trade_diary/viewModel/profile_model.dart';

final profileProvider =
    StateNotifierProvider<ProfileNotifier, AsyncValue<ProfileModel>>((ref) {
  return ProfileNotifier();
});

class ProfileNotifier extends StateNotifier<AsyncValue<ProfileModel>> {
  ProfileNotifier() : super(const AsyncValue.loading()) {
    loadProfile();
  }

  final ProfileViewModel _viewModel = ProfileViewModel();

  Future<void> loadProfile() async {
    try {
      state = const AsyncValue.loading();
      final profile = await _viewModel.getInfo();
      state = AsyncValue.data(profile);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadProfile();
  }
}
