abstract class DashboardEvent {}

class ChangeMenuDashboardEvent extends DashboardEvent {
  int index;

  ChangeMenuDashboardEvent(this.index);
}