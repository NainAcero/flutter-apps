// This contains a dummy entry point, and is opted out
// @dart=2.9
import 'package:clean_arquitect01/core/network/network_info.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}
void main() {
  NetworkInfoImpl networkInfo;
  MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('isConnected', () {
    test(
      'should forward the call to DataConnectionChecker.hasConnection',
      () async {
        final tHasConnectionFuture = Future.value(true);

        when(mockDataConnectionChecker.hasConnection).thenAnswer(
          (_) => tHasConnectionFuture
        );

        final result = networkInfo.isConnected;

        verify(mockDataConnectionChecker.hasConnection);
        expect(result, tHasConnectionFuture);
      }
    );
  });
}