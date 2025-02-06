import 'package:flutter/material.dart';
import 'package:poimen/screens/home/utils_home.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/auth_service.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:provider/provider.dart';

class UserHeaderWidget extends StatelessWidget {
  const UserHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var state = context.watch<SharedState>();
    final authUser = AuthService.instance.profile;

    final picture = CloudinaryImage(url: authUser?.picture ?? '', size: ImageSize.lg);
    var role = parseRole(state.role);
    final user = MemberForList(
      id: authUser?.sub ?? '',
      typename: 'Member',
      status: 'Sheep',
      firstName: authUser?.name ?? '',
      lastName: 'last name--',
      pictureUrl: authUser?.picture ?? '',
      phoneNumber: '0000',
      whatsappNumber: '0000',
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              authUser?.name ?? '',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              role,
              style: const TextStyle(color: PoimenTheme.textSecondary),
            )
          ],
        ),
        const Padding(padding: EdgeInsets.all(10.0)),
        Expanded(
          child: Column(
            children: [
              AvatarWithInitials(
                foregroundImage: picture.image,
                member: user,
                radius: 45,
              ),
            ],
          ),
        )
      ],
    );
  }
}
