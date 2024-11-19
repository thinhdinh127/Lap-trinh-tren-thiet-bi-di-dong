import '../models/sach.dart';
import '../models/docgia.dart';
import '../models/thuvien.dart';

void main() {
  Sach sach1 = Sach("S001", "Dart Programming", "Nguyễn Văn A", false);
  Sach sach2 = Sach("S002", "Flutter Basics", "Trần Văn B", false);
  Sach sach3 = Sach("S003", "Mobile Development", "Lê Thị C", false);

  // Tạo độc giả
  DocGia docGia1 = DocGia("DG001", "Nguyễn Văn D");
  DocGia docGia2 = DocGia("DG002", "Trần Thị E");

  // Tạo thư viện và thêm sách, độc giả
  ThuVien thuVien = ThuVien();
  thuVien.themSach(sach1);
  thuVien.themSach(sach2);
  thuVien.themSach(sach3);
  thuVien.themDocGia(docGia1);
  thuVien.themDocGia(docGia2);

  // Hiển thị danh sách sách
  thuVien.hienThiDanhSachSach();

  // Độc giả mượn sách
  docGia1.muonSach(sach1);
  docGia1.muonSach(sach2);
  docGia2.muonSach(sach1); // Sách đã được mượn

  // Hiển thị danh sách sách sau khi mượn
  thuVien.hienThiDanhSachSach();

  // Độc giả trả sách
  docGia1.traSach(sach1);

  // Hiển thị danh sách sách sau khi trả
  thuVien.hienThiDanhSachSach();
}
