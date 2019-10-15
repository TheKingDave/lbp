class RouteAction {
  String routeName;

  RouteAction(this.routeName);
}

class NavigateReplaceAction extends RouteAction{
  NavigateReplaceAction(routeName) : super(routeName);
}

class NavigatePushAction extends RouteAction{
  NavigatePushAction(routeName) : super(routeName);
}

class NavigatePopAction{
}