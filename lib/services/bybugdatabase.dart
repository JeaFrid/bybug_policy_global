import 'dart:convert';
import 'dart:math';
import 'package:bybugpolicy/theme/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class ByBugDB {
  static WebSocketChannel? _channel;

  static bool get socketConnected => _channel != null;

  static String baseUrl = "http://localhost:8120";
  static String token = "";
  static Dio _dio = Dio(); // initialized on `initialize()`

  static void initialize({required String url, required String authToken}) {
    baseUrl = url;
    token = authToken;

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 5),
      ),
    );
  }

  static Future<List<String>> getAllBuckets() async {
    try {
      final res = await _dio.get("/allBuckets");
      return List<String>.from(res.data);
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ getAllBuckets hatası: $e\n$s");
      }
      return [];
    }
  }

  static Stream<Map<String, dynamic>> listenToBucket(String bucket) {
    try {
      final wsUrl =
          "${baseUrl.replaceFirst("http", "ws")}/ws/listenAll?token=$token";

      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));
      _channel!.sink.add(jsonEncode({"bucket": bucket}));
      return _channel!.stream.map((event) => jsonDecode(event));
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ listenToBucket hatası: $e\n$s");
      }
      return const Stream.empty();
    }
  }

  static Stream<Map<String, dynamic>> listenAllToBucket(String bucket) {
    try {
      final wsUrl =
          "${baseUrl.replaceFirst("http", "ws")}/ws/listenAll?token=$token";
      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));
      _channel!.sink.add(jsonEncode({"bucket": bucket}));
      return _channel!.stream.map((event) => jsonDecode(event));
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ listenAllToBucket hatası: $e\n$s");
      }
      return const Stream.empty();
    }
  }

  static void closeSocket() {
    try {
      _channel?.sink.close();
      _channel = null;
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ closeSocket hatası: $e\n$s");
      }
    }
  }

  static Future<Map<String, dynamic>> addData(
    String bucket,
    String tag,
    Map<String, dynamic> value,
  ) async {
    try {
      final res = await _dio.post(
        "/add",
        data: {"bucket": bucket, "tag": tag, "value": value},
      );
      return Map<String, dynamic>.from(res.data);
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ addData hatası: $e\n$s");
      }
      return {};
    }
  }

  static Future<Map<String, dynamic>> addAllData(
    List<Map<String, dynamic>> dataList,
  ) async {
    try {
      final res = await _dio.post("/addAll", data: dataList);
      return Map<String, dynamic>.from(res.data);
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ addAllData hatası: $e\n$s");
      }
      return {};
    }
  }

  static Future<Map<String, dynamic>> updateData(
    String id,
    Map<String, dynamic> value,
  ) async {
    try {
      final res = await _dio.post("/update", data: {"id": id, "value": value});
      return Map<String, dynamic>.from(res.data);
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ updateData hatası: $e\n$s");
      }
      return {};
    }
  }

  static Future<String?> getIdByTag(String bucket, String tag) async {
    try {
      final res = await _dio.post(
        "/getByTag",
        data: {"bucket": bucket, "tag": tag},
      );
      return res.data["id"];
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ getIdByTag hatası: $e\n$s");
      }
      return null;
    }
  }

  static Future<Map<String, dynamic>> getData(String id) async {
    try {
      final res = await _dio.post("/get", data: {"id": id});
      return Map<String, dynamic>.from(res.data);
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ getData hatası: $e\n$s");
      }
      return {};
    }
  }

  static Future<Map<String, dynamic>> deleteData(String id) async {
    try {
      final res = await _dio.post("/delete", data: {"id": id});
      return Map<String, dynamic>.from(res.data);
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ deleteData hatası: $e\n$s");
      }
      return {};
    }
  }

  static Future<List<Map<String, dynamic>>> listData(String bucket) async {
    try {
      final res = await _dio.post("/list", data: {"bucket": bucket});
      return List<Map<String, dynamic>>.from(res.data);
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ listData hatası: $e\n$s");
      }
      return [];
    }
  }

  static Future<void> deleteMany(List<String> ids) async {
    try {
      await _dio.post("/deleteMany", data: {"ids": ids});
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ deleteMany hatası: $e\n$s");
      }
    }
  }

  static Future<List<String>> getManyIds(List<List<String>> pairs) async {
    try {
      final res = await _dio.post("/getManyIds", data: {"pairs": pairs});
      return List<String>.from(res.data["ids"]);
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ getManyIds hatası: $e\n$s");
      }
      return [];
    }
  }

  static Future<void> removeAll(List<List> data) async {
    try {
      for (final item in data) {
        if (item.length != 2) {
          if (kDebugMode) {
            print("2 eleman gerekli: [bucket, tag]");
          }
        }
        if (item[0] is! String || item[1] is! String) {
          if (kDebugMode) {
            print("Geçersiz değer tipi.");
          }
        }
      }

      final ids = await getManyIds(List<List<String>>.from(data));
      if (ids.isNotEmpty) {
        await deleteMany(ids);
      }
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ removeAll hatası: $e\n$s");
      }
    }
  }
}

