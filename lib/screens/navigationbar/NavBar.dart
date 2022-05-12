import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'NavBarItem.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<bool> selected = [true, false, false, false, false, false, false];

  void select(int n) {
    for (int i = 0; i < n; i++) {
      if (n == i) {
        selected[i] = true;
      } else {
        selected[i] = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      color: Colors.white,
      child: Column(
        children: [
          Image.asset(
            'assets/images/logodemo.png',
            width: 100,
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            children: [
              NavBarItem(
                icon: 'assets/icons/17079.svg',
                title: 'Quản lí người dùng',
                active: selected[0],
                touched: () {
                  setState(() {
                    select(0);
                    // return navigation[0];
                  });
                },
              ),
              NavBarItem(
                icon: 'assets/icons/17078.svg',
                title: 'Quản lí dịch vụ',
                active: selected[1],
                touched: () {
                  setState(() {
                    select(1);
                    // return navigation[1];
                  });
                },
              ),
              NavBarItem(
                icon: 'assets/icons/17077.svg',
                title: 'Quản lí đặt hàng',
                active: selected[2],
                touched: () {
                  setState(() {
                    select(2);
                    // return navigation[2];
                  });
                },
              ),
              NavBarItem(
                title: 'Quản lí thông báo đẩy',
                icon: 'assets/icons/17076.svg',
                active: selected[3],
                touched: () {
                  setState(() {
                    select(3);
                    // return navigation[3];
                  });
                },
              ),
              NavBarItem(
                icon: 'assets/icons/17075.svg',
                title: 'Quản lí thanh toán',
                active: selected[4],
                touched: () {
                  setState(() {
                    select(4);
                    // return navigation[4];
                  });
                },
              ),
              NavBarItem(
                icon: 'assets/icons/17073.svg',
                title: 'Cài đặt',
                active: selected[5],
                touched: () {
                  setState(() {
                    select(5);
                    // return navigation[5];
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
