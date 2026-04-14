/// Usuario de tienda mapeado desde Fake Store o DummyJSON.
///
/// - [id]: Identificador del usuario en la API.
/// - [email]: Correo electrónico.
/// - [username]: Nombre de usuario.
/// - [firstName]: Nombre.
/// - [lastName]: Apellido.
/// - [phone]: Teléfono.
class StoreUserModel {
  const StoreUserModel({
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

  /// Nombre y apellido concatenados y recortados.
  String get fullName => '$firstName $lastName'.trim();
}
