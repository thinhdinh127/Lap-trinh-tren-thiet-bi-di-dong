import '../models/cua_hang.dart';
import '../models/dien_thoai.dart';

class Test {
  void runTest() {
    // 0. Tạo cửa hàng
    var cuaHang =
        CuaHang("Cửa Hàng ThinggDinhTCG", "Linh Trung, Thành phố Hồ Chí Minh");
    print("\n--------------- Tạo Cửa Hàng Thành Công ---------------\n");
    print("Tên cửa hàng: ${cuaHang.tenCuaHang}");
    print("Địa chỉ     : ${cuaHang.diaChi}");
    print("\n-------------------------------------------------------\n");
    // 1. Tạo và quản lý thông tin điện thoại
    // 1.1 Thêm điện thoại mới
    cuaHang.themDienThoai(DienThoai("DT-001", "iPhone 11 Pro Max 1TB", "Apple",
        37500000, 46800000, 100, true));
    cuaHang.themDienThoai(DienThoai(
        "DT-002",
        "Xiaomi Mi 11T Lite",
        "Xiaomi",
        18000000,
        22000000,
        70,
        true));
    cuaHang.themDienThoai(DienThoai("DT-003", "Oppo Reno12",
        "Oppo ", 900000, 1200000, 50, true));
    cuaHang.hienThiDanhSachDienThoai();
    print("\n-------------------------------------------------------\n");
    // 1.2 Cập nhật thông tin
    cuaHang.capNhatDienThoai("DT-001",
        tenMoi: "iPhone 15 Pro",
        giaNhapMoi: 40000000,
        giaBanMoi: 48000000,
        trangThaiMoi: true);
    cuaHang.capNhatDienThoai("DT-002",
        tenMoi: "Samsung Galaxy Z Fold6 5G 12GB/1TB",
        giaNhapMoi: 47000000,
        giaBanMoi: 53000000,
        trangThaiMoi: true);
    cuaHang.hienThiDanhSachDienThoai();
    print("\n-------------------------------------------------------\n");
    // 1.3 Kiểm tra validation
    try {
      cuaHang.themDienThoai(
        DienThoai("DT-123", "Invalid Phone", "Brand", 10000, 2000, 5, true),
      );
    } catch (e) {
      print("Validation hoạt động: $e");
    }
    print("\n-------------------------------------------------------\n");
    // 2. Tạo và quản lý hóa đơn
    // 2.1 Tạo hóa đơn hợp lệ
    cuaHang.taoHoaDon("HD-001", DateTime.now(), "DT-001", 2, 48000000,
        "Nguyễn Văn Nhất", "01234567891");
    cuaHang.taoHoaDon("HD-002", DateTime.now(), "DT-001", 2, 48000000,
        "Nguyễn Văn Nhị", "01234567892");
    cuaHang.taoHoaDon("HD-003", DateTime.now(), "DT-002", 10, 48000000,
        "Nguyễn Văn Tam", "01234567893");
    cuaHang.hienThiDanhSachHoaDon();
    print("\n-------------------------------------------------------\n");
    // 2.2 Kiểm tra các ràng buộc (tồn kho, validation)
    try {
      cuaHang.taoHoaDon(
        "HD-002",
        DateTime.now(),
        "DT-001",
        200, // Số lượng vượt quá tồn kho
        42000,
        "Tran Van B",
        "0987654321",
      );
    } catch (e) {
      print("Ràng buộc tồn kho hoạt động: $e");
    }
    // 2.3 Tính toán tiền và lợi nhuận
    print("\n-------------------------------------------------------\n");
    var hd = cuaHang.timKiemHoaDon(maHD: "HD-003").first;
    print("Tổng tiền hóa đơn: ${hd.tinhTongTien()}");
    print("Lợi nhuận hóa đơn: ${hd.tinhLoiNhuanThucTe()}");
    print("\n-------------------------------------------------------\n");
    // 3. Thống kê báo cáo
    // 3.1 Doanh thu theo thời gian
    var doanhThu = cuaHang.tinhTongDoanhThu(
      DateTime(2024, 11, 15),
      DateTime(2024, 11, 20),
    );
    print("Tổng doanh thu từ 2024-11-15 đến 2024-11-20: $doanhThu");
    print("\n-------------------------------------------------------\n");
    // 3.2 Lợi nhuận theo thời gian
    var loiNhuan = cuaHang.tinhTongLoiNhuan(
      DateTime(2024, 11, 15),
      DateTime(2024, 11, 20),
    );
    print("Tổng lợi nhuận từ 2024-11-15 đến 2024-11-20: $loiNhuan");
    print("\n-------------------------------------------------------\n");
    // 3.3 Top bán chạy
    var topBanChay = cuaHang.thongKeDienThoaiBanChay(2);
    print("\n-------------- Top 2 Điện Thoại Bán Chạy --------------\n");
    for (var item in topBanChay) {
      print(
          "Mã: ${item['maDT']}, Tên: ${item['tenDT']}, Số lượng bán: ${item['soLuongBan']}");
    }
    print("\n-------------------------------------------------------\n");
    // 3.4 Báo cáo tồn kho
    var tonKho = cuaHang.thongKeTonKho();
    print("\n------------------- Báo Cáo Tồn Kho -------------------\n");
    for (var item in tonKho) {
      print(
          "Mã: ${item['maDT']}, Tên: ${item['tenDT']}, Số lượng tồn: ${item['soLuongTonKho']}");
    }
    print("\n-------------------------------------------------------\n");
  }
}

void main() {
  var test = Test();
  test.runTest();
}
