import 'package:flutter/material.dart';
import 'package:haytek/screens/list_screen.dart';

List<ExpansionPanel> _getExpansionPanels(List<ListItem> _items, context) {
  return _items.map<ExpansionPanel>((ListItem item) {
    return ExpansionPanel(
      headerBuilder: (BuildContext context, bool isExpanded) {
        return ListTile(
          title: Text(item.headerName),
        );
      },
      body: Column(
        children: [
          ListTile(
            title: Text(item.description),
          ),
          GestureDetector(
              onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListScreen(
                          products: List<String>.generate(
                              500, (i) => "Product List: $i"),
                        ),
                      ),
                    ),
                    // login(username: username, password: password),
                  },
              child: Text(
                "devamını görmek için tıklayınız...",
                style: TextStyle(color: Colors.blue),
              )),
        ],
      ),
      isExpanded: item.isExpanded,
    );
  }).toList();
}

void ope() {}

class MyExpansion extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyExpansion> {
  List<ListItem> _items = [
    ListItem(
      id: 1,
      headerName: 'Yüksek Verimli Hayvanlar',
      description: 'This is body of item number 1',
    ),
    ListItem(
      id: 2,
      headerName: 'Düşük Verimli Hayvanlar',
      description: 'This is body of item number 2',
    ),
    ListItem(
      id: 3,
      headerName: 'Anomali Görülen Hayvanlar',
      description: 'This is body of item number 3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        animationDuration: Duration(milliseconds: 1000),
        children: _getExpansionPanels(_items, context),
        expansionCallback: (panelIndex, isExpanded) {
          _items[panelIndex].isExpanded = !isExpanded;
          setState(() {});
        },
      ),
    );
  }
}

class ListItem {
  int id;
  String headerName;
  String description;
  bool isExpanded;

  ListItem({
    required this.id,
    required this.headerName,
    required this.description,
    this.isExpanded = false,
  });
}


  // void animal_list_query() async {
  //   List<String> list = [];
  //   var url = Uri.parse("http://10.220.62.48/mail/query.php");
  //   var data = {'farm_id': "1"};
  //   var response = await http.post(url, body: data);

  //   if (response.statusCode == 200) {
  //     List datauser = json.decode(response.body);

  //     datauser.forEach((e) {
  //       list.add(e["animal_id"].toString());
  //     });
  //     setState(() {
  //       animal_list_items = list;
  //     });
  //   } else {
  //     print('A network error occurred : (animal_list_query)');
  //   }
  // }