class ByBugDatabase {
  static bool get isConnected => ByBugDB.socketConnected;
  static Future<void> autoHandleOnlineStatus() async {
    await ByBugAuth.autoHandleOnlineStatus();
  }

  static Future<Map<String, dynamic>> add(
    String referance,
    String tag,
    Map<String, dynamic> value,
  ) async {
    try {
      return await ByBugDB.addData(referance, tag, value);
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ ByBugDatabase.add hatası: $e\n$s");
      }
      return {};
    }
  }

  static Future<void> onReady(String bucket, void Function() onConnect) async {
    try {
      final stream = ByBugDB.listenToBucket(bucket);
      final sub = stream.listen(
        (_) {},
        onDone: onConnect,
        cancelOnError: false,
      );
      Future.delayed(Duration(seconds: 1), () {
        onConnect();
        sub.cancel();
      });
    } catch (e, s) {
      if (kDebugMode) print("❌ onReady hatası: $e\n$s");
    }
  }

  static Future<void> addAll(List<Map<String, dynamic>> data) async {
    try {
      await ByBugDB.addAllData(data);
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ ByBugDatabase.addAll hatası: $e\n$s");
      }
    }
  }

  static Future<List<Map<String, dynamic>>> getAll(String bucket) async {
    try {
      return await ByBugDB.listData(bucket);
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ ByBugDatabase.getAll hatası: $e\n$s");
      }
      return [];
    }
  }

  static Future<bool> exists(String bucket, String tag) async {
    try {
      final id = await ByBugDB.getIdByTag(bucket, tag);
      return id != null;
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ ByBugDatabase.exists hatası: $e\n$s");
      }
      return false;
    }
  }

  static Future<Map<String, dynamic>> update(
    String bucket,
    String tag,
    Map<String, dynamic> newValue,
  ) async {
    try {
      final id = await ByBugDB.getIdByTag(bucket, tag);
      if (id == null) {
        if (kDebugMode) {
          print("❌ update → ID bulunamadı: $bucket / $tag");
        }
        return {};
      }
      return await ByBugDB.updateData(id, newValue);
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ ByBugDatabase.update hatası: $e\n$s");
      }
      return {};
    }
  }

  static Future<Map<String, dynamic>> removeById(String id) async {
    try {
      return await ByBugDB.deleteData(id);
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ removeById hatası: $e\n$s");
      }
      return {};
    }
  }

  static Future<String> exportBucket(String bucket) async {
    final data = await getAll(bucket);
    return jsonEncode(data);
  }

  static Future<void> watch(
    String bucket,
    String tag,
    Function(Map<String, dynamic> value) onChange,
  ) async {
    listenAll(
      bucket,
      onUpdate: (t, id, val) {
        if (t == tag) onChange(val);
      },
      onAdd: (t, id, val) {
        if (t == tag) onChange(val);
      },
    );
  }

  static Future<void> closeAllSockets() async {
    ByBugDB.closeSocket();
  }

  static Future<String?> getId(String bucket, String tag) async {
    try {
      return await ByBugDB.getIdByTag(bucket, tag);
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ getId hatası: $e\n$s");
      }
      return null;
    }
  }

  static Future<List<String>> getAllTags(String bucket) async {
    try {
      final all = await getAll(bucket);
      return all
          .map((e) => e["tag"]?.toString() ?? "")
          .where((e) => e.isNotEmpty)
          .toList();
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ getAllTags hatası: $e\n$s");
      }
      return [];
    }
  }

  static Future<int> count(String bucket) async {
    try {
      final all = await getAll(bucket);
      return all.length;
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ count hatası: $e\n$s");
      }
      return 0;
    }
  }

  static Future<List<Map<String, dynamic>>> filter(
    String bucket,
    bool Function(Map<String, dynamic> value) test,
  ) async {
    try {
      final all = await getAll(bucket);
      return all.where((e) {
        final value = e["value"];
        return value is Map<String, dynamic> && test(value);
      }).toList();
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ filter hatası: $e\n$s");
      }
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> filterByField(
    String bucket,
    String field,
    dynamic expectedValue,
  ) async {
    try {
      final all = await getAll(bucket);
      return all.where((e) => e["value"]?[field] == expectedValue).toList();
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ filterByField hatası: $e\n$s");
      }
      return [];
    }
  }

  static Future<void> clear(String bucket) async {
    try {
      final items = await getAll(bucket);
      final ids = items.map((e) => [bucket, e["tag"]]).toList();
      await removeAll(ids);
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ ByBugDatabase.clear hatası: $e\n$s");
      }
    }
  }

  static Future<List<Map<String, dynamic>>> search(
    String bucket,
    String field,
    String keyword,
  ) async {
    try {
      final all = await getAll(bucket);
      return all.where((e) {
        final value = e["value"];
        if (value is Map<String, dynamic> && value[field] is String) {
          return value[field].toLowerCase().contains(keyword.toLowerCase());
        }
        return false;
      }).toList();
    } catch (e, s) {
      if (kDebugMode) print("❌ search hatası: $e\n$s");
      return [];
    }
  }

  static Future<Map<String, List<Map<String, dynamic>>>> groupBy(
    String bucket,
    String field,
  ) async {
    final result = <String, List<Map<String, dynamic>>>{};
    try {
      final all = await getAll(bucket);
      for (var item in all) {
        final value = item["value"];
        final key = value?[field]?.toString() ?? "undefined";
        result.putIfAbsent(key, () => []).add(item);
      }
      return result;
    } catch (e, s) {
      if (kDebugMode) print("❌ groupBy hatası: $e\n$s");
      return {};
    }
  }

  static Future<Map<String, dynamic>?> firstWhere(
    String bucket,
    bool Function(Map<String, dynamic> value) test,
  ) async {
    try {
      final all = await getAll(bucket);
      for (final e in all) {
        final value = e["value"];
        if (value is Map<String, dynamic> && test(value)) {
          return e;
        }
      }
      return null;
    } catch (e, s) {
      if (kDebugMode) print("❌ firstWhere hatası: $e\n$s");
      return null;
    }
  }

  static Future<void> removeAll(List<List> data) async {
    try {
      await ByBugDB.removeAll(data);
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ ByBugDatabase.removeAll hatası: $e\n$s");
      }
    }
  }

  static Future<Map<String, dynamic>> get(String referance, String tag) async {
    try {
      String? id = await ByBugDB.getIdByTag(referance, tag);
      if (id == null) {
        if (kDebugMode) {
          print("❌ ByBugDatabase.get → ID bulunamadı: $referance / $tag");
        }
        return {};
      } else {
        return await ByBugDB.getData(id);
      }
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ ByBugDatabase.get hatası: $e\n$s");
      }
      return {};
    }
  }

  static Future<Map<String, dynamic>> remove(
    String referance,
    String tag,
  ) async {
    try {
      String? id = await ByBugDB.getIdByTag(referance, tag);
      if (id == null) {
        if (kDebugMode) {
          print("❌ ByBugDatabase.remove → ID bulunamadı: $referance / $tag");
        }
        return {};
      } else {
        return await ByBugDB.deleteData(id);
      }
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ ByBugDatabase.remove hatası: $e\n$s");
      }
      return {};
    }
  }

  static Future<List<String>> getAllBucketsName(
    Map<String, dynamic> newData,
  ) async {
    try {
      return await ByBugDB.getAllBuckets();
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ ByBugDatabase.getAllBucketsName hatası: $e\n$s");
      }
      return [];
    }
  }

  static Future<void> listen(
    String referance,
    Function(Map<String, dynamic>)? onData,
  ) async {
    try {
      ByBugDB.listenToBucket(referance).listen(
        (event) {
          if (onData != null) {
            onData(event);
          }
        },
        onError: (e, s) {
          if (kDebugMode) {
            print("❌ ByBugDatabase.listen hata: $e\n$s");
          }
        },
      );
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ ByBugDatabase.listen başlatma hatası: $e\n$s");
      }
    }
  }

  static Future<void> listenAll(
    String referance, {
    void Function(String tag, String id, Map<String, dynamic> value)? onAdd,
    void Function(String tag, String id, Map<String, dynamic> value)? onUpdate,
    void Function(String tag, String id, Map<String, dynamic> value)? onDelete,
  }) async {
    try {
      ByBugDB.listenAllToBucket(referance).listen(
        (event) {
          final type = event["event"];
          final tag = event["tag"];
          final id = event["id"];
          final value = event["value"];

          switch (type) {
            case "added":
              if (onAdd != null) onAdd(tag, id, value);
              break;
            case "updated":
              if (onUpdate != null) onUpdate(tag, id, value);
              break;
            case "deleted":
              if (onDelete != null) onDelete(tag, id, value);
              break;
          }
        },
        onError: (e, s) {
          if (kDebugMode) {
            print("❌ ByBugDatabase.listen hata: $e\n$s");
          }
        },
      );
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ ByBugDatabase.listen başlatma hatası: $e\n$s");
      }
    }
  }

  static Future<void> listenChanges(
    String referance,
    void Function({
      required String type,
      required String tag,
      required String id,
      required Map<String, dynamic> value,
    })
    onEvent,
  ) async {
    try {
      ByBugDB.listenAllToBucket(referance).listen(
        (event) {
          onEvent(
            type: event["event"],
            tag: event["tag"],
            id: event["id"],
            value: event["value"],
          );
        },
        onError: (e, s) {
          if (kDebugMode) {
            print("❌ ByBugDatabase.listenChanges hata: $e\n$s");
          }
        },
      );
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ ByBugDatabase.listenChanges başlatma hatası: $e\n$s");
      }
    }
  }

  static Future<void> watchTag(
    String bucket,
    String tag,
    void Function(Map<String, dynamic> value)? onChange,
  ) async {
    try {
      ByBugDB.listenToBucket(bucket).listen(
        (event) {
          if (event["tag"] == tag) {
            if (onChange != null) onChange(event["value"]);
          }
        },
        onError: (e, s) {
          if (kDebugMode) {
            print("❌ ByBugDatabase.watchTag hata: $e\n$s");
          }
        },
      );
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ ByBugDatabase.watchTag başlatma hatası: $e\n$s");
      }
    }
  }

  static void stopAllListeners() {
    ByBugDB.closeSocket();
  }
}

