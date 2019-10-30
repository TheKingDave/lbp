class RouteAction {
  String routeName;

  RouteAction(this.routeName);
}

class NavigateReplaceAction extends RouteAction {
  NavigateReplaceAction(routeName) : super(routeName);
}

class NavigatePushAction extends RouteAction {
  NavigatePushAction(routeName) : super(routeName);
}

class NavigatePushNamedAndRemoveUntilAction extends RouteAction {
  NavigatePushNamedAndRemoveUntilAction(routeName) : super(routeName);
}

class NavigatePopAction {}
