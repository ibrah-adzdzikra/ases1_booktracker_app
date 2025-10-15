import 'package:flutter/material.dart';

void main() {
  runApp(BookTrackerApp());
}

class BookTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Tracker App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BookListPage(),
    );
  }
}

class BookListPage extends StatefulWidget {
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  List<String> books = [];
  final TextEditingController _controller = TextEditingController();

  void _addBook() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambah Buku Baru'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Masukkan judul buku'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_controller.text.isNotEmpty) {
                    books.add(_controller.text);
                  }
                });
                _controller.clear();
                Navigator.pop(context);
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _deleteBook(int index) {
    setState(() {
      books.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Tracker App'),
        centerTitle: true,
      ),
      body: books.isEmpty
          ? Center(child: Text('Belum ada buku yang ditambahkan.'))
          : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(books[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteBook(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addBook,
        child: Icon(Icons.add),
      ),
    );
  }
}
