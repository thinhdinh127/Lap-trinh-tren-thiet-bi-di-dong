class Sach {
  String _maSach;
  String _tenSach;
  String _tacGia;
  bool _trangThaiMuon; // true: đang được mượn, false: chưa được mượn

  // Constructor
  Sach(this._maSach, this._tenSach, this._tacGia, this._trangThaiMuon);

  // Getter và Setter
  String get maSach => _maSach;
  String get tenSach => _tenSach;
  String get tacGia => _tacGia;
  bool get trangThaiMuon => _trangThaiMuon;

  set maSach(String value) {
    if (value.isEmpty) _maSach = value;
  }

  set tenSach(String value) {
    if (value.isEmpty) _tenSach = value;
  }

  set tacGia(String value) {
    if (value.isEmpty) _tacGia = value;
  }

  set trangThaiMuon(bool value) {
    _trangThaiMuon = value;
  }

  // Phương thức hiển thị thông tin sách
  void hienThiThongTin() {
    print("Mã sách: $_maSach");
    print("Tên sách: $_tenSach");
    print("Tác giả: $_tacGia");
    print("Trạng thái mượn: ${_trangThaiMuon ? "Đã mượn" : "Chưa mượn"}");
  }
}
