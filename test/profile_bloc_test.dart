import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
//
// class MockPrefs extends Mock implements SharedPreferences {}
//
// void main() {
//   late MockPrefs mockPrefs;
//   late ProfileBloc bloc;
//
//   setUp(() {
//     mockPrefs = MockPrefs();
//     bloc = ProfileBloc(mockPrefs);
//   });
//
//   blocTest<ProfileBloc, ProfileState>(
//     'emits [Loading, Success] when valid data',
//     build: () {
//       when(() => mockPrefs.setString(any(), any()))
//           .thenAnswer((_) async => true);
//       return bloc;
//     },
//     act: (bloc) => bloc.add(
//       UpdateProfileEvent(
//         name: "priyanka",
//         email: "test@gmail.com",
//         mobile: "9999999999",
//         dob: "06/12/1996",
//         gender: "Female",
//         anniversary: "06/09/1995",
//       ),
//     ),
//     expect: () => [
//       ProfileLoading(),
//       ProfileSuccess(),
//     ],
//   );
// }

