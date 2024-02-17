// // Import the Freezed annotation package
// import 'package:freezed_annotation/freezed_annotation.dart';

// // Include the generated part file
// part 'main_failure.freezed.dart';

// // Create a union class for your custom failures
// @freezed
// class MainFailure with _$MainFailure {
//   // Constructor for client-related failures, such as network issues or user errors
//   const factory MainFailure.clientFailure({String? errorMessage}) =
//       _ClientFailure;

//   // Constructor for server-related failures, such as server errors or invalid responses
//   const factory MainFailure.serverFailure({String? errorMessage}) =
//       _ServerFailure;

//   // Constructor for unauthorized failures, such as authentication errors
//   const factory MainFailure.unauthorized({String? errorMessage}) =
//       _UnauthorizedFailure;

//   // Constructor for forbidden failures, such as access denied errors
//   const factory MainFailure.forbidden({String? errorMessage}) =
//       _ForbiddenFailure;
// }
