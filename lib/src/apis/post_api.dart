
abstract class PostApi {
  Future<void> like(
    final String postId,
  ) async {
    throw UnimplementedError();
  }

  Future<void> save(
      final String postId,
      ) async {
    throw UnimplementedError();
  }

  Future<void> comment(
      final String postId,
      final String text,
      ) async {
    throw UnimplementedError();
  }

}

class PostApiMock implements PostApi {

  @override
  Future<void> like(
    final String postId,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> save(
      final String postId,
      ) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> comment(
      final String postId,
      final String text,
      ) async {
    await Future.delayed(const Duration(seconds: 1));
  }

}
