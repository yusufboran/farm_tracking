import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class ListScreen extends StatefulWidget {
  List items;
  String text;
  ListScreen({required this.items, required this.text});
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  HDTRefreshController _hdtRefreshController = HDTRefreshController();

  static const int sortAnimalId = 0;
  static const int sortConductivity = 1;
  static const int sortMilkQuantity = 2;
  static const int sortMovement = 3;
  bool isAscending = true;
  int sortType = sortAnimalId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.text),
      ),
      body: _getBodyWidget(),
    );
  }

  Widget _getBodyWidget() {
    return Container(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 100,
        rightHandSideColumnWidth: 300,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: widget.items.length,
        rowSeparatorWidget: const Divider(
          color: Colors.black54,
          height: 1.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
        verticalScrollbarStyle: const ScrollbarStyle(
          isAlwaysShown: true,
          thickness: 4.0,
          radius: Radius.circular(5.0),
        ),
        horizontalScrollbarStyle: const ScrollbarStyle(
          isAlwaysShown: true,
          thickness: 4.0,
          radius: Radius.circular(5.0),
        ),
        enablePullToRefresh: true,
        refreshIndicator: const WaterDropHeader(),
        refreshIndicatorHeight: 60,
        onRefresh: () async {
          //Do sth
          await Future.delayed(const Duration(milliseconds: 500));
          _hdtRefreshController.refreshCompleted();
        },
        enablePullToLoadNewData: true,
        loadIndicator: const ClassicFooter(),
        onLoad: () async {
          //Do sth
          await Future.delayed(const Duration(milliseconds: 500));
          _hdtRefreshController.loadComplete();
        },
        htdRefreshController: _hdtRefreshController,
      ),
      height: MediaQuery.of(context).size.height,
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            'Hayvan ID' +
                (sortType == sortAnimalId ? (isAscending ? '↓' : '↑') : ''),
            100),
        onPressed: () {
          animalSort(isAscending, widget.items);
          sortType = sortAnimalId;
          isAscending = !isAscending;
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            'İletkenlik' +
                (sortType == sortConductivity ? (isAscending ? '↓' : '↑') : ''),
            100),
        onPressed: () {
          sortType = sortConductivity;
          conductivitySort(isAscending, widget.items);
          isAscending = !isAscending;
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            'Süt Miktarı' +
                (sortType == sortMilkQuantity ? (isAscending ? '↓' : '↑') : ''),
            100),
        onPressed: () {
          sortType = sortMilkQuantity;
          milkQuantitySort(isAscending, widget.items);
          isAscending = !isAscending;
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            'Hareket' +
                (sortType == sortMovement ? (isAscending ? '↓' : '↑') : ''),
            100),
        onPressed: () {
          sortType = sortMovement;
          movementSort(isAscending, widget.items);
          isAscending = !isAscending;
          setState(() {});
        },
      ),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      width: 100,
      height: 56,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      child: myTextButton(widget.items[index].animalId),
      width: 100,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(widget.items[index].conductivity.toString()),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(widget.items[index].milk_quantity.toString()),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(widget.items[index].movement.toString()),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }

  void animalSort(isAscending, list) {
    list.sort((a, b) {
      int aValue = int.parse(a.animalId);
      int bValue = int.parse(b.animalId);
      return (aValue - bValue) * (isAscending ? 1 : -1);
    });
  }

  void conductivitySort(isAscending, list) {
    list.sort((a, b) {
      int aValue = (a.conductivity * 10).toInt();
      int bValue = (b.conductivity * 10).toInt();
      return (aValue - bValue) * (isAscending ? 1 : -1);
    });
  }

  void milkQuantitySort(isAscending, list) {
    list.sort((a, b) {
      int aValue = (a.milk_quantity * 10).toInt();
      int bValue = (b.milk_quantity * 10).toInt();
      return (aValue - bValue) * (isAscending ? 1 : -1);
    });
  }

  void movementSort(isAscending, list) {
    list.sort((a, b) {
      int aValue = a.movement;
      int bValue = b.movement;
      return (aValue - bValue) * (isAscending ? 1 : -1);
    });
  }

  myTextButton(value) {
    return TextButton(
      onPressed: () {
        print(value);
      },
      child: Text(
        value.toString(),
        style: Theme.of(context).textTheme.button,
      ),
    );
  }
}
