class Libromodel {
  final int? id;
  final String title;
  final String author;
  final String genre;
  final int status;
  final String date;
  
  Libromodel({
    this.id, 
    required this.title, 
    required this.author, 
    required this.genre, 
    required this.status, 
    required this.date
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'genre': genre,
      'status': status,
      'date': date, // 注意：这里要跟数据库列名一致
    };
  }

  // 2. 从 Map 转成对象 (用于从 SQLite 读取)
  factory Libromodel.fromMap(Map<String, dynamic> map) {
    return Libromodel(
      id: map['id'],
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      genre: map['genre'] ?? '',
      status: map['status'] ?? 0,
      date: map['date'] ?? '', // 防止 null
    );
  }
}