import 'package:Moodial/services/link_launcher.dart';
import 'package:flutter/material.dart';

class Resources extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      child: ExpansionTile(
        expandedAlignment: Alignment.topLeft,
        childrenPadding: EdgeInsets.symmetric(horizontal: 15),
        title: Text(
          'Resources',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          Text(
              'Don\'t worry if you feel like you are struggling with your mood. You may be concerned by trends you see by consistently tracking your mood, and this is okay.'),
          SizedBox(height: 10),
          Text(
              'Part of the advantages of mood tracking is that you have empowered yourself to see these trends, and may be in a better position to take proactive action, rather than reactive action.'),
          SizedBox(height: 10),
          Text(
              'The following resources are here as possible first steps for you to take, should you feel you need them:'),
          SizedBox(height: 15),
          ExpansionTile(
            expandedAlignment: Alignment.topLeft,
            childrenPadding: EdgeInsets.symmetric(horizontal: 15),
            title: Text(
              'Reading',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: LinkLauncher.govURL,
                    child: Text('Gov.ie - Minding Your Mood'),
                  ),
                  Text(
                      'Healthy Ireland have put together a campaign alongside the Irish Government outlining some positive psychology practices.'),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: LinkLauncher.hseURL,
                    child: Text('HSE - Your Mental Health'),
                  ),
                  Text(
                      'The HSE have a lot of information on minding your mental health, including blog posts filterable by different mood disorders.'),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
          ExpansionTile(
            expandedAlignment: Alignment.topLeft,
            childrenPadding: EdgeInsets.symmetric(horizontal: 15),
            title: Text(
              'Supports',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('50808', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                      'Free 24/7 text service, providing everything from a calming chat to immediate support for people going through a mental health or emotional crisis - big or small. From breakups or bullying, to anxiety, depression and suicidal feelings, crisis volunteers are available 24/7 for anonymous text conversations. Start a conversation by free-texting the word HELLO to 50808 any time, day or night.'),
                  SizedBox(height: 10),
                  Text('Pieta', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                      'Professional one-to-one therapeutic services to people who are in suicidal distress, those who engage in self-harm, and those bereaved by suicide. All services are provided free of charge and no referral is needed. Call free 1800 247 247. Text HELP to 51444.'),
                  SizedBox(height: 10),
                  Text('Jigsaw', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                      'Text CALL ME to 086 180 3880 and one of the team can call you back when it suits you.'),
                  SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
