import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProgressionItem {
  final String title;
  final String property;
  final IconData icon;
  final String? description;

  ProgressionItem({
    required this.title,
    required this.property,
    required this.icon,
    this.description,
  });
}

List<ProgressionItem> lifeProgressionList = [
  ProgressionItem(
    title: 'Married',
    property: 'married',
    icon: FontAwesomeIcons.ring,
    description: '',
  ),
  ProgressionItem(
    title: 'Childbirth',
    property: 'childbirth',
    icon: FontAwesomeIcons.baby,
    description: '',
  ),
  ProgressionItem(
    title: 'University Eduction',
    property: 'universityEducation',
    icon: FontAwesomeIcons.graduationCap,
    description: '',
  ),
  ProgressionItem(
    title: 'Owns House or Building Project',
    property: 'ownsHouseOrBuildingProject',
    icon: FontAwesomeIcons.home,
    description: '',
  ),
];

List<ProgressionItem> spiritualProgressionList = [
  ProgressionItem(
    title: 'Salvation',
    property: 'salvation',
    icon: FontAwesomeIcons.tent,
    description: '',
  ),
  ProgressionItem(
    title: 'Water Baptism',
    property: 'waterBaptism',
    icon: FontAwesomeIcons.music,
    description: '',
  ),
  ProgressionItem(
    title: 'Holy Ghost Baptism',
    property: 'holyGhostBaptism',
    icon: FontAwesomeIcons.music,
    description: '',
  ),
  ProgressionItem(
    title: 'New Believers School',
    property: 'newBelieversSchool',
    icon: FontAwesomeIcons.music,
    description: '',
  ),
  ProgressionItem(
    title: 'Strong Christians Academy',
    property: 'strongChristiansAcademy',
    icon: FontAwesomeIcons.music,
    description: '',
  ),
  ProgressionItem(
    title: 'Understanding Schools 1',
    property: 'understandingSchools1',
    icon: FontAwesomeIcons.music,
    description: '',
  ),
  ProgressionItem(
    title: 'Understanding Schools 2',
    property: 'understandingSchools2',
    icon: FontAwesomeIcons.music,
    description: '',
  ),
  ProgressionItem(
    title: 'Understanding Schools 3',
    property: 'understandingSchools3',
    icon: FontAwesomeIcons.music,
    description: '',
  ),
  ProgressionItem(
    title: 'Attended Camp 1',
    property: 'attendedCamp1',
    icon: FontAwesomeIcons.music,
    description: '',
  ),
  ProgressionItem(
    title: 'Attended Camp 2',
    property: 'attendedCamp2',
    icon: FontAwesomeIcons.music,
    description: '',
  ),
  ProgressionItem(
    title: 'Attended Camp 3',
    property: 'attendedCamp3',
    icon: FontAwesomeIcons.music,
    description: '',
  ),
  ProgressionItem(
    title: 'Founders Intimate Counselling',
    property: 'foundersIntimateCounselling',
    icon: FontAwesomeIcons.music,
    description: '',
  ),
  ProgressionItem(
    title: 'Lead Pastor Intimate Counselling',
    property: 'leadPastorIntimateCounselling',
    icon: FontAwesomeIcons.music,
    description: '',
  ),
  ProgressionItem(
    title: 'Bacenta Leader',
    property: 'bacentaLeader',
    icon: FontAwesomeIcons.music,
    description: '',
  ),
  ProgressionItem(
    title: 'Basonta Leader',
    property: 'basontaLeader',
    icon: FontAwesomeIcons.music,
    description: '',
  ),
  ProgressionItem(
    title: 'Creative Arts Leader',
    property: 'creativeArtsLeader',
    icon: FontAwesomeIcons.music,
    description: '',
  ),
  ProgressionItem(
    title: 'Pastor',
    property: 'pastor',
    icon: FontAwesomeIcons.music,
    description: '',
  ),
  ProgressionItem(
    title: 'Has Makarios Collection',
    property: 'hasMakariosCollection',
    icon: FontAwesomeIcons.music,
    description: '',
  ),
  ProgressionItem(
    title: 'Has Audio Collection',
    property: 'hasAudioCollection',
    icon: FontAwesomeIcons.music,
    description: '',
  ),
  ProgressionItem(
    title: 'On Bacenta Whatsapp Group',
    property: 'onBacentaWhatsappGroup',
    icon: FontAwesomeIcons.music,
    description: '',
  ),
];

double calculateProgressionPercentage(Map<String, dynamic>? progression) {
  double total = 0;
  double completed = 0;

  if (progression == null) return 0;

  progression.forEach((key, value) {
    if (value == true) {
      completed++;

      if (key == 'pastor') {
        completed++;
      }
    }
    total++;
  });

  return completed / total * 100;
}
