import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

push(BuildContext context, Widget page) {
  CosmosNavigator.pushNonAnimated(context, page);
}

pop(BuildContext context) {
  CosmosNavigator.pop(context);
}