class ByBugAuthProperties {
  static Future<void> registerDevice(String uid) async {
    var db = await SharedPreferences.getInstance();
    await db.setBool("ByBugDatabaseAuthRegisterOrLoginIsTrue", true);
    await db.setString("ByBugDatabaseAuthRegisterOrLoginUID", uid);
  }

  static Future<void> logoutDevice() async {
    var db = await SharedPreferences.getInstance();
    await db.remove("ByBugDatabaseAuthRegisterOrLoginIsTrue");
    await db.remove("ByBugDatabaseAuthRegisterOrLoginUID");
  }

  static Future<bool> isRegisterDevice() async {
    var db = await SharedPreferences.getInstance();
    if (db.containsKey("ByBugDatabaseAuthRegisterOrLoginIsTrue")) {
      return db.getBool("ByBugDatabaseAuthRegisterOrLoginIsTrue") ?? false;
    } else {
      return false;
    }
  }
}

class ByBugAuth {
  /// 🇹🇷 Rastgele, çakışması neredeyse imkânsız bir kullanıcı ID’si üretir. Zaman etiketiyle birlikte gelir.
  /// 🇺🇸 Generates a random, nearly collision-proof user ID with a timestamp.
  ///
  /// Returns: <b>String</b> (e.g., <i>R7wFsd9gKz04JwYe21Nc15052025194655</i>)
  ///
  /// Example:
  /// ```dart
  /// final uid = ByBugAuth.generateUID();
  /// ```
  static String generateUID({int length = 20}) {
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final rand = Random.secure();
    return List.generate(
          length,
          (index) => chars[rand.nextInt(chars.length)],
        ).join() +
        timeTag();
  }

