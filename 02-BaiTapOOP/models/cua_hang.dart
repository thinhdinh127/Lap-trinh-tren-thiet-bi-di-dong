import 'dien_thoai.dart';
import 'hoa_don.dart';

class CuaHang {
  String _tenCuaHang;
  String _DiaChi;
  List<DienThoai> _danhSachDienThoai = [];
  List<HoaDon> _danhSachHoaDon = [];

  // Constructor
  CuaHang(this._tenCuaHang, this._DiaChi) {
    tenCuaHang = this._tenCuaHang;
    diaChi = this._DiaChi;
  }

  // Getters
  String get tenCuaHang => _tenCuaHang;
  String get diaChi => _DiaChi;
  List<DienThoai> get danhSachDienThoai => _danhSachDienThoai;
  List<HoaDon> get danhSachHoaDon => _danhSachHoaDon;

  // Setters
  set tenCuaHang(String tenCuaHang) {
    if (tenCuaHang.isNotEmpty) {
      _tenCuaHang = tenCuaHang;
    } else
      throw ArgumentError('Tên của hàng không được để trống.');
  }

  set diaChi(String diaChi) {
    if (diaChi.isNotEmpty) {
      _DiaChi = diaChi;
    } else
      throw ArgumentError('Địa chỉ của hàng không được để trống.');
  }

  // Các phương thức quản lý điện thoại
  // Thêm điện thoại mới
  void themDienThoai(DienThoai dienThoai) {
    _danhSachDienThoai.add(dienThoai);
    print('Đã thêm điện thoại: ${dienThoai.tenDT} thành công!');
  }

  // Cập nhật thông tin điện thoại
  void capNhatDienThoai(String maDT,
      {String? tenMoi,
      String? hangMoi,
      double? giaNhapMoi,
      double? giaBanMoi,
      int? soLuongMoi,
      bool? trangThaiMoi}) {
    // Tìm điện thoại theo mã điện thoại
    var dienThoai = _danhSachDienThoai.firstWhere((dt) => dt.maDT == maDT,
        orElse: () =>
            throw Exception('Không tìm thấy điện thoại với mã $maDT'));
    // Cập nhật các thông tin nếu giá trị mới không null
    if (tenMoi != null && tenMoi.isNotEmpty) {
      dienThoai.tenDT = tenMoi;
    }
    if (hangMoi != null && hangMoi.isNotEmpty) {
      dienThoai.hangSanXuat = hangMoi;
    }
    if (giaNhapMoi != null && giaNhapMoi > 0) {
      dienThoai.giaNhap = giaNhapMoi;
    }
    if (giaBanMoi != null && giaBanMoi > (giaNhapMoi ?? dienThoai.giaNhap)) {
      dienThoai.giaBan = giaBanMoi;
    }
    if (soLuongMoi != null && soLuongMoi >= 0) {
      dienThoai.soLuongTonKho = soLuongMoi;
    }
    if (trangThaiMoi != null) {
      dienThoai.trangThai = trangThaiMoi;
    }
    print("Thông tin điện thoại mã $maDT đã được cập nhật.");
  }

  // Ngừng kinh doanh điện thoại
  void ngungKinhDoanh(String maDienThoai) {
    var dienThoai = _danhSachDienThoai.firstWhere(
      (dt) => dt.maDT == maDienThoai,
      orElse: () =>
          throw Exception("Không tìm thấy điện thoại với mã $maDienThoai"),
    );
    dienThoai.trangThai = false;
    print("Điện thoại mã $maDienThoai đã ngừng kinh doanh.");
  }

  // Tìm kiếm điện thoại
  List<DienThoai> timKiemDienThoai({String? ma, String? ten, String? hang}) {
    return _danhSachDienThoai.where((dt) {
      return (ma != null && dt.maDT.contains(ma)) ||
          (ten != null && dt.tenDT.toLowerCase().contains(ten.toLowerCase())) ||
          (hang != null &&
              dt.hangSanXuat.toLowerCase().contains(hang.toLowerCase()));
    }).toList();
  }

  // Hiển thị danh sách điện thoại
  void hienThiDanhSachDienThoai() {
    print("\n----------------- Danh Sách Điện Thoại ----------------\n");
    if (_danhSachDienThoai.isEmpty) {
      print("Không có sản phẩm nào.");
    } else {
      for (var dt in _danhSachDienThoai) {
        print(
            "Mã: ${dt.maDT}, Tên: ${dt.tenDT}, Hãng: ${dt.hangSanXuat}, Giá bán: ${dt.giaBan}, Số lượng: ${dt.soLuongTonKho}, Trạng thái: ${dt.trangThai ? 'Còn kinh doanh' : 'Ngừng kinh doanh'}");
      }
    }
  }

