class UserModel {
  // late int id;
  late String username;
  late String nama;
  late String nohp;
  late String password;

  UserModel(this.username, this.nama, this.nohp, this.password);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      // 'id': id,
      'username': username,
      'nama': nama,
      'nohp': nohp,
      'password': password
    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    // id = map['id'];
    username = map['username'];
    nama = map['nama'];
    nohp = map['nohp'];
    password = map['password'];
  }
}
