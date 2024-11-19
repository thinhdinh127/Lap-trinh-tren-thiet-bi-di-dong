import '../models/sach.dart';

class DocGia {
  String _maDocGia;
  String _hoTen;
  List<Sach> _danhSachSachMuon = [];

  // Constructor
  DocGia(this._maDocGia, this._hoTen);

  // Getter và Setter
  String get maDocGia => _maDocGia;
  String get hoTen => _hoTen;

  set maDocGia(String value) {
    if (value.isEmpty) _maDocGia = value;
  }

  set hoTen(String value) {
    if (value.isEmpty) _hoTen = value;
  }

  List<Sach> get danhSachSachMuon => _danhSachSachMuon;

  // Phương thức mượn sách
  void muonSach(Sach sach) {
    if (sach.trangThaiMuon) {
      print("Sách ${sach.tenSach} đã có người mượn.");
      return;
    }
    _danhSachSachMuon.add(sach);
    sach.trangThaiMuon = true;
    print("Bạn đã mượn sách: ${sach.tenSach}");
  }

  // Phương thức trả sách
  void traSach(Sach sach) {
    if (_danhSachSachMuon.contains(sach)) {
      _danhSachSachMuon.remove(sach);
      sach.trangThaiMuon = false;
      print("Bạn đã trả sách: ${sach.tenSach}");
    } else {
      print("Sách ${sach.tenSach} không có trong danh sách mượn.");
    }
  }
}