  /// 🇹🇷 Güncel zamanı saniye bazlı string olarak döner. UID üretiminde kullanılır.
  /// 🇺🇸 Returns the current time as a second-precision string for UID generation.
  ///
  /// Returns: <b>String</b> (e.g., <i>15052025194655</i>)
  static String timeTag() {
    return DateTime.now().day.toString() +
        DateTime.now().month.toString() +
        DateTime.now().year.toString() +
        DateTime.now().hour.toString() +
        DateTime.now().minute.toString() +
        DateTime.now().second.toString();
  }

  /// 🇹🇷 Cihazda bir oturumun açık olup olmadığını kontrol eder.
  /// 🇺🇸 Checks whether the device has an active user session.
  ///
  /// Returns: <b>Future&lt;bool&gt;</b>
  ///
  /// Example:
  /// ```dart
  /// if (await ByBugAuth.isSignedIn()) {
  ///   print("Kullanıcı giriş yapmış");
  /// }
  /// ```

  static Future<bool> isSignedIn() async {
    return await ByBugAuthProperties.isRegisterDevice();
  }

  static Future<bool> isUserOnline(String uid) async {
    try {
      final data = await ByBugDatabase.get("online_status", uid);
      return data["value"]?["online"] == true;
    } catch (e, s) {
      if (kDebugMode) {
        print("❌ isUserOnline hatası: $e\n$s");
      }
      return false;
    }
  }

