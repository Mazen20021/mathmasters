import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Aboutus extends StatelessWidget {
  const Aboutus({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 36, 50, 51),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 255, 249, 208),
        title: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: Text(
                "Our Team",
                style: GoogleFonts.pacifico(
                  fontSize: constraints.maxWidth < 600 ? 36 : 40,
                  color: const Color.fromARGB(255, 36, 50, 51),
                ),
              ),
            );
          },
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              minWidth: constraints.maxWidth,
            ),
            child: IntrinsicHeight(
              child: Wrap(
                spacing: 50,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _buildInfoCard(
                    context: context,
                    onTap: () {},
                    image: 'assets/images/Devops.png',
                    name: "Eng: Mazen Ahmed",
                    description: "Faculty of Engineering",
                    role: "Technincal Support",
                  ),
                  _buildInfoCard(
                    context: context,
                    onTap: () {},
                    image: 'assets/images/Mahmoud.png',
                    name: "Eng: Mahmoud Adway",
                    description: "Eng",
                    role: "Assistant Team Leader",
                  ),
                  _buildInfoCard(
                    context: context,
                    onTap: () {},
                    image: 'assets/images/person.png',
                    name: "Mohamed Adawy",
                    description: "Eng",
                    role: "Assistant Team Leader",
                  ),
                  _buildInfoCard(
                    context: context,
                    onTap: () {},
                    image: 'assets/images/person.png',
                    name: "Ahmed Hesham",
                    description: "Eng",
                    role: "Assistant Team Leader",
                  ),
                  _buildInfoCard(
                    context: context,
                    onTap: () {},
                    image: 'assets/images/person.png',
                    name: "Mariam",
                    description: "Eng",
                    role: "Assistant Team Leader",
                  ),
                  _buildInfoCard(
                    context: context,
                    onTap: () {},
                    image: 'assets/images/Yassin.png',
                    name: "Yassin Tarek",
                    description: "Eng",
                    role: "Assistant",
                  ),
                  _buildInfoCard(
                    context: context,
                    onTap: () {},
                    image: 'assets/images/person.png',
                    name: "Ethar",
                    description: "Eng",
                    role: "Assistant",
                  ),
                  _buildInfoCard(
                    context: context,
                    onTap: () {},
                    image: 'assets/images/person.png',
                    name: "Mohamed El-Sayed",
                    description: "Eng",
                    role: "Assistant",
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildInfoCard({
    required String name,
    required String role,
    required String description,
    required Function() onTap,
    required String image,
    required BuildContext context,
  }) {
    return Column(
      children: [
        const SizedBox(height: 30),
        InkWell(
          borderRadius: BorderRadius.circular(50),
          hoverColor: const Color.fromARGB(50, 255, 255, 255),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(0, 5),
                  blurRadius: 15,
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            width: 350,
            height: 350,
            child: Column(
              children: [
                ClipOval(
                  child: Image.asset(
                    image,
                    height: 200,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  role,
                  style: GoogleFonts.pacifico(
                    color: const Color.fromARGB(255, 255, 249, 208),
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  name,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 249, 208),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 249, 208),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
