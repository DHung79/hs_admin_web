import 'package:flutter/material.dart';

class ListItems extends StatelessWidget {
  const ListItems(BuildContext context, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            InkWell(
              onTap: () {
               
              },
              child: Container(
                height: 50,
                color: Colors.amber[100],
                child: const Center(child: Text('Entry A')),
              ),
            ),
            const Divider(),
            Container(
              height: 50,
              color: Colors.amber[200],
              child: const Center(child: Text('Entry B')),
            ),
            const Divider(),
            Container(
              height: 50,
              color: Colors.amber[300],
              child: const Center(child: Text('Entry C')),
            ),
          ],
        ),
      ),
    );
  }
}

