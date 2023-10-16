class AstrologerModel {
  final String fullName;
  final String emailAddress;
  final String phoneNumber;
  final String profilePic;
  final String officeAddress;
  final String description;
  final String experienceYears;
  final int contributeHours;
  final String heardAboutSitare;
  final String gender;
  final String martialStatus;
  final String dateOfBirth;
  final List languages;
  final List skills;
  final String workingOnlinePLatform;
  final String instagramLink;
  final String linkedInLink;
  final String websiteLink;
  final String facebookLink;
  final String youtubeLink;
  final String business;
  final String anyoneReferSitare;
  final String onBorad;
  final String qualification;
  final String earningExpectation;
  final String learnAboutAstrology;
  final int foreignCountries;
  final String biggestChallenge;
  final String currentWorkingStatus;
  final String fcmToken;
  AstrologerModel(
      {required this.fullName,
      required this.emailAddress,
      required this.phoneNumber,
      required this.profilePic,
      required this.officeAddress,
      required this.description,
      required this.experienceYears,
      required this.contributeHours,
      required this.heardAboutSitare,
      required this.gender,
      required this.martialStatus,
      required this.dateOfBirth,
      required this.languages,
      required this.skills,
      required this.workingOnlinePLatform,
      required this.instagramLink,
      required this.linkedInLink,
      required this.websiteLink,
      required this.facebookLink,
      required this.youtubeLink,
      required this.business,
      required this.anyoneReferSitare,
      required this.onBorad,
      required this.qualification,
      required this.earningExpectation,
      required this.learnAboutAstrology,
      required this.foreignCountries,
      required this.biggestChallenge,
      required this.currentWorkingStatus,
      required this.fcmToken});

  toJson() {
    return {
      "name": fullName,
      "email": emailAddress,
      "phone number": phoneNumber,
      "profile image": profilePic,
      "office address": officeAddress,
      "personal description": description,
      "experience(in years)": experienceYears,
      "hours of contribution": contributeHours,
      "Where did you hear about sitare": heardAboutSitare,
      "gender": gender,
      "martial status": martialStatus,
      "date of birth": dateOfBirth,
      "languages": languages,
      "skills": skills,
      "working on any other online platform": workingOnlinePLatform,
      "onboard you": onBorad,
      "highest qualification": qualification,
      "instagram profile link": instagramLink,
      "linkedin profile link": linkedInLink,
      "website profile link": websiteLink,
      "minimum earning expectation": earningExpectation,
      "form where did you learn astrology": learnAboutAstrology,
      "facebook profile link": facebookLink,
      "youtube profile link": youtubeLink,
      "main source of business": business,
      "did anyone refer sitare": anyoneReferSitare,
      "Number of foreign countries": foreignCountries,
      "biggest challenge": biggestChallenge,
      "current working status": currentWorkingStatus,
      "fcmToken": fcmToken
    };
  }

  factory AstrologerModel.fromJson(Map<String, dynamic> json) {
    return AstrologerModel(
        fullName: json['name'],
        emailAddress: json['email'],
        phoneNumber: json['phone number'],
        profilePic: json['profile image'],
        officeAddress: json['office address'],
        description: json['personal description'],
        experienceYears: json['experience(in years)'],
        contributeHours: json['hours of contribution'],
        heardAboutSitare: json['Where did you hear about sitare'],
        gender: json['gender'],
        martialStatus: json['martial status'],
        dateOfBirth: json['date of birth'],
        languages: List<String>.from(json['languages']),
        skills: List<String>.from(json['skills']),
        workingOnlinePLatform: json['working on any other online platform'],
        onBorad: json['onboard you'],
        qualification: json['highest qualification'],
        instagramLink: json['instagram profile link'],
        linkedInLink: json['linkedin profile link'],
        websiteLink: json['website profile link'],
        earningExpectation: json['minimum earning expectation'],
        learnAboutAstrology: json['form where did you learn astrology'],
        facebookLink: json['facebook profile link'],
        youtubeLink: json['youtube profile link'],
        business: json['main source of business'],
        anyoneReferSitare: json['did anyone refer sitare'],
        foreignCountries: json['Number of foreign countries'],
        biggestChallenge: json['biggest challenge'],
        currentWorkingStatus: json['current working status'],
        fcmToken: json['fcmToken']);
  }
}
