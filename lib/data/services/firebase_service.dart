import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

/// Firebase service for Cocktailian app.
/// Handles initialization and provides access to Firebase services.
class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() => _instance;
  FirebaseService._internal();

  // Firebase instances
  FirebaseFirestore? _firestore;
  FirebaseAuth? _auth;
  FirebaseStorage? _storage;

  // Getters for Firebase services
  FirebaseFirestore get firestore => _firestore ?? FirebaseFirestore.instance;
  FirebaseAuth get auth => _auth ?? FirebaseAuth.instance;
  FirebaseStorage get storage => _storage ?? FirebaseStorage.instance;

  /// Initialize Firebase for the app.
  /// This should be called before runApp() in main.dart.
  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp();
      debugPrint('Firebase initialized successfully');
    } catch (e) {
      debugPrint('Error initializing Firebase: $e');
      rethrow;
    }
  }

  /// Test Firebase connection.
  /// Returns true if connection is successful.
  Future<bool> testConnection() async {
    try {
      // Test Firestore connection
      await firestore.enableNetwork();

      // Test Auth connection
      final user = auth.currentUser;
      debugPrint(
        'Auth connection test - Current user: ${user?.uid ?? 'No user'}',
      );

      // Test Storage connection
      final storageRef = storage.ref();
      debugPrint('Storage connection test - Reference: ${storageRef.fullPath}');

      return true;
    } catch (e) {
      debugPrint('Firebase connection test failed: $e');
      return false;
    }
  }

  /// Get a reference to a Firestore collection.
  CollectionReference collection(String path) {
    return firestore.collection(path);
  }

  /// Get a reference to a Firestore document.
  DocumentReference document(String path) {
    return firestore.doc(path);
  }

  /// Get a reference to Firebase Storage.
  Reference storageRef([String? path]) {
    return path != null ? storage.ref(path) : storage.ref();
  }

  /// Test Firestore security rules.
  /// Returns true if basic read operations work as expected.
  Future<bool> testSecurityRules() async {
    try {
      debugPrint('Testing Firestore security rules...');

      // Test reading cocktails collection (should work)
      final cocktailsQuery = await firestore
          .collection('cocktails')
          .limit(1)
          .get();
      debugPrint(
        '✅ Can read cocktails collection (${cocktailsQuery.docs.length} docs)',
      );

      // Test reading ingredients collection (should work)
      final ingredientsQuery = await firestore
          .collection('ingredients')
          .limit(1)
          .get();
      debugPrint(
        '✅ Can read ingredients collection (${ingredientsQuery.docs.length} docs)',
      );

      // Test reading user inventory (should work)
      final userInventoryDoc = await firestore
          .collection('user_inventories')
          .doc('test-user')
          .get();
      debugPrint(
        '✅ Can read user inventory (exists: ${userInventoryDoc.exists})',
      );

      // Test writing to user inventory (should work)
      await firestore.collection('user_inventories').doc('test-user').set({
        'ingredientIds': ['gin', 'tonic'],
        'lastUpdated': FieldValue.serverTimestamp(),
      });
      debugPrint('✅ Can write to user inventory');

      debugPrint('🎉 Security rules test passed!');
      return true;
    } catch (e) {
      debugPrint('❌ Security rules test failed: $e');
      return false;
    }
  }
}
