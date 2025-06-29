// File: lib/data/rubric_map.dart
// Description: Mapping of free-text or symptom keywords to structured rubrics

final Map<String, List<String>> rubricMap = {
  // Mind rubrics
  "irritability": ["Mind; IRRITABILITY"],
  "anger": ["Mind; ANGER"],
  "fear": ["Mind; FEAR"],
  "anxiety": ["Mind; ANXIETY"],
  "depression": ["Mind; SADNESS", "Mind; MELANCHOLY"],
  "confusion": ["Mind; CONFUSION of mind"],

  // Head rubrics
  "headache": ["Head; PAIN, headache"],
  "migraine": ["Head; PAIN, headache; Migraine"],
  "vertigo": ["Vertigo"],

  // Stomach and digestion
  "nausea": ["Stomach; NAUSEA"],
  "vomiting": ["Stomach; VOMITING"],
  "acidity": ["Stomach; ERUCTATIONS; Sour"],

  // Abdomen
  "gas": ["Abdomen; FLATULENCE"],
  "abdominal pain": ["Abdomen; PAIN"],

  // Chest
  "cough": ["Respiration; COUGH"],
  "shortness of breath": ["Respiration; DIFFICULT"],
  "chest pain": ["Chest; PAIN"],

  // Skin
  "itching": ["Skin; ITCHING"],
  "rash": ["Skin; ERUPTIONS"],
  "acne": ["Face; ERUPTIONS; Acne"],

  // General
  "fatigue": ["Generalities; WEAKNESS"],
  "fever": ["Fever"],
  "chills": ["Fever; CHILL"],
  "sweating": ["Fever; PERSPIRATION"],

  // Urinary
  "burning urination": ["Urine; BURNING"],
  "frequent urination": ["Urine; FREQUENT micturition"],

  // Female
  "menstrual pain": ["Female genitalia/sex; MENSES; Painful"],
  "irregular periods": ["Female genitalia/sex; MENSES; Irregular"],

  // Male
  "nightfall": ["Male genitalia/sex; EMISSIONS; Seminal"],
  "sexual weakness": ["Male genitalia/sex; WEAKNESS"],

  // Sleep
  "insomnia": ["Sleep; SLEEPLESSNESS"],
  "nightmare": ["Sleep; DREAMS; Frightful"],

  // Bones & joints
  "joint pain": ["Extremities; PAIN; Joints"],
  "back pain": ["Back; PAIN"],

  // Others
  "hair fall": ["Head; HAIR; Falling"],
  "eye pain": ["Eyes; PAIN"],
  "ear discharge": ["Ear; DISCHARGE"],
};