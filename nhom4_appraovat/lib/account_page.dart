
import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:nhom4_appraovat/account_setting_page.dart';
import 'package:nhom4_appraovat/dang_don_ban.dart';
import 'package:nhom4_appraovat/login_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

Map<String, List> _elements = {
  'Quản lý đơn hàng': ['Đơn mua', 'Đơn bán'],
  'khác': ['Cài đặt tài khoản', 'Đăng xuất'],
};

class AccountPage extends StatefulWidget {
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late SharedPreferences logindata;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
  }

  Widget _itemBuilder(BuildContext context, IndexPath index) {
    String item = _elements.values.toList()[index.section][index.index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 8,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10.0),
          title: Text(
            item,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          trailing: item == 'Cài đặt tài khoản'
              ? IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AccountSettingsPage()));
                  },
                )
              : item == 'Đăng xuất'
                  ? IconButton(
                      icon: const Icon(Icons.exit_to_app),
                      onPressed: () {
                        logindata.setBool('login', false);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                      },
                    )
                  : const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }

  Widget _item(VoidCallbackAction oncallback, String label) {
    return Card(
      child: Text(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Tài khoản',
            style: TextStyle(fontSize: 22),
          ),
          centerTitle: true, // Center-align the title
          backgroundColor: const Color.fromARGB(254, 255, 170, 0),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Align(alignment: Alignment.centerLeft, child: Text('Quản lý đơn hàng', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white, // Màu nền của Container
                    borderRadius: BorderRadius.circular(4), // Độ cong của viền Container (tùy chọn)
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey, // Màu đổ bóng
                        offset: Offset(0, 2), // Độ dịch chuyển đổ bóng theo trục X và Y
                        blurRadius: 6, // Độ mờ của đổ bóng
                        spreadRadius: 2, // Độ lan truyền của đổ bóng
                      )
                    ],
                  ),
                  child: const Text(
                    'Đơn mua',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white, // Màu nền của Container
                    borderRadius: BorderRadius.circular(4), // Độ cong của viền Container (tùy chọn)
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey, // Màu đổ bóng
                        offset: Offset(0, 2), // Độ dịch chuyển đổ bóng theo trục X và Y
                        blurRadius: 6, // Độ mờ của đổ bóng
                        spreadRadius: 2, // Độ lan truyền của đổ bóng
                      )
                    ],
                  ),
                  child: const Text(
                    'Đơn bán',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white, // Màu nền của Container
                      borderRadius: BorderRadius.circular(4), // Độ cong của viền Container (tùy chọn)
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey, // Màu đổ bóng
                          offset: Offset(0, 2), // Độ dịch chuyển đổ bóng theo trục X và Y
                          blurRadius: 6, // Độ mờ của đổ bóng
                          spreadRadius: 2, // Độ lan truyền của đổ bóng
                        )
                      ],
                    ),
                    child: const Text(
                      'Đăng đơn bán',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Dang_don_ban()));
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                const Align(alignment: Alignment.centerLeft, child: Text('Quản lý tài khoản', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white, // Màu nền của Container
                      borderRadius: BorderRadius.circular(4), // Độ cong của viền Container (tùy chọn)
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey, // Màu đổ bóng
                          offset: Offset(0, 2), // Độ dịch chuyển đổ bóng theo trục X và Y
                          blurRadius: 6, // Độ mờ của đổ bóng
                          spreadRadius: 2, // Độ lan truyền của đổ bóng
                        )
                      ],
                    ),
                    child: const Text(
                      'Cài đặt tài khoản',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AccountSettingsPage()));
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white, // Màu nền của Container
                      borderRadius: BorderRadius.circular(4), // Độ cong của viền Container (tùy chọn)
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey, // Màu đổ bóng
                          offset: Offset(0, 2), // Độ dịch chuyển đổ bóng theo trục X và Y
                          blurRadius: 6, // Độ mờ của đổ bóng
                          spreadRadius: 2, // Độ lan truyền của đổ bóng
                        )
                      ],
                    ),
                    child: const Text(
                      'Đăng xuất',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  onTap: (){
                    logindata.setBool('login', false);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
