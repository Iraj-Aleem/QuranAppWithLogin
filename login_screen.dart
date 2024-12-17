import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';
import 'signup_screen.dart';
import 'homescreen.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final authProvider = Provider.of<AuthProvider>(context, listen: false);
                String? result = await authProvider.loginWithEmailPassword(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );
                if (result == null) {
                  Navigator.pushReplacement(
                    context,
                    //  MaterialPageRoute(builder: (context) => const HomeScreen()),
                    MaterialPageRoute(builder: (context) =>  HomeScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
                }
              },
              child: const Text("Login"),
            ),
            Align(
  alignment: Alignment.centerRight,
  child: TextButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ForgetPasswordScreen()),
      );
    },
    child: const Text(
      "Forgot Password?",
      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
    ),
  ),
),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                );
              },
              child: const Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class LoginScreen extends StatelessWidget {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // Google Sign-In Method
//   Future<User?> signInWithGoogle() async {
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//     if (googleUser == null) return null; // User canceled

//     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     UserCredential userCredential = await _auth.signInWithCredential(credential);
//     return userCredential.user;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Login')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () async {
//                 User? user = await signInWithGoogle();
//                 if (user != null) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("Welcome, ${user.displayName}!")),
//                   );
//                 }
//               },
//               child: Text("Login with Google"),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 // Sign out
//                 await GoogleSignIn().signOut();
//                 await _auth.signOut();
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("Signed Out Successfully")),
//                 );
//               },
//               child: Text("Logout"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
