/// Entidad de dominio que representa un usuario registrado en la tienda.
///
/// - [id]: Identificador único del usuario en la API.
/// - [email]: Correo electrónico del usuario.
/// - [username]: Nombre de usuario para inicio de sesión o visualización.
/// - [firstName]: Nombre de pila.
/// - [lastName]: Apellido.
/// - [phone]: Teléfono de contacto.
///
/// Además expone [fullName], nombre completo concatenado para la UI.
class UserEntity {
  const UserEntity({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phone,
  });

  final int id;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String phone;

  /// Nombre y apellido unidos, recortando espacios sobrantes.
  String get fullName => '$firstName $lastName'.trim();
}
