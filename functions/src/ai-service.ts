import * as functions from "firebase-functions";
import { GoogleGenerativeAI } from "@google/generative-ai";

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || "");

export const analyzePet = functions.https.onCall(async (data) => {
  try {
    const { text, imageBase64 } = data;

    const systemPrompt = `Analyze this photo of a pet and provide the following information in JSON format. The response should be divided into two main sections: 'check' and 'define.' Additionally, include an overall 'conclusion' and a 'disclaimer.' If any field is unknown or irrelevant, mark it as null.
Include given information in the response if provided. I will give you 3 parameters as optional as name, breed, and age. If they are given use them in your response. else fill them as your response, (If name is empty, generate a random name for the pet to fill json).

pet:
Include the pet's name, breed, and age (if provided) else fill them randomly in your response.
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
}`;

    const model = genAI.getGenerativeModel({
      model: "gemini-1.5-flash",
      generationConfig: {
        temperature: 0.4,
        responseMimeType: "application/json",
      },
      systemInstruction: systemPrompt,
    });

    const prompt = text;
    const imagePart = {
      inlineData: {
        data: imageBase64,
        mimeType: "image/jpeg",
      },
    };

    const result = await model.generateContent([prompt, imagePart]);
    const response = await result.response;
    const jsonResponse = JSON.parse(response.text());

    // Ensure the response is properly typed for Dart
    // return all as Map<String, dynamic>
    return {
      success: true,
      data: {
        pet: jsonResponse.pet || null,
        check: jsonResponse.check || null,
        define: jsonResponse.define || null,
        conclusion: jsonResponse.conclusion || null,
        disclaimer: jsonResponse.disclaimer || null,
      },
    };
  } catch (error) {
    console.error("Error analyzing pet:", error);
    return {
      success: false,
      error: error instanceof Error ? error.message : "Unknown error occurred",
    };
  }
});
