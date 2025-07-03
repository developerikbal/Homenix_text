// Developer Panel > Book Metadata Editor UI + Responsive Logic

// Path: lib/developer/book_metadata_editor.dart



import 'package:flutter/material.dart';

import 'package:homeonix/models/book_model.dart';

import 'package:homeonix/widgets/custom_textfield.dart';

import 'package:homeonix/services/book_service.dart';



class BookMetadataEditor extends StatefulWidget {

  final BookModel book;



  const BookMetadataEditor({Key? key, required this.book}) : super(key: key);



  @override

  State<BookMetadataEditor> createState() => _BookMetadataEditorState();

}



class _BookMetadataEditorState extends State<BookMetadataEditor> {

  late final TextEditingController _titleController;

  late final TextEditingController _authorController;

  late final TextEditingController _languageController;

  late final TextEditingController _categoryController;



  bool _isSaving = false;



  @override

  void initState() {

    super.initState();

    _titleController = TextEditingController(text: widget.book.title);

    _authorController = TextEditingController(text: widget.book.author);

    _languageController = TextEditingController(text: widget.book.language);

    _categoryController = TextEditingController(text: widget.book.category);

  }



  @override

  void dispose() {

    _titleController.dispose();

    _authorController.dispose();

    _languageController.dispose();

    _categoryController.dispose();

    super.dispose();

  }



  Future<void> _saveMetadata() async {

    final title = _titleController.text.trim();

    final author = _authorController.text.trim();

    final language = _languageController.text.trim();

    final category = _categoryController.text.trim();



    if (title.isEmpty || author.isEmpty || language.isEmpty || category.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text('All fields are required.'),

          backgroundColor: Colors.red,

        ),

      );

      return;

    }



    setState(() => _isSaving = true);



    final updatedBook = widget.book.copyWith(

      title: title,

      author: author,

      language: language,

      category: category,

    );



    final success = await BookService().updateBookMetadata(updatedBook);



    setState(() => _isSaving = false);



    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(

        content: Text(success ? 'Metadata saved successfully.' : 'Failed to save metadata.'),

        backgroundColor: success ? Colors.green : Colors.red,

      ),

    );



    if (success) {

      Navigator.pop(context);

    }

  }



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text('Edit Book Metadata'),

      ),

      body: LayoutBuilder(

        builder: (context, constraints) {

          return SingleChildScrollView(

            padding: const EdgeInsets.all(16.0),

            child: Center(

              child: ConstrainedBox(

                constraints: BoxConstraints(

                  maxWidth: constraints.maxWidth > 600 ? 500 : double.infinity,

                ),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: [

                    CustomTextField(

                      controller: _titleController,

                      label: 'Title',

                      hint: 'Enter book title',

                    ),

                    const SizedBox(height: 12),

                    CustomTextField(

                      controller: _authorController,

                      label: 'Author',

                      hint: 'Enter author name',

                    ),

                    const SizedBox(height: 12),

                    CustomTextField(

                      controller: _languageController,

                      label: 'Language',

                      hint: 'e.g., English / Bengali',

                    ),

                    const SizedBox(height: 12),

                    CustomTextField(

                      controller: _categoryController,

                      label: 'Category',

                      hint: 'e.g., Materia Medica',

                    ),

                    const SizedBox(height: 24),

                    _isSaving

                        ? const Center(child: CircularProgressIndicator())

                        : ElevatedButton.icon(

                            onPressed: _saveMetadata,

                            icon: const Icon(Icons.save),

                            label: const Text('Save Metadata'),

                            style: ElevatedButton.styleFrom(

                              padding: const EdgeInsets.symmetric(vertical: 14),

                            ),

                          ),

                  ],

                ),

              ),

            ),

          );

        },

      ),

    );

  }

}
