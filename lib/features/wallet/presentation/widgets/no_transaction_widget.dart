import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/app_user_bloc/app_user_bloc.dart';
import '../../../../core/widgets/not_yet_widget.dart';
import '../bloc/wallet_bloc/wallet_bloc.dart';

class WalletMessageWidget extends StatelessWidget {
  final bool type;
  const WalletMessageWidget({
    required this.type,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const Spacer(flex: 1),
          if (type)
            const NotYetWidget(
              title: "No Transactions yet",
              subtitle: "You'll find your transactions all right here",
            ),
          if (!type)
            InkWell(
              onTap: () {
                context.read<WalletBloc>().add(
                      WalletBalanceEvent(
                          uid: context.read<AppUserBloc>().userModel!.uid),
                    );
              },
              borderRadius: BorderRadius.circular(8),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: NotYetWidget(
                  title: "Unlock TakeMyTym Wallet",
                  subtitle: "Confirm your screen lock PIN, Pattern or Password",
                ),
              ),
            ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
