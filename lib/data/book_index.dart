// Contains mapping and index information of integrated homeopathic books.
// Used to reference translated rubrics, raw PDFs, and source attribution.

final List<BookIndex> bookIndexList = [
  const BookIndex(
    id: 'k_boenninghausen',
    title: 'Boenninghausen’s Therapeutic Pocket Book',
    author: 'C.M.F. Boenninghausen',
    language: 'English',
    version: '1.0',
    source: 'internal',
    translated: true,
    filePath: 'assets/books/translated_json/boenninghausen.json',
  ),
  const BookIndex(
    id: 'k_lippe_keynotes',
    title: 'Keynotes of the Homoeopathic Materia Medica',
    author: 'Dr. Adolph von Lippe',
    language: 'English',
    version: '1.1',
    source: 'internal',
    translated: true,
    filePath: 'assets/books/translated_json/lippe_keynotes.json',
  ),
  const BookIndex(
    id: 'k_f_master_bedside',
    title: 'Bedside Clinical Prescribing',
    author: 'Dr. Farokh Master',
    language: 'Bengali',
    version: '1.0',
    source: 'internal',
    translated: true,
    filePath: 'assets/books/translated_json/f_master_bedside_bn.json',
  ),
  const BookIndex(
    id: 'raw_pdf_store',
    title: 'Unprocessed Books',
    author: 'Various',
    language: 'Mixed',
    version: '0.0',
    source: 'internal',
    translated: false,
    filePath: 'assets/books/raw_pdf/',
  ),
];

class BookIndex {
  final String id;
  final String title;
  final String author;
  final String language;
  final String version;
  final String source;
  final bool translated;
  final String filePath;

  const BookIndex({
    required this.id,
    required this.title,
    required this.author,
    required this.language,
    required this.version,
    required this.source,
    required this.translated,
    required this.filePath,
  });
}
