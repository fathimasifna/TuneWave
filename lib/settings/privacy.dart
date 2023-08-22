import 'package:flutter/material.dart';

class Privacy extends StatelessWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(50),
              color: Colors.white10,
            ),
            child: ListView(
              padding: const EdgeInsets.all(18.0),
              children: const [
                Text(
              'Privacy Policy',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
             SizedBox(height: 16),
            Text(
              'We value your privacy and are committed to protecting your personal information.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
             SizedBox(height: 16),
            Text(
              'Information Collection',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
             SizedBox(height: 8),
            Text(
              'We collect information that you provide when creating an account, such as your name, email address, and profile picture.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
             SizedBox(height: 16),
            Text(
              'Information Usage',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
             SizedBox(height: 8),
            Text(
              'The information we collect is used to personalize your music listening experience and improve our services.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
             SizedBox(height: 16),
            Text(
              'Information Sharing',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
             SizedBox(height: 8),
            Text(
              'We do not share your personal information with third parties without your consent. However, we may share anonymized and aggregated data for analytics and marketing purposes.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
             SizedBox(height: 16),
            Text(
              'Data Security',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
             SizedBox(height: 8),
            Text(
              'We take reasonable measures to protect your personal information from unauthorized access or disclosure.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
             SizedBox(height: 16),
            Text(
              'Contact Us',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
             SizedBox(height: 8),
            Text(
              'If you have any questions or concerns about our privacy policy, please contact us at privacy@sifnafathima.com.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
