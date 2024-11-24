class DienThoai {
  String _maDT;
  String _tenDT;
  String _hangSanXuat;
  double _giaNhap;
  double _giaBan;
  int _soLuongTonKho;
  bool _trangThai = false;

  // Constructor
  DienThoai(
      String this._maDT,
      String this._tenDT,
      String this._hangSanXuat,
      double this._giaNhap,
      double this._giaBan,
      int this._soLuongTonKho,
      bool this._trangThai) {
    // validation
    maDT = this._maDT;
    tenDT = this._tenDT;
    hangSanXuat = this._hangSanXuat;
    giaNhap = this._giaNhap;
    giaBan = this._giaBan;
    soLuongTonKho = this._soLuongTonKho;
    trangThai = this._trangThai;
  }

  // Getters
  String get maDT => _maDT;
  String get tenDT => _tenDT;
  String get hangSanXuat => _hangSanXuat;
  double get giaNhap => _giaNhap;
  double get giaBan => _giaBan;
  int get soLuongTonKho => _soLuongTonKho;
  bool get trangThai => _trangThai;

  // Setters
  set maDT(String maDT) {
    if (maDT.isNotEmpty && RegExp(r'^DT-\d{3}$').hasMatch(maDT)) {
      _maDT = maDT;
    } else {
      throw new ArgumentError(
          "Mã điện thoại không được rỗng và phải bắt đầu bằng 'DT-'.");
    }
  }

  set tenDT(String tenDT) {
    if (tenDT.isNotEmpty) {
      _tenDT = tenDT;
    } else {
      throw new ArgumentError("Tên điện thoại không được rỗng.");
    }
  }

  set hangSanXuat(String hangSanXuat) {
    if (hangSanXuat.isNotEmpty) {
      _hangSanXuat = hangSanXuat;
    } else {
      throw new ArgumentError("Hãng sản xuất không được rỗng.");
    }
  }

  set giaNhap(double giaNhap) {
    if (giaNhap > 0) {
      _giaNhap = giaNhap;
    } else {
      throw new ArgumentError("Giá nhập phải lớn hơn 0.");
    }
  }

  set giaBan(double giaBan) {
    if (giaBan > 0 && giaBan > giaNhap) {
      _giaBan = giaBan;
    } else {
      throw new ArgumentError("Giá bán phải lớn hơn 0 và không <= giá nhập.");
    }
  }

  set soLuongTonKho(int soLuongTonKho) {
    if (soLuongTonKho >= 0) {
      _soLuongTonKho = soLuongTonKho;
    } else {
      throw new ArgumentError("Số lượng tồn kho phải là số dương.");
    }
  }

  set trangThai(bool trangThai) {
    _trangThai = trangThai;
  }

  // Phương thức tính lợi nhuận dự kiến
  double tinhLoiNhuan() => (_giaBan - _giaNhap) * _soLuongTonKho;

  // Phương thức kiểm tra có thể bán không (còn hàng và đang kinh doanh)
  bool coTheBan() => _soLuongTonKho > 0 && _trangThai;

  // Phương thức hiển thị thông tin
  void hienThiThongTin() {
    print('\n---------- Thông Tin Điện Thoại ----------\n');
    print('Mã điện thoại      : $_maDT');
    print('Tên điện thoại     : $_tenDT');
    print('Hãng sản xuất      : $_hangSanXuat');
    print('Giá nhập           : $_giaNhap');
    print('Giá bán            : $_giaBan');
    print('Số lượng tồn kho   : $_soLuongTonKho');
    print(
        'Trạng thái         : ${_trangThai ? "Còn kinh doanh" : "Ngừng kinh doanh"}');
    print('Lợi nhuận dự kiến  : ${tinhLoiNhuan()}');
    print('Có thể bán         : ${coTheBan() ? "Có" : "Không"}');
    print('\n------------------------------------------');
  }
}
