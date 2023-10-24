import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Vay {
  String tenKhachHang;
  double soTienVay;
  double laiSuat;
  int soThangVay;

  Vay({
    required this.tenKhachHang,
    required this.soTienVay,
    required this.laiSuat,
    required this.soThangVay,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TinhLaiSuatApp(),
    );
  }
}

class TinhLaiSuatApp extends StatefulWidget {
  @override
  _TinhLaiSuatAppState createState() => _TinhLaiSuatAppState();
}

class _TinhLaiSuatAppState extends State<TinhLaiSuatApp> {
  final TextEditingController tenKhachHangController = TextEditingController();
  final TextEditingController soTienVayController = TextEditingController();
  double laiSuatLuaChon = 0.02;
  int soThangVayLuaChon = 12;

  final List<Vay> danhSachVay = [];

  void tinhLaiSuat() {
    String tenKhachHang = tenKhachHangController.text;
    double soTienVay = double.parse(soTienVayController.text);

    Vay vay = Vay(
      tenKhachHang: tenKhachHang,
      soTienVay: soTienVay,
      laiSuat: laiSuatLuaChon * 100,
      soThangVay: soThangVayLuaChon,
    );

    setState(() {
      danhSachVay.add(vay);
    });

    tenKhachHangController.clear();
    soTienVayController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tính lãi suất ngân hàng ABC'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                controller: tenKhachHangController,
                decoration: InputDecoration(icon: const Icon(Icons.person),labelText: 'Tên khách hàng:'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                controller: soTienVayController,
                decoration: InputDecoration(icon: const Icon(Icons.money),labelText: 'Số tiền vay (VND):'),
                keyboardType: TextInputType.number,
              ),
            ),

            Text('Lãi tháng (%):'),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: DropdownButton<double>(
                value: laiSuatLuaChon,
                items: List.generate(9, (index) {
                  double laiSuat = 0.02 + (index * 0.01);
                  return DropdownMenuItem<double>(
                    value: laiSuat,
                    child: Text('${(laiSuat * 100).toStringAsFixed(0)}%'),
                  );
                }),
                onChanged: (value) {
                  setState(() {
                    laiSuatLuaChon = value!;
                  });
                },
              ),
            ),
            Text('Chọn tháng:'),

            Row(
              children: [
                Radio(
                  value: 12,
                  groupValue: soThangVayLuaChon,
                  onChanged: (value) {
                    setState(() {
                      soThangVayLuaChon = value as int;
                    });
                  },
                ),
                SizedBox(width: 8.0),
                Text('12 tháng'),
                Radio(
                  value: 24,
                  groupValue: soThangVayLuaChon,
                  onChanged: (value) {
                    setState(() {
                      soThangVayLuaChon = value as int;
                    });
                  },
                ),
                SizedBox(width: 8.0),
                Text('24 tháng'),
                Radio(
                  value: 36,
                  groupValue: soThangVayLuaChon,
                  onChanged: (value) {
                    setState(() {
                      soThangVayLuaChon = value as int;
                    });
                  },
                ),
                SizedBox(width: 8.0),
                Text('36 tháng'),
              ],
            ),
            ElevatedButton.icon(
              onPressed: tinhLaiSuat,
              icon: Icon(Icons.calculate),
              label: Text('Tính lãi suất'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: danhSachVay.length,
                itemBuilder: (context, index) {
                  Vay vay = danhSachVay[index];
                  double tienTraHangThang = (vay.soTienVay / vay.soThangVay) * vay.laiSuat;
                  return ListTile(
                    title: Text('${vay.tenKhachHang}'),
                    subtitle: Text('Số tiền vay: ${vay.soTienVay} VND\nSố tháng vay: ${vay.soThangVay}'),
                    trailing: Text('Số tiền trả (mỗi tháng): ${tienTraHangThang.toStringAsFixed(2)} VND'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
