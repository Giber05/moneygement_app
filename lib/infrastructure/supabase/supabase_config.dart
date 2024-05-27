import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SupabaseConfig {
  Future<void> setup();
}

@Injectable(as: SupabaseConfig)
class SupabaseConfigImpl implements SupabaseConfig {
  @override
  Future<void> setup() async {
    await Supabase.initialize(
        url: 'https://uijinkkuzyutxjrctbxn.supabase.co',
        anonKey:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpamlua2t1enl1dHhqcmN0YnhuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA5MDk5MTYsImV4cCI6MjAyNjQ4NTkxNn0.P7nWdelVB3acsmItP0ocEMJy9AAzIe2Zra2ZQZcrGf4');
  }
}
