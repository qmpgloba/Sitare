bool checkIfNotEmpty(String? value) {
  return value != null && value.isNotEmpty && value != "null";
}

// ignore: constant_identifier_names
const List<String> GENDERS = ["Male", "Female", "Other"];

const List<String> martialStatus = [
  'Single',
  'Married',
  'Divorced',
];
final List<String> filterOptions = [
    'Sort by',
    'Skills',
    'Category',
    'Language',
    'Gender',
    'Country'
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
  final List<String> skillsOptions = [
    'Yes',
    'No',
    'Intermediate',
  ];
  final List<String> categoryOptions = [
    'Shoes',
    'Dress',
    'Casual',
  ];
  final List<String> languageOptions = [
    'Tamil',
    'English',
    'Hindi',
  ];
  final List<String> genderOptions = [
    'Male',
    'Female',
    'Others',
  ];
  final List<String> countryOptions = [
    'India  ',
    'Australia',
    'USA',
  ];
