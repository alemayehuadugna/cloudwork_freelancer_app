
import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../../common/params.dart';
import '../entities/job.dart';
import '../repo/job_repository.dart';

class ListJob implements UseCase<List<JobEntity>, PaginationParams> {
  final JobRepository repository;

  ListJob({required this.repository});

  @override
  Future<Either<Failure, List<JobEntity>>> call(PaginationParams params) async {
    var nowDate = DateTime.now();
    int nowYear = nowDate.year;
    int nowMonth = nowDate.month;
    int nowDay = nowDate.day;

    int expiryYear;
    int expiryMonth;
    int expiryDay;
    int noOfDays;

    int collector = 0;

    Either<Failure, List<JobEntity>> jobs = await repository.listJobs(params);
    jobs.fold((failure) {
      return Left(failure);
    }, (jobs) {
      jobs.forEach(
        (job) {
          if (job.expiry != null) {
            expiryYear = int.parse(job.expiry!.split('-')[0]);
            expiryMonth = int.parse(job.expiry!.split('-')[1]);
            expiryDay = int.parse(
                job.expiry!.split(':')[0].split('-')[2].split('T')[0]);
            noOfDays = getDaysInMonth(expiryYear, expiryMonth);
            if (expiryDay - nowDay > 0) {
              collector = collector + (expiryDay - nowDay);
            }
            if (expiryMonth - nowMonth > 0) {
              collector = collector + ((expiryMonth - nowMonth) * noOfDays);
            }
            if (expiryYear - nowYear > 0) {
              collector = collector + ((expiryYear - nowYear) * 12 * noOfDays);
            }
            job.expiry = collector.toString() + "::" + job.expiry.toString();
            collector = 0;
          }
        },
      );
      return jobs;
    });

    return jobs;
  }

  static int getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      final bool isLeapYear =
          (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      return isLeapYear ? 29 : 28;
    }
    const List<int> daysInMonth = <int>[
      31,
      -1,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31
    ];
    return daysInMonth[month - 1];
  }
}
