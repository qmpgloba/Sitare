bool checkIfNotEmpty(String? value) {
  return value != null && value.isNotEmpty && value != "null";
}

// ignore: constant_identifier_names
const List<String> GENDERS = [
  "Male",
  "Female",
];

const List<String> martialStatus = [
  'Single',
  'Married',
  'Divorced',
];
final List<String> filterOptions = [
  // 'Sort by',
  'Skills',
  'Language',
  'Experience',
  'Gender',
  // 'Country'
];
final List<String> sortbyOptions = [
  'Popularity',
  'Experience: High to Low',
  'Experience: Low to High',
  'Orders: High to Low',
  'Orders: Low to High',
  'Price: High to Low',
  'Price: Low to High',
  'Ratings: High to Low',
  'Ratings: Low to High',
];
final List<String> experienceOptions = ['1', '2', '3', '4', '5'];
final List<String> skillsOptions = [
  'Vedic',
  "Nadi",
  "Numerology",
  "Vastu",
  "Prashana",
  'KP',
  "Lal Kitab",
  "Western",
  "Tarot",
  "Palmistry",
  'Horary',
  "Face Reading",
  "Psychic",
  "Life Coach",
  "Cartomancy",
  'Loshu Grid',
  "Psychologist",
];

final List<String> languageOptions = [
  'English',
  "Hindi",
  "Malayalam",
  "Kannada",
  "Tamil",
];
final List<String> genderOptions = [
  'Male',
  'Female',
];
// final List<String> countryOptions = [
//   'India  ',
//   'Australia',
//   'USA',
// ];

List selectedOptions = [
  'Vedic',
  "Nadi",
  "Numerology",
  "Vastu",
  "Prashana",
  'KP',
  "Lal Kitab",
  "Western",
  "Tarot",
  "Palmistry",
  'Horary',
  "Face Reading",
  "Psychic",
  "Life Coach",
  "Cartomancy",
  'Loshu Grid',
  "Psychologist",
  'English',
  "Hindi",
  "Malayalam",
  "Kannada",
  "Tamil",
  'Male',
  'Female',
  // 'India  ',
  // 'Australia',
  // 'USA',
  '1',
  '2',
  '3',
  '4',
  '5'
];

List selectedSkills = [
  'Vedic',
  "Nadi",
  "Numerology",
  "Vastu",
  "Prashana",
  'KP',
  "Lal Kitab",
  "Western",
  "Tarot",
  "Palmistry",
  'Horary',
  "Face Reading",
  "Psychic",
  "Life Coach",
  "Cartomancy",
  'Loshu Grid',
  "Psychologist",
];
List<String> selectedExperience = ['1', '2', '3', '4', '5'];
List selectedLanguages = [
  'English',
  "Hindi",
  "Malayalam",
  "Kannada",
  "Tamil",
];
List selectedGenders = [
  "Male",
  "Female",
];
// List selectedCountries = [];
