import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class QueryParams extends Equatable {
  final dynamic pagination;
  final dynamic filter;
  final dynamic sort;

  const QueryParams(this.pagination, this.filter, this.sort);

  @override
  List<Object?> get props => [pagination, filter, sort];
}
