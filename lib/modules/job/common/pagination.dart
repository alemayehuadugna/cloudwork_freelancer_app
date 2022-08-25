import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../domain/entities/job.dart';

const pageSize = 10;
var pageKey;

 PagingController<int, JobEntity> pagingController =
    PagingController(firstPageKey: 1);
int count = 0;

