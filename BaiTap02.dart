// BaiTap02.dart
// Giai pt bac 2:ax^2+bx+c=0;
import 'dart:io';
import 'dart:math';

void main(){
double a, b, c;

  // Nhập hệ số a (a khác 0)
  do {
    stdout.write('Nhập hệ số a (a khác 0): ');
    String? input = stdin.readLineSync();
    try {
      a = double.parse(input ?? '0'); // Dùng ?? để thay thế null bằng '0'
      if (a == 0) {
        print('Hệ số a phải khác 0. Vui lòng nhập lại.');
      }
    } catch (e) {
      print('Hãy nhập số !');
      a = 0; // Đặt giá trị để vòng lặp tiếp tục
    }
  } while (a == 0);

  // Nhập hệ số b
  while (true) {
    stdout.write('Nhập hệ số b: ');
    String? input = stdin.readLineSync();
    try {
      b = double.parse(input ?? '0'); // Dùng ?? để thay thế null bằng '0'
      break; // Thoát khỏi vòng lặp nếu b là số hợp lệ
    } catch (e) {
      print('Hãy nhập số !');
    }
  }

  // Nhập hệ số c
  while (true) {
    stdout.write('Nhập hệ số c: ');
    String? input = stdin.readLineSync();
    try {
      c = double.parse(input ?? '0'); // Dùng ?? để thay thế null bằng '0'
      break; // Thoát khỏi vòng lặp nếu c là số hợp lệ
    } catch (e) {
      print('Hãy nhập số !');
    }
  }

  // In ra các hệ số a b và c
  print('Bạn đã nhập các hệ số: a = $a, b = $b, c = $c');
  // Công thức giải phương trình bậc 2
  double delta = b * b - 4 * a * c;
  print('Delta = $delta');

  if (delta < 0) {
    // Trường hợp delta < 0: Phương trình vô nghiệm
    print('Phương trình vô nghiệm.'); 
  } else if (delta == 0) {
    // Trường hợp delta = 0: Phương trình có nghiệm kép
    double x = -b / (2 * a);
    print('Phương trình có nghiệm kép: x = $x');
  } else {
     // Trường hợp delta > 0: Phương trình có hai nghiệm phân biệt
    double x1 = (-b + sqrt(delta)) / (2 * a);
    double x2 = (-b - sqrt(delta)) / (2 * a);
    print('Phương trình có hai nghiệm phân biệt:');
    print('x1 = $x1');
    print('x2 = $x2');
  }
  
}