  /// 🇹🇷 Giriş yapmış kullanıcının UID’sini döner. Oturum yoksa <i>null</i> döner.
  /// 🇺🇸 Returns the UID of the signed-in user. If no session exists, returns <i>null</i>.
  ///
  /// Returns: <b>Future&lt;String?&gt;</b>
  static Future<String?> getUID() async {
    if (await ByBugAuthProperties.isRegisterDevice()) {
      var db = await SharedPreferences.getInstance();
      String? uid = db.getString("ByBugDatabaseAuthRegisterOrLoginUID");
      if (uid != null) {
        return uid;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  /// 🇹🇷 Kullanıcı oturumunu kapatır ve cihazdaki giriş bilgilerini temizler.
  /// 🇺🇸 Logs out the user and clears the session data from the device.
  ///
  /// Returns: <b>Future&lt;void&gt;</b>

  static Future<void> logout() async {
    return await ByBugAuthProperties.logoutDevice();
  }

  String hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  /// 🇹🇷 Verilen e-posta adresiyle kullanıcıyı bulur ve şifresini günceller.
  /// 🇺🇸 Finds user by email and updates their password.
  ///
  /// Returns: <b>Future&lt;List&gt;</b> → [1, "Success"] or [0, "Error"]
  static Future<List> resetPassword(String email, String newPassword) async {
    email = email.trim().toLowerCase();
    final users = await ByBugDatabase.getAll(
      "usersDatabaseByBugDatabase135153",
    );

    for (var user in users) {
      final value = user["value"];
      if (value["email"] == email) {
        final uid = user["tag"];
        value["password"] = newPassword;
        await ByBugDatabase.add("usersDatabaseByBugDatabase135153", uid, value);
        return [1, "Şifre güncellendi"];
      }
    }
    return [0, "Kullanıcı bulunamadı"];
  }

  /// 🇹🇷 Tüm kullanıcıları getirir
  /// 🇺🇸 Returns all user entries in the database.
  ///
  /// Returns: <b>Future&lt;List&lt;Map&gt;&gt;</b>
  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    String bucket = "usersDatabaseByBugDatabase135153";
    List<Map<String, dynamic>> y = [];
    final x = await ByBugDatabase.getAll(bucket);
    for (var element in x) {
      y.add(element["value"]);
    }
    return y;
  }

  /// 🇹🇷 Giriş yapan kullanıcının hesabını tamamen siler.
  /// 🇺🇸 Deletes the currently signed-in user's account permanently.
  ///
  /// Returns: <b>Future&lt;List&gt;</b> → [1, "Success"] or [0, "Error"]
  static Future<List> deleteAccount() async {
    final uid = await getUID();
    if (uid == null) return [0, "Oturum açık değil"];
    try {
      await ByBugDatabase.remove("usersDatabaseByBugDatabase135153", uid);
      await logout();
      return [1, "Hesap silindi"];
    } catch (e) {
      return [0, "Silinemedi: $e"];
    }
  }

  /// 🇹🇷 Yeni kullanıcı kaydı oluşturur. E-posta daha önce kullanılmışsa hata verir.
  /// 🇺🇸 Registers a new user. If the email already exists, returns an error.
  ///
  /// Params:
  /// - email (required)
  /// - password (required)
  /// - phone, photo, uid, language, theme, lastLogin, emailVerified, phoneVerified, data (optional)
  ///
  /// Returns: <b>Future&lt;List&gt;</b> → [0, "Error"] or [1, "Success"]
  ///
  /// Example:
  /// ```dart
  /// final result = await ByBugAuth.register("ali@mail.com", "123456");
  /// if (result[0] == 1) print("Kayıt başarılı");
  /// ```

  static Future<List> register(
    String email,
    String password, {
    String? phone,
    String? photo,
    String? name,
    String? banner,
    String? ip,
    bool? isOnline,
    String? uid,
    String? language,
    String? theme,
    String? lastLogin,
    bool? emailVerified,
    bool? phoneVerified,
    Map<String, dynamic>? data,
  }) async {
    bool isAvailable = false;
    List<Map<String, dynamic>> x = await ByBugDatabase.getAll(
      "usersDatabaseByBugDatabase135153",
    );
    for (Map<String, dynamic> element in x) {
      if (element["value"]["email"] == email.trim().toLowerCase()) {
        isAvailable = true;
        break;
      }
    }
    if (isAvailable == true) {
      return [0, "Böyle bir hesap zaten mevcut."];
    } else {
      String uidGen = generateUID();
      await ByBugDatabase.add("usersDatabaseByBugDatabase135153", uidGen, {
        "email": email.trim().toLowerCase(),
        "password": password,
        "phone": phone ?? "",
        "photo": photo ?? "",
        "uid": uid ?? uidGen,
        "name": name ?? "",
        "banner": banner ?? "",
        "ip": ip ?? "",
        "isOnline": isOnline ?? false,
        "language": language ?? "",
        "theme": theme ?? "",
        "lastLogin": lastLogin ?? "",
        "emailVerified": emailVerified ?? false,
        "phoneVerified": phoneVerified ?? false,
        "data": data ?? {},
      });
      await ByBugAuthProperties.registerDevice(uid ?? uidGen);
      return [1, "Profil oluşturuldu"];
    }
  }

  /// 🇹🇷 Kullanıcıyı e-posta ve şifre ile giriş yaptırır.
  /// 🇺🇸 Logs in a user using email and password.
  ///
  /// Returns: <b>Future&lt;List&gt;</b> → [0, "Error"] or [1, Map of user data]
  ///
  /// Example:
  /// ```dart
  /// final login = await ByBugAuth.login("ali@mail.com", "123456");
  /// if (login[0] == 1) print("Giriş başarılı");
  /// ```

  static Future<List> login(String email, String password) async {
    email = email.trim().toLowerCase();

    final users = await ByBugDatabase.getAll(
      "usersDatabaseByBugDatabase135153",
    );

    for (var user in users) {
      final value = user["value"];
      print(value);
      if (value["email"] == email && value["password"] == password) {
        await ByBugAuthProperties.registerDevice(value["uid"]);
        return [1, value];
      }
    }
    return [0, "E-posta veya şifre hatalı"];
  }

  /// 🇹🇷 Oturum açık olan kullanıcının verisini getirir. Giriş yapılmamışsa null döner.
  /// 🇺🇸 Returns the current signed-in user's profile data. Returns null if no session.
  ///
  /// Returns: <b>Future&lt;Map&lt;String, dynamic&gt;?&gt;</b>

  static Future<Map<String, dynamic>?> getCurrentUser({
    String? targetUID,
  }) async {
    try {
      String? uid = targetUID ?? await getUID();
      if (uid == null) return null;
      String bucket = "usersDatabaseByBugDatabase135153";
      final usr = await ByBugDatabase.get(bucket, uid);
      return usr["value"];
    } catch (e) {
      return null;
    }
  }

  static Future<void> setUserOnlineStatus(bool online) async {
    final uid = await ByBugAuth.getUID();
    if (uid == null) return;

    await ByBugDatabase.add("online_status", uid, {
      "online": online,
      "lastSeen": DateTime.now().toIso8601String(),
    });
  }

  static Future<void> autoHandleOnlineStatus() async {
    WidgetsBinding.instance.addObserver(_AppLifecycleObserver());
    await setUserOnlineStatus(true);
  }

  /// 🇹🇷 Giriş yapan kullanıcının profil bilgilerini günceller.
  /// 🇺🇸 Updates the current signed-in user's profile data.
  ///
  /// Params: <b>Map&lt;String, dynamic&gt;</b> newData
  ///
  /// Returns: <b>Future&lt;List&gt;</b> → [1, "Success"] or [0, "Error"]
  ///
  /// Example:
  /// ```dart
  /// await ByBugAuth.updateProfile({"theme": "dark", "language": "tr"});
  /// ```

  static Future<List> updateProfile(Map<String, dynamic> newData) async {
    final uid = await getUID();
    if (uid == null) return [0, "Oturum açık değil"];

    try {
      final existing = await ByBugDatabase.get(
        "usersDatabaseByBugDatabase135153",
        uid,
      );
      Map<String, dynamic> updated = {...existing["value"], ...newData};

      await ByBugDatabase.add("usersDatabaseByBugDatabase135153", uid, updated);
      return [1, "Profil güncellendi"];
    } catch (e) {
      return [0, "Güncelleme başarısız: $e"];
    }
  }
}

class ByBugStorage {
  static Dio _dio = Dio();

  static Future<String?> uploadFile(String filePath) async {
    try {
      _dio = Dio(
        BaseOptions(
          baseUrl: ByBugDB.baseUrl,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${ByBugDB.token}",
          },
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 5),
        ),
      );
      final file = await MultipartFile.fromFile(filePath);
      final formData = FormData.fromMap({"file": file});

      final res = await _dio.post(
        "/uploadFile",
        data: formData,
        options: Options(headers: {"Authorization": "Bearer ${ByBugDB.token}"}),
      );

      return "${ByBugDB.baseUrl}${res.data["url"]}";
    } catch (e, s) {
      if (kDebugMode) {
        print("$e\n$s");
      }
      return null;
    }
  }

