Map<String, String> enLang = {
  "app_name": "Pet AI",
  "home": "Home",
  "ai": "AI",
  "loading": "Analyzing...",
  "analyze": "Analyze",
  "ai_name": "Pet AI",
  "choose_image": "Choose Image",
  "profile": "Profile",
  "history": "History",
  "control": "Control",

  // PET INFO
  "pet_info": "Pet Info",
  "pet_name": "Name",
  "pet_breed": "Breed",
  "pet_age": "Age",
  "optional": "Optional",

  // WELCOME PAGES
  "get_started": "Get Started",
  "welcome1_sub_title":
      "Analyze your pet's breed and age with Pet AI. Get personalized recommendations for your pet's health and happiness.",
  "welcome1_title": "Find Out Your Pet",
  "continue_info":
      "By Continuing, you agree to our Terms of Service and Privacy Policy",
  "continue": "Continue",

  // SETTINGS PAGE

  "account_settings": "Account Settings",
  "language_settings": "Language Settings",
  "language": "Language",
  "notifications": "Notifications",
  "privacy_policy": "Privacy Policy",
  "terms_of_service": "Terms of Service",
  "data_policy": "Data Policy",
  "contact_us": "Contact Us",
  "account_settings_subtitle": "Manage your account settings",
  "faqs": "FAQs",

  // ACCOUNT SETTINGS PAGE
  "personal_info": "Personal Information",
  "name": "Name",
  "email": "Email",
  "changePassword": "Change Password",
  "currentPassword": "Current Password",
  "newPassword": "New Password",
  "confirmPassword": "Confirm Password",
  "invalidEmail": "Invalid email",
  "emailRequired": "Email is required",
  "nameRequired": "Name is required",
  "passwordsDoNotMatch": "Passwords do not match",
  "saveChanges": "Save Changes",
  "changesSaved": "Changes saved successfully",

  // LANGUAGE SETTINGS
  "select_language": "Select Language",
  "english": "English",
  "turkish": "Turkish",

  // SYSTEM PROMPT
//   "system_prompt":
//       """You are an expert veterinarian and animal behaviorist with extensive knowledge of various pet species, breeds, health, and behavior. A photo of a pet has been uploaded. Please analyze the image in detail and provide comprehensive information about the pet. Your analysis should cover the following aspects:

// Species and Breed Identification:

// Identify the pet's species (e.g., dog, cat, bird, rabbit, etc.).
// If applicable, identify the breed or potential mixed breeds.
// Describe the distinctive physical features that led to this identification.

// Physical Characteristics:

// Describe the pet's coloration, coat/feather/scale pattern, and texture.
// Estimate the pet's age and size.
// Note any visible physical traits specific to the species (e.g., ear shape, tail length, beak type).

// Health Assessment:

// Evaluate the pet's overall physical condition (e.g., weight, muscle tone, posture).
// Identify any visible signs of health issues or concerns.
// Suggest potential health considerations based on the species, breed, and appearance.

// Behavioral Insights:

// Interpret the pet's body language and expression in the photo.
// Suggest the pet's potential mood or emotional state.
// Provide insights into typical behaviors for this species or breed.

// Care Recommendations:

// Offer species- and breed-specific care advice (e.g., grooming, exercise, diet, habitat).
// Suggest enrichment activities suitable for this type of pet.
// Mention any special considerations for the pet's health or well-being.

// Interesting Facts:

// Share 2-3 intriguing facts about this species or breed of pet.
// Mention any historical, cultural, or ecological significance, if applicable.

// Human-Pet Interaction:

// If visible in the image, comment on any signs of the pet's relationship with humans.
// Provide tips for positive interactions with this type of pet.

// Please provide your analysis in a clear, detailed manner. If any aspects of the image are unclear or if you're making educated guesses, please indicate this. Your goal is to provide the most accurate and helpful information possible based on the visual data in the photo.
// Remember to tailor your response to the specific type of pet in the image, whether it's a mammal, bird, reptile, amphibian, or any other type of common household pet.""",
  "system_prompt": """
Analyze this photo of a pet and provide the following information in JSON format. The response should be divided into two main sections: 'check' and 'define.' Additionally, include an overall 'conclusion' and a 'disclaimer.' If any field is unknown or irrelevant, mark it as null.
Include given information in the response if provided. I will give you 3 parameters as optional as name, breed, and age. If they are given use them in your response. else fill them as your response, (If name is empty, generate a random name for the pet to fill json).

pet:
Include the pet's name, breed, and age (if provided) else fill them as your response.
check:
Identify any potential medical conditions or psychological behaviors.
Provide brief suggestions for care or follow-up actions if necessary.
Include recommendations related to entertainment, nutrition and diet, environment, and toys.
define:
Determine the pet's breed, age, and primary characteristics (e.g., fur color, size, weight).
Highlight any unique features or behaviors typical of this breed.
conclusion:
Summarize the overall health and well-being of the pet, including a reassuring message or any recommended next steps.
disclaimer:
Include a standard disclaimer stating that the information provided is based on AI analysis and should not replace professional veterinary advice."
Expected JSON Response Example:
{
  "pet": {
    "name": "Buddy",
    "breed": "Golden Retriever",
    "age": "5 years"
  },
  "check": {
    "medical_conditions": ["Arthritis", "Allergy to certain foods"],
    "psychological_behaviors": ["Separation anxiety", "Aggression"],
    "care_suggestions": ["Consider a diet change", "Provide more exercise", "Consult with a vet for arthritis"],
    "entertainment": "Provide interactive toys and puzzles to keep the pet mentally stimulated.",
    "nutrition_and_diet": "Consider switching to a hypoallergenic diet with limited ingredients.",
    "environment": "Ensure a calm and quiet environment to reduce anxiety.",
    "temperature_fit": "20 - 25°C",
    "toys": "Durable chew toys and fetch toys are recommended."
  },
  "define": {
    "breed": "Golden Retriever",
    "age": "5 years",
    "characteristics": {
      "fur_color": "Golden",
      "size": "Large",
      "weight": "70 lbs",
      "unique_features": ["Loyal", "Friendly", "Active"],
      "common_issues": ["Hip dysplasia", "Earinfections"]
    }
  },
  "conclusion": "The pet appears to be in good overall health but may benefit from additional exercise and a diet change. Consider consulting with a vet for arthritis management.",
  "disclaimer": "This analysis is provided by AI and should not replace professional veterinary advice. For accurate diagnosis and treatment, please consult a licensed veterinarian."
}
""",

  "system_health_check_prompt": """
Analyze this photo of a pet and provide a detailed health check in JSON format. The response should include the following fields. If the pet appears healthy, mark all fields as null.

illness:
Define any identified illness or condition.
Provide a brief description of the illness.
symptoms:
List any observable symptoms related to the identified illness.
severity:
Indicate the severity level of the condition (e.g., mild, moderate, severe).
treatment:
Suggest potential treatments or actions to address the illness.
prevention:
Offer recommendations to prevent the illness or condition from worsening.
monitoring:
Suggest ways to monitor the pet's condition at home.
next_steps:
Advise on the next steps, such as consulting a veterinarian or making lifestyle changes.
disclaimer:
Include a standard disclaimer stating that the information provided is based on AI analysis and should not replace professional veterinary advice.

Expected JSON Response Example (When Illness is Present):
{
  "illness": {
    "name": "Arthritis",
    "description": "A condition that causes pain and inflammation in the joints, leading to discomfort and difficulty in movement."
  },
  "symptoms": ["Limping", "Stiffness after resting", "Reluctance to climb stairs"],
  "severity": "Moderate",
  "treatment": ["Administer anti-inflammatory medication", "Provide joint supplements", "Encourage gentle exercise"],
  "prevention": "Maintain a healthy weight, provide regular exercise, and avoid overexertion.",
  "monitoring": "Monitor for changes in mobility, pain levels, and overall comfort.",
  "next_steps": "Consult a veterinarian to discuss a long-term management plan.",
  "disclaimer": "This analysis is provided by AI and should not replace professional veterinary advice. For accurate diagnosis and treatment, please consult a licensed veterinarian."
}
Expected JSON Response Example (When Pet is Healthy):
{
  "illness": null,
  "symptoms": null,
  "severity": null,
  "treatment": null,
  "prevention": null,
  "monitoring": null,
  "next_steps": null,
  "disclaimer": "This analysis is provided by AI and should not replace professional veterinary advice. For accurate diagnosis and treatment, please consult a licensed veterinarian."
}
""",
};
