import 'package:portfolio_web/Data/models/project_model.dart';

List<Project> projects = [
  Project(
    title: 'Grocery App',
    description: 'A modern Grocery App featuring GET API integration, add to cart functionality, and an attractive UI design with a curved bottom navigation bar. It includes product listing, item details, and cart screen all designed using Flutter best practices.', // [cite: 14]
    imageUrl: 'assets/searchscreen.jpg',
    liveDemoLink: 'YOUR_DOC_VOUCH_LIVE_DEMO_LINK',// Replace with your actual image path
    githubLink: 'YOUR_GROCERY_APP_GITHUB_LINK', // Provide this link
    technologies: ['Flutter', 'GET API', 'Curved Navigation'],
  ),
  Project(

    title: 'Food Delivery App (Frontend)',
    description: 'A complete Flutter-based food delivery application developed with a focus on frontend UI/UX, providing a user-friendly and visually appealing interface for customers to browse and order food. Key features include attractive and responsive UI, home screen with featured restaurants, category-based Browse, item details, and shopping cart (frontend only).', // [cite: 13]
    imageUrl: 'assets/productdetailscreen.jpg',
    liveDemoLink: 'YOUR_DOC_VOUCH_LIVE_DEMO_LINK',// Replace with your actual image path
    githubLink: 'YOUR_FOOD_DELIVERY_APP_GITHUB_LINK', // Provide this link
    technologies: ['Flutter', 'UI/UX', 'Responsive Design'],
  ),
  Project(
    title: 'Toppers Academy App',
    description: 'An educational application designed to facilitate learning through quizzes, access to previous papers, and reading notes. Students can solve quizzes, access previous exam papers in PDF, and read notes in text format. Includes an admin panel for managing tasks.', // [cite: 12]
    imageUrl: 'assets/searchscreen.jpg', // Replace with your actual image path
    githubLink: 'YOUR_TOPPERS_ACADEMY_APP_GITHUB_LINK', // Provide this link
    technologies: ['Flutter', 'Quizzes', 'PDF Viewer', 'Admin Panel'],
    liveDemoLink: 'YOUR_DOC_VOUCH_LIVE_DEMO_LINK',
  ),
  Project(
    title: 'Firebase Student Form App',
    description: 'A Flutter app using Firebase for backend operations. Users can fill a student form, and the data is displayed on the next screen. Includes update and delete functionality for managing records in real time.', // [cite: 15]
    imageUrl: 'assets/productdetailscreen.jpg', // Replace with your actual image path
    githubLink: 'YOUR_FIREBASE_STUDENT_APP_GITHUB_LINK', // Provide this link
    technologies: ['Flutter', 'Firebase', 'GetX'],
    liveDemoLink: 'YOUR_DOC_VOUCH_LIVE_DEMO_LINK',
  ),
  Project(
    title: 'SQFlite Student Form App',
    description: 'A Flutter app using SQflite for local database storage. Students fill a form, and the data is displayed on the next screen. Includes update and delete functionality, structured with a controller class for clean code management.', // [cite: 16]
    imageUrl: 'assets/searchscreen.jpg', // Replace with your actual image path
    githubLink: 'YOUR_SQFLITE_STUDENT_APP_GITHUB_LINK', // Provide this link
    technologies: ['Flutter', 'SQFlite', 'Local Database'],
    liveDemoLink: 'YOUR_DOC_VOUCH_LIVE_DEMO_LINK',
  ),
  // Add more projects as needed
];