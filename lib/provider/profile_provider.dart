import 'package:trade_diary/provider/session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:trade_diary/model/profile.dart';
import 'package:trade_diary/viewModel/profile_model.dart';

final profileProvider =
    StateNotifierProvider<ProfileNotifier, AsyncValue<ProfileModel>>((ref) {
      ref.watch(sessionUserProvider);
      return ProfileNotifier();
    });

class ProfileNotifier extends StateNotifier<AsyncValue<ProfileModel>> {
  ProfileNotifier() : super(const AsyncValue.loading()) {
    loadProfile();
  }

  final ProfileViewModel _viewModel = ProfileViewModel();

  int _generation = 0;
  Future<void> loadProfile() async {
    final generation = ++_generation;
    try {
      state = const AsyncValue.loading();
      final profile = await _viewModel.getInfo();
      if (mounted && generation == _generation) {
        state = AsyncValue.data(profile);
      }
    } catch (error, stackTrace) {
      if (mounted && generation == _generation) {
        state = AsyncValue.error(error, stackTrace);
      }
    }
  }

  Future<void> refresh() async {
    await loadProfile();
  }
}
