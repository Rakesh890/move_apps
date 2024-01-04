import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/error/app_exception.dart';
import 'package:movie_app/domain/entity/movie.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';
import 'package:movie_app/domain/usecase/movie_popular_usecase.dart';

import 'movie_popular_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRepository>()])

void main() {
  late MoviePopularUseCase moviePopularUseCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    moviePopularUseCase = MoviePopularUseCase(movieRepository: mockMovieRepository);
  });

  // Define sample data or responses
   Movie sampleMovies = Movie(
    page: 1,
    results: const [
      ResultsEntity(
          adult: false,
          backdropPath: "/sRLC052ieEzkQs9dEtPMfFxYkej.jpg",
          genreIds: [
          878
          ],
          id: 848326,
          originalLanguage: "en",
          originalTitle: "Rebel Moon - Part One: A Child of Fire",
          overview: "When a peaceful colony on the edge of the galaxy finds itself threatened by the armies of the tyrannical Regent Balisarius, they dispatch Kora, a young woman with a mysterious past, to seek out warriors from neighboring planets to help them take a stand.",
          popularity: 2488.167,
          posterPath: "/ui4DrH1cKk2vkHshcUcGt2lKxCm.jpg",
          releaseDate: "2023-12-15",
          title: "Rebel Moon - Part One: A Child of Fire",
          video: false,
          voteAverage: 6.463,
          voteCount: 944
      )
    ],
      totalPages: 42088,
      totalResults: 841745
  );

   AppException sampleException = GeneralException(message:'Test error');

  test('should get a list of popular movies from the repository', () async {
    // Arrange
    when(mockMovieRepository.getPopularMovies()).thenAnswer((_) async => Future.value(Left(sampleMovies)));
    // Act
    final result = await moviePopularUseCase.call();
    // Assert
    expect(result, Left(sampleMovies));
    verify(mockMovieRepository.getPopularMovies());
    verifyNoMoreInteractions(mockMovieRepository);
  });

  test('should return an AppException when an error occurs in the repository', () async {
    // Arrange
    when(mockMovieRepository.getPopularMovies()).thenAnswer((_) async => Future.value(Right(sampleException)));
    // Act
    final result = await moviePopularUseCase.call();
    // Assert
    expect(result, Right(sampleException));
    verify(mockMovieRepository.getPopularMovies());
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
