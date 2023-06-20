import '../../data/models/user.dart';
import 'date_range.entity.dart';

class LocationFilter {
  final User? child;
  final List<User> children;
  final DateRange? dateRange;

  const LocationFilter({
    this.child,
    this.children = const [],
    this.dateRange,
  });

  LocationFilter copyWith({
    User? child,
    DateRange? dateRange,
    List<User>? children,
  }) {
    return LocationFilter(
      child: child ?? this.child,
      children: children ?? this.children,
      dateRange: dateRange ?? this.dateRange,
    );
  }

  DateTime? get from => dateRange?.from;
  DateTime? get to => dateRange?.to;
  String? get userId => child?.id;
}
