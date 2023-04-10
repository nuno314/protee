enum DashboardPage {
  home,
  product,
  appointment,
  promotion,
  account,
}

extension DashboardPageExt on DashboardPage {
  static bool guestCanView(int idx) {
    return [
      DashboardPage.home.index,
      DashboardPage.product.index,
      DashboardPage.promotion.index,
    ].contains(idx);
  }
}