  // Các phương thức quản lý hóa đơn
  // Tạo hóa đơn
  void taoHoaDon(String maHD, DateTime ngayBan, String maDT, int soLuongMua,
      double giaBanThucTe, String tenKH, String soDienThoaiKH) {
    // Tìm điện thoại theo mã điện thoại
    var dt = _danhSachDienThoai.firstWhere(
      (dt) => dt.maDT == maDT,
      orElse: () => throw Exception("Không tìm thấy điện thoại mã $maDT"),
    );
    // Kiểm tra điều kiện kinh doanh và tồn kho
    if (!dt.coTheBan()) {
      throw Exception(
          "Điện thoại mã $maDT không thể bán (hết hàng hoặc ngừng kinh doanh).");
    }
    if (soLuongMua > dt.soLuongTonKho) {
      throw Exception("Số lượng mua vượt quá tồn kho.");
    }
    if (ngayBan.isBefore(DateTime.now())) {
      throw Exception("Ngày bán phải là ngày hiện tại hoặc trong tương lai.");
    }
    // Tạo hóa đơn mới
    var hoaDon =
        HoaDon(maHD, dt, soLuongMua, giaBanThucTe, tenKH, soDienThoaiKH);
    // Thêm hóa đơn vào danh sách hóa đơn
    _danhSachHoaDon.add(hoaDon);
    // Cập nhật số lượng tồn kho của điện thoại
    dt.soLuongTonKho -= soLuongMua;
    print("Hóa đơn mã $maHD đã được tạo.");
  }

  // Tìm kiếm hóa đơn
  List<HoaDon> timKiemHoaDon({String? maHD, DateTime? ngayBan, String? tenKH}) {
    return _danhSachHoaDon.where((hoaDon) {
      var matchMaHD = maHD == null || hoaDon.maHD == maHD;
      var matchNgayBan = ngayBan == null || hoaDon.ngayBan == ngayBan;
      var matchTenKH = tenKH == null ||
          hoaDon.tenKH.toLowerCase().contains(tenKH.toLowerCase());
      return matchMaHD && matchNgayBan && matchTenKH;
    }).toList();
  }

  // Hiển thị danh sách hóa đơn
  void hienThiDanhSachHoaDon() {
    if (_danhSachHoaDon.isEmpty) {
      print("Không có hóa đơn nào.");
      return;
    }
    print("\n------------------ Danh Sách Hóa Đơn ------------------\n");
    for (var hoaDon in _danhSachHoaDon) {
      print(
        "Mã: ${hoaDon.maHD}, Ngày: ${hoaDon.ngayBan.toString()}, "
        "Khách hàng: ${hoaDon.tenKH}, Số điện thoại: ${hoaDon.soDienThoaiKH}, "
        "Điện thoại: ${hoaDon.dienThoaiDuocBan.tenDT}, "
        "Số lượng: ${hoaDon.soLuongMua}, Giá bán thực tế: ${hoaDon.giaBanThucTe}, "
        "Tổng tiền: ${hoaDon.tinhTongTien()}",
      );
    }
  }

  // Các phương thức thống kê
  // Tính tổng doanh thu theo khoảng thời gian
  double tinhTongDoanhThu(DateTime? ngayBatDau, DateTime? ngayKetThuc) {
    if (ngayBatDau == null || ngayKetThuc == null) {
      return 0;
    }
    return _danhSachHoaDon
        .where((hoaDon) =>
            hoaDon.ngayBan.isAfter(ngayBatDau) ||
            hoaDon.ngayBan.isAtSameMomentAs(ngayBatDau) &&
                (hoaDon.ngayBan.isBefore(ngayKetThuc) ||
                    hoaDon.ngayBan.isAtSameMomentAs(ngayKetThuc)))
        .fold(0, (tong, hoaDon) => tong + hoaDon.tinhTongTien());
  }

  // Tính tổng lợi nhuận theo khoảng thời gian
  double tinhTongLoiNhuan(DateTime? ngayBatDau, DateTime? ngayKetThuc) {
    if (ngayBatDau == null || ngayKetThuc == null) {
      return 0;
    }
    return _danhSachHoaDon
        .where((hoaDon) =>
            hoaDon.ngayBan.isAfter(ngayBatDau) ||
            hoaDon.ngayBan.isAtSameMomentAs(ngayBatDau) &&
                (hoaDon.ngayBan.isBefore(ngayKetThuc) ||
                    hoaDon.ngayBan.isAtSameMomentAs(ngayKetThuc)))
        .fold(0, (tong, hoaDon) => tong + hoaDon.tinhLoiNhuanThucTe());
  }

  // Thống kê top điện thoại bán chạy
  List<Map<String, dynamic>> thongKeDienThoaiBanChay(int top) {
    var soLuongBanTheoMa = <String, int>{};
    // Tính tổng số lượng bán của từng mã điện thoại
    for (var hoaDon in _danhSachHoaDon) {
      var maDT = hoaDon.dienThoaiDuocBan.maDT;
      soLuongBanTheoMa[maDT] =
          (soLuongBanTheoMa[maDT] ?? 0) + hoaDon.soLuongMua;
    }
    // Lấy danh sách điện thoại bán chạy, sắp xếp theo số lượng giảm dần
    var danhSachBanChay = soLuongBanTheoMa.entries.map((entry) {
      var dt = _danhSachDienThoai.firstWhere(
        (dt) => dt.maDT == entry.key,
        orElse: () => throw Exception('Không tìm thấy điện thoại ${entry.key}'),
      );
      return {
        'maDT': dt.maDT,
        'tenDT': dt.tenDT,
        'soLuongBan': entry.value,
      };
    }).toList();
    danhSachBanChay.sort((a, b) {
      return (b["soLuongBan"] as int).compareTo(a["soLuongBan"] as int);
    });
    return danhSachBanChay.take(top).toList();
  }

  // Thống kê tồn kho
  List<Map<String, dynamic>> thongKeTonKho() {
    return _danhSachDienThoai.map((dt) {
      return {
        "maDT": dt.maDT,
        "tenDT": dt.tenDT,
        "soLuongTonKho": dt.soLuongTonKho,
      };
    }).toList();
  }
}
