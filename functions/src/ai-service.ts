import * as functions from "firebase-functions";
import {GoogleGenerativeAI} from "@google/generative-ai";

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || "");

export const analyzePet = functions.https.onCall(async (data) => {
  try {
    const {text, imageBase64} = data;

    const model = genAI.getGenerativeModel({
      model: "gemini-1.5-flash",
      generationConfig: {
        temperature: 0.4,
      },
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

    return {success: true, data: jsonResponse};
  } catch (error) {
    console.error("Error analyzing pet:", error);
    return {
      success: false,
      error: error instanceof Error ? error.message : "Unknown error occurred",
    };
  }
});
