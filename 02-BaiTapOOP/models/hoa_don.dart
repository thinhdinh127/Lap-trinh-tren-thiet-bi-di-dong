import 'dien_thoai.dart';

class HoaDon {
  String _maHD;
  DateTime _ngayBan;
  DienThoai _dienThoaiDuocBan;
  int _soLuongMua;
  double _giaBanThucTe;
  String _tenKH;
  String _soDienThoaiKH;

  // Constructor
  HoaDon(this._maHD, this._dienThoaiDuocBan, this._soLuongMua,
      this._giaBanThucTe, this._tenKH, this._soDienThoaiKH,
      {DateTime? ngayBan})
      : _ngayBan = ngayBan ?? DateTime.now() {
    // validation
    maHD = this._maHD;
    ngayBan = DateTime.now();
    giaBanThucTe = this._giaBanThucTe;
    tenKH = this._tenKH;
    soDienThoaiKH = this._soDienThoaiKH;
    dienThoaiDuocBan = _dienThoaiDuocBan;
    soLuongMua = _soLuongMua;
  }

  // Getters
  String get maHD => _maHD;
  DateTime get ngayBan => _ngayBan;
  DienThoai get dienThoaiDuocBan => _dienThoaiDuocBan;
  int get soLuongMua => _soLuongMua;
  double get giaBanThucTe => _giaBanThucTe;
  String get tenKH => _tenKH;
  String get soDienThoaiKH => _soDienThoaiKH;

  // Setters
  set maHD(String maHD) {
    if (maHD.isNotEmpty && RegExp(r'^HD-\d{3}$').hasMatch(maHD)) {
      _maHD = maHD;
    } else {
      throw ArgumentError('Mã hóa đơn không hợp lệ. Định dạng: "HD-XXX".');
    }
  }

  set ngayBan(DateTime ngayBan) {
    if (ngayBan.isAfter(DateTime.now()) ||
        ngayBan.isAtSameMomentAs(DateTime.now())) {
      _ngayBan = DateTime(
        ngayBan.year,
        ngayBan.month,
        ngayBan.day,
        ngayBan.hour,
        ngayBan.minute,
        ngayBan.second,
      );
    } else {
      throw ArgumentError('Ngày bán không được sau ngày hiện tại.');
    }
  }

  set dienThoaiDuocBan(DienThoai dienThoaiDuocBan) =>
      _dienThoaiDuocBan = dienThoaiDuocBan;

  set soLuongMua(int soLuongMua) {
    if (soLuongMua > 0 && soLuongMua <= _dienThoaiDuocBan.soLuongTonKho) {
      _soLuongMua = soLuongMua;
    } else {
      throw ArgumentError(
          'Số lượng mua phải lớn hơn 0 và nhỏ hơn số lượng tồn kho.');
    }
  }

  set giaBanThucTe(double giaBanThucTe) {
    if (giaBanThucTe > 0) {
      _giaBanThucTe = giaBanThucTe;
    } else {
      throw ArgumentError('Giá bán thực tế phải lớn hơn 0.');
    }
  }

  set tenKH(String tenKH) {
    if (tenKH.isNotEmpty) {
      _tenKH = tenKH;
    } else {
      throw ArgumentError('Tên khách hàng không được để trống.');
    }
  }

  set soDienThoaiKH(String soDienThoaiKH) {
    if (soDienThoaiKH.isNotEmpty &&
        RegExp(r'^(0[1-9][0-9]{8,9})$').hasMatch(soDienThoaiKH)) {
      _soDienThoaiKH = soDienThoaiKH;
    } else {
      throw ArgumentError(
          'Số điện thoại không hợp lệ. Vui lòng nhập số hợp lệ (10-11 số, bắt đầu bằng 0).');
    }
  }

  // Phương thức tính tổng tiền
  double tinhTongTien() => _soLuongMua * _giaBanThucTe;

  // Phương thức tính lợi nhuận thực tế
  double tinhLoiNhuanThucTe() =>
      _soLuongMua * (_giaBanThucTe - _dienThoaiDuocBan.giaNhap);

  // Phương thức hiển thị thông tin hóa đơn
  void hienThiThongTin() {
    print('\n------------------ Thông Tin Hóa Đơn ------------------\n');
    print('Mã hóa đơn         : $_maHD');
    print('Ngày bán           : ${_ngayBan}');
    print('Tên điện thoại     : ${_dienThoaiDuocBan.tenDT}');
    print('Số lượng mua       : $_soLuongMua');
    print('Giá bán thực tế    : $_giaBanThucTe');
    print('Tên khách hàng     : $_tenKH');
    print('Số điện thoại KH   : $_soDienThoaiKH');
    print('Tổng tiền          : ${tinhTongTien()}');
    print('Lợi nhuận thực tế  : ${tinhLoiNhuanThucTe()}');
  }
}
