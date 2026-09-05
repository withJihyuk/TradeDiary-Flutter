import 'package:flutter_riverpod/legacy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sessionUserProvider = StateProvider<String?>(
  (ref) => Supabase.instance.client.auth.currentUser?.id,
);
