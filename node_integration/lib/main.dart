import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(List<String> args) {
  runApp(const MaterialApp(
    home: BooksScreen(),
  ));
}

class Book {
  final int id;
  final String title;
  final String author;
  Book({required this.id, required this.title, required this.author});
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
    );
  }
}

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  List<Book> _books = [];
  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/books'));
    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);
      setState(() {
        _books = json.map((item) => Book.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to load books');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
      ),
      body: ListView.builder(
        itemCount: _books.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_books[index].title),
            subtitle: Text(_books[index].author),
          );
        },
      ),
    );
  }
}
