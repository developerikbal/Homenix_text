import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeonix/services/book_service.dart';
import 'package:homeonix/widgets/custom_textfield.dart';
import 'package:homeonix/widgets/common_button.dart';

class BookTranslatorScreen extends StatefulWidget {
  final String bookId;

  const BookTranslatorScreen({Key? key, required this.bookId}) : super(key: key);

  @override
  _BookTranslatorScreenState createState() => _BookTranslatorScreenState();
}

class _BookTranslatorScreenState extends State<BookTranslatorScreen> {
  final _originalTextController = TextEditingController();
  final _translatedTextController = TextEditingController();

  bool _isLoading = true;
  String _statusMessage = '';
  
  @override
  void initState() {
    super.initState();
    _loadBookData();
  }

  Future<void> _loadBookData() async {
    setState(() => _isLoading = true);
    try {
      final book = await BookService().getBookById(widget.bookId);
      _originalTextController.text = book.originalText ?? 'No original text found.';
      _translatedTextController.text = book.translatedText ?? '';
    } catch (e) {
      _statusMessage = 'Error loading book: ${e.toString()}';
    }
    setState(() => _isLoading = false);
  }

  Future<void> _saveTranslation() async {
    try {
      await BookService().updateBookTranslation(
        widget.bookId,
        _translatedTextController.text.trim(),
      );
      Get.snackbar('Success', 'Translation saved successfully.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save translation: ${e.toString()}');
    }
  }

  @override
  void dispose() {
    _originalTextController.dispose();
    _translatedTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Translator'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text("Original Text", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _originalTextController,
                    hintText: 'Original PDF extracted content',
                    maxLines: 10,
                    readOnly: true,
                  ),
                  const SizedBox(height: 16),
                  Text("Translated Text (Bengali)", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _translatedTextController,
                    hintText: 'Write translation here...',
                    maxLines: 10,
                  ),
                  const SizedBox(height: 20),
                  CommonButton(
                    label: 'Save Translation',
                    onPressed: _saveTranslation,
                  ),
                  if (_statusMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(_statusMessage, style: TextStyle(color: Colors.red)),
                    ),
                ],
              ),
            ),
    );
  }
}
