import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:south_cinema/core/network/network_info.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  NetworkInfoImpl networkInfo;
  MockInternetConnectionChecker mockInternetConnectionChecker;
  
  group('isConnected', () {
    test(
      'should forward call to InternetConnectionChecker.hasConnection',
      () async {
        // arrange
        mockInternetConnectionChecker = MockInternetConnectionChecker();
        networkInfo = NetworkInfoImpl(mockInternetConnectionChecker);

        final tHasConnectionFuture = Future.value(true);
        when(mockInternetConnectionChecker.hasConnection)
            .thenAnswer((_) => tHasConnectionFuture);
        // act
        final result = networkInfo.isConnected;
        // assert
        verify(mockInternetConnectionChecker.hasConnection);
        expect(result, tHasConnectionFuture);
      },
    );
  });
}
