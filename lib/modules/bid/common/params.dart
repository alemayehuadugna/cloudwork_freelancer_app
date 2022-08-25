import 'package:equatable/equatable.dart';

class PaginationParams extends Equatable {
  final int pageKey; 
  final int pageSize;
  final String freelancerId;

  const PaginationParams(this.pageKey, this.pageSize, this.freelancerId);
  
  @override
  List<Object?> get props => [pageKey, pageSize, freelancerId];

}