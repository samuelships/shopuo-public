import 'package:flutter/material.dart';
import 'package:shopuo/Components/Button/ButtonComponent.dart';
import 'package:shopuo/Components/HeaderComponent.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    final content = [
      "Your privacy is important to us. It is Brainstorming's policy to respect your privacy regarding any information we may collect from you across our website, and other sites we own and operate.",
      "We only ask for personal information when we truly need it to provide a service to you. We collect it by fair and lawful means, with your knowledge and consent. We also let you know why we’re collecting it and how it will be used.",
      "We only retain collected information for as long as necessary to provide you with your requested service. What data we store, we’ll protect within commercially acceptable means to prevent loss and theft, as well as unauthorized access, disclosure, copying, use or modification.",
      "We don’t share any personally identifying information publicly or with third-parties, except when required to by law.",
      "Our website may link to external sites that are not operated by us. Please be aware that we have no control over the content and practices of these sites, and cannot accept responsibility or liability for their respective privacy policies.",
      "You are free to refuse our request for your personal information, with the understanding that we may be unable to provide you with some of your desired services.You are free to refuse our request for your personal information, with the understanding that we may be unable to provide you with some of your desired services.",
      "Your continued use of our website will be regarded as acceptance of our practices around privacy and personal information. If you have any questions about how we handle user data and personal information, feel free to contact us.",
      "This policy is effective as of 5 November 2019."
    ];

    return SafeArea(
      child: Scaffold(
        appBar: HeaderComponent(
          leading: "assets/svg_icons/chevron-left.svg",
          title: "Privacy Policy",
          background: MyColor.primaryPurple,
          leadingColor: Colors.white,
          titleStyle: HeaderComponent.fontStyle.copyWith(
            color: Colors.white,
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 25),
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              "Privacy Policy",
              style: MyTypography.heading5SB.copyWith(
                color: MyColor.neutralBlack,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ...content
                .map((e) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e,
                          style: MyTypography.bodyParagraph.copyWith(
                              color: MyColor.neutralGrey3, height: 1.5),
                        ),
                        SizedBox(
                          height: 25,
                        )
                      ],
                    ))
                .toList(),
            SizedBox(
              height: 20,
            ),
            ButtonComponent(
              text: "I've agreed with this",
              onTap: () {},
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
