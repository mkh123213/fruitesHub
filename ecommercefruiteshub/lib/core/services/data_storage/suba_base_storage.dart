import 'dart:io';

import 'package:ecommercefruiteshub/core/secure/constants/constants.dart';

import 'package:ecommercefruiteshub/core/services/data_storage/data_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class SubaBaseStorage implements DataStorage {
  // Get a reference your Supabase client
  final supabase = Supabase.instance.client;

  Future<void> createBucket() async {
    final buckets = await supabase.storage.listBuckets();
    if (!buckets.contains(kbucketPersonalImg)) {
      await supabase.storage.createBucket(kbucketPersonalImg);
    }
    return;
  }

  @override
  Future<String> setData({
    required String key,
    required File fileToSave,
  }) async {
    final imgName = Uuid().v1();
    // await createBucket();
    // final extenssion = p.extension(fileToSave.path);
    // final fullName = p.basename(fileToSave.path.split('/').last);
    // final fullPathh = p.join('images', key, fullName);
    await supabase.storage
        .from(kbucketPersonalImg)
        .upload("IMAGES/$imgName.png", fileToSave);

    final imageUrl = supabase.storage
        .from(kbucketPersonalImg)
        .getPublicUrl("IMAGES/$imgName.png");

    print("fullPath $imageUrl");

    return imageUrl;
  }
}
