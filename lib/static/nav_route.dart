enum NavRoute {
  mainRoute("/main"),
  detailRoute("/detail");

  const NavRoute(this.name);
  final String name;
}