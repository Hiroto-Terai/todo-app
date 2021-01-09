import 'package:flutter/material.dart';

void main() {
  // 最初に表示するWidget
  runApp(MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 右上のデバッグを消す
      debugShowCheckedModeBanner: false,
      // アプリ名
      title: 'My Todo App',
      theme: ThemeData(
        // テーマカラー
        primarySwatch: Colors.green,
        // 視覚的な詰まり具合を調整
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  // Todoリストのデータ
  List<String> todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBarを表示し、タイトルも設定
      appBar: AppBar(
        title: Text('リスト一覧'),
      ),
      // メインコンテンツ
      // ListViewを使いリスト一覧を表示
      // データを元にListViewを作成
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(todoList[index]),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // pushで新規画面に遷移
          // リスト追加画面から渡される値を受け取る
          final newListText = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              // 遷移先の画面としてリスト追加画面を指定
              return TodoAddPage();
            }),
          );
          if (newListText != null) {
            // キャンセルした場合はnewListTextがnullになる
            setState(() {
              // リスト追加
              todoList.add(newListText);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TodoAddPage extends StatefulWidget {
  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {
  // 入力されたテキストをデータとして持つ
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト追加'),
      ),
      body: Container(
        // 余白をつける
        padding: EdgeInsets.all(64),
        child: Column(
          // 表示位置を調整
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 入力されたテキストを表示
            Text(_text, style: TextStyle(color: Colors.green)),
            // テキスト入力
            TextField(
              decoration: InputDecoration(
                labelText: "Resevior Name",
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 2.0),
                ),
              ),
              // 入力されたテキストの値を受け取る(valueが入力されたテキスト)
              onChanged: (String value) {
                // データが変更したことを知らせる(画面を更新する)
                setState(() {
                  // データを変更
                  _text = value;
                });
              },
            ),
            Container(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // リスト追加ボタン
              child: RaisedButton(
                color: Colors.green,
                onPressed: () {
                  // popで前の画面に戻る
                  // popの引数から前の画面にデータを渡す
                  Navigator.of(context).pop(_text);
                },
                child: Text('リスト追加', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // キャンセルボタン
              child: FlatButton(
                // ボタンをクリックした時の処理
                onPressed: () {
                  // popで前の画面に戻る
                  // popの引数から前の画面にデータを渡す
                  Navigator.of(context).pop();
                },
                child: Text('キャンセル'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
