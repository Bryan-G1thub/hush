// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { getAuth } from "firebase/auth";
import { getFirestore } from "firebase/firestore";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyDLxf97HMrh4_r6fWjql11wbwm6yyLzHzo",
  authDomain: "hush-6bdfc.firebaseapp.com",
  projectId: "hush-6bdfc",
  storageBucket: "hush-6bdfc.firebasestorage.app",
  messagingSenderId: "81535717622",
  appId: "1:81535717622:web:687def0713c6191edc5cd7",
  measurementId: "G-79T86ZF870"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

// Initialize Analytics only on the client side
let analytics = null;
if (typeof window !== 'undefined') {
  analytics = getAnalytics(app);
}

const auth = getAuth(app);

export { auth, analytics, db };