  static Future<bool> downloadFile(String filename, String savePath) async {
    try {
      final url = "/getFile/$filename";
      final response = await _dio.download(
        url,
        savePath,
        options: Options(headers: {"Authorization": "Bearer ${ByBugDB.token}"}),
      );
      return response.statusCode == 200;
    } catch (e, s) {
      if (kDebugMode) {
        print("$e\n$s");
      }
      return false;
    }
  }

  static Future<bool> deleteFile(String filename) async {
    try {
      final res = await _dio.post(
        "/deleteFile",
        data: {"filename": filename},
        options: Options(headers: {"Authorization": "Bearer ${ByBugDB.token}"}),
      );

      return res.data["status"] == "deleted";
    } catch (e, s) {
      if (kDebugMode) {
        print("$e\n$s");
      }
      return false;
    }
  }

  static Future<String?> pickFileAndUpload() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      final file = result.files.first;

      if (kIsWeb) {
        if (file.bytes != null) {
          final filename = "${Random().nextInt(99999)}_${file.name}";
          final formData = FormData.fromMap({
            "file": MultipartFile.fromBytes(file.bytes!, filename: filename),
          });

          final res = await Dio().post(
            "${ByBugDB.baseUrl}/uploadFile",
            data: formData,
            options: Options(
              headers: {"Authorization": "Bearer ${ByBugDB.token}"},
            ),
          );

          return "${ByBugDB.baseUrl}${res.data["url"]}";
        } else {
          return null;
        }
      } else {
        if (file.path != null) {
          return await uploadFile(file.path!);
        } else {
          return null;
        }
      }
    }
    return null;
  }
}

