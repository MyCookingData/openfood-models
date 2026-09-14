import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { client, livreur, restaurateur }

class AppUser {
  final String id;
  final String email;
  final UserRole role;
  final String zone;

  AppUser({
    required this.id,
    required this.email,
    required this.role,
    this.zone = 'Nord Caraïbe',
  });

  // Factory pour créer un objet AppUser depuis un document Firestore
  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    // Récupération sécurisée du rôle depuis la chaîne de caractères
    String roleString = data['role'] ?? 'client';
    UserRole parsedRole = UserRole.values.firstWhere(
      (e) => e.name == roleString,
      orElse: () => UserRole.client,
    );

    return AppUser(
      id: doc.id,
      email: data['email'] ?? '',
      role: parsedRole,
      zone: data['zone'] ?? 'Nord Caraïbe',
    );
  }

  // Convertir l'objet AppUser en Map pour Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'email': email,
      'role': role.name,
      'zone': zone,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  // Permet de cloner l'utilisateur avec de nouvelles valeurs
  AppUser copyWith({
    String? id,
    String? email,
    UserRole? role,
    String? zone,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      role: role ?? this.role,
      zone: zone ?? this.zone,
    );
  }
}
