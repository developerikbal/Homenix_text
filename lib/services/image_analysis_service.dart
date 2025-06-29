// File: lib/services/image_analysis_service.dart

import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:homeonix/utils/pdf_to_text.dart';
import 'package:homeonix/utils/ocr_parser.dart';
import 'package:homeonix/logic/symptom_matcher.dart';
import 'package:homeonix/logic/remedy_analyzer.dart';
import 'package:homeonix/models/remedy_model.dart';

class ImageAnalysisService {
  final textRecognizer = GoogleMlKit.vision.textRecognizer();

  // Extract text from an image using OCR
  Future<String> extractTextFromImage(File imageFile) async {
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
      return recognizedText.text;
    } catch (e) {
      print('Error extracting text from image: $e');
      return '';
    }
  }

  // Convert a PDF file into plain text
  Future<String> extractTextFromPdf(File pdfFile) async {
    try {
      return await PdfToText.convert(pdfFile);
    } catch (e) {
      print('Error extracting text from PDF: $e');
      return '';
    }
  }

  // Analyze extracted text and return a list of matched symptoms
  List<String> analyzeSymptomsFromText(String text) {
    return SymptomMatcher.match(text);
  }

  // Suggest possible remedies based on matched symptoms
  List<Remedy> findRemediesFromSymptoms(List<String> symptoms) {
    return RemedyAnalyzer.suggest(symptoms);
  }

  // Complete pipeline: Image -> Text -> Symptoms -> Remedies
  Future<List<Remedy>> analyzeImageAndSuggestRemedies(File imageFile) async {
    final extractedText = await extractTextFromImage(imageFile);
    final symptoms = analyzeSymptomsFromText(extractedText);
    return findRemediesFromSymptoms(symptoms);
  }

  // Complete pipeline: PDF -> Text -> Symptoms -> Remedies
  Future<List<Remedy>> analyzePdfAndSuggestRemedies(File pdfFile) async {
    final extractedText = await extractTextFromPdf(pdfFile);
    final symptoms = analyzeSymptomsFromText(extractedText);
    return findRemediesFromSymptoms(symptoms);
  }

  void dispose() {
    textRecognizer.close();
  }
}