class ImageWithByBugStorage extends StatefulWidget {
  final String url;
  final String token;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final AlignmentGeometry alignment;
  final ImageRepeat repeat;
  final bool matchTextDirection;
  final bool gaplessPlayback;
  final FilterQuality filterQuality;
  final Color? color;
  final BlendMode? colorBlendMode;
  final WidgetBuilder? loadingBuilder;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  const ImageWithByBugStorage({
    super.key,
    required this.url,
    required this.token,
    this.width,
    this.height,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.filterQuality = FilterQuality.low,
    this.color,
    this.colorBlendMode,
    this.loadingBuilder,
    this.errorBuilder,
  });

  @override
  State<ImageWithByBugStorage> createState() => _ImageWithByBugStorageState();
}

class _ImageWithByBugStorageState extends State<ImageWithByBugStorage> {
  late Future<Uint8List> _imageFuture;

  Future<Uint8List> _loadImage() async {
    final response = await Dio().get<List<int>>(
      widget.url,
      options: Options(
        responseType: ResponseType.bytes,
        headers: {"Authorization": "Bearer ${widget.token}"},
      ),
    );
    return Uint8List.fromList(response.data!);
  }

  @override
  void initState() {
    super.initState();
    _imageFuture = _loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: _imageFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.loadingBuilder?.call(context) ??
              const SizedBox.shrink();
        } else if (snapshot.hasError) {
          return widget.errorBuilder?.call(
                context,
                snapshot.error!,
                snapshot.stackTrace,
              ) ??
               Icon(Icons.broken_image,color: textColor,);
        } else {
          return Image.memory(
            snapshot.data!,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
            alignment: widget.alignment,
            repeat: widget.repeat,
            matchTextDirection: widget.matchTextDirection,
            gaplessPlayback: widget.gaplessPlayback,
            filterQuality: widget.filterQuality,
            color: widget.color,
            colorBlendMode: widget.colorBlendMode,
          );
        }
      },
    );
  }
}

class _AppLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ByBugAuth.setUserOnlineStatus(true);
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      ByBugAuth.setUserOnlineStatus(false);
    }
  }
}
