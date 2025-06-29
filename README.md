# 🏥 Homeonix - AI Powered Homeopathic Assistant

**Homeonix** হলো একটি আধুনিক AI ভিত্তিক হোমিওপ্যাথিক সফটওয়্যার যা Android ও Windows এর জন্য তৈরি হয়েছে। এটি রোগীর লক্ষণ (Mind ও Physical) অনুযায়ী সঠিক হোমিওপ্যাথিক রেমেডি নির্বাচন করে, ছবি বা বই থেকে তথ্য বিশ্লেষণ করে এবং ডেভেলপারদের জন্য একটি শক্তিশালী কন্ট্রোল প্যানেল সহ আরও অনেক ফিচার নিয়ে এসেছে

## 🔧 Features

### 👤 General Features
- বাংলা ও ইংরেজি ভাষা সমর্থন
- লক্ষণ লিখে Remedy খোঁজা (Free Text Input: English & Bengali)
- Graphical Remedy Analysis (Bar Chart, Venn Diagram)
- Remedy Grading System
- Rubric Bookmark System
- Dark Mode & Theme Switcher
- Follow-up Reminder System
- Text to Remedy Suggestion Engine (without Internet)

### 📸 AI-Powered Detection
- Disease Photo Upload → OCR + Symptom Detection → Remedy Suggestion
- Voice Input → Symptom Extraction → Remedy Match
- QR Disease Scanner Support

### 🔐 User Authentication & Access
- Firebase Auth (Email/Phone) with Verification
- Trial Limitation per Device (no multiple email trials)
- Paid Plans: Monthly / Yearly / Lifetime
- Premium Feature Locking (with License Check)

### 🧑‍💻 Developer Panel (Only for developer Gmail access)
- Upload PDF books → Auto OCR, Translate, and Integrate
- Book Metadata Editor
- Uploaded File Manager
- Integration Log Viewer
- Real-time Database Update System
- Developer-only Feature Unlock

### 💳 Payment System
- Payment Gateway Integration (Bank / UPI / Razorpay etc.)
- Subscription Management
- Bank Account Entry from Developer Panel
- Invoice History and Premium Status Display

---

## 📁 Directory Structure (Simplified)
# Homeonix - Deployment Instructions

## ⚠️ Deployment Note
Ensure the following before deploying:
- ✅ `google-services.json` file is added under `android/app/`
- ✅ Firebase project configured with correct SHA-1 key
- ✅ `pubspec.yaml` contains all dependencies
- ✅ Android & Windows build tested with no Gradle errors
- ✅ Premium validation logic & trial blocker are working
- ✅ GitHub repo does not contain sensitive credentials

---

## 🙋‍♂️ Developer Contact

**Ikbal Hussain Barbhuiya**  
Flutter Developer & Homeopathic Practitioner  
📍 Hailakandi, Assam  
📧 frontendwebdeveloperikbal@gmail.com  
📱 WhatsApp: +91 86387 99119  
🌐 Feedback Form: [Click Here](https://forms.gle/your-feedback-form)
