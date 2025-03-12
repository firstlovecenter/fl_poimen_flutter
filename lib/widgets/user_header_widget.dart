import 'package:flutter/material.dart';
import 'package:poimen/screens/home/utils_home.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/auth_service.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/auth_state.dart';
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
    var authState = context.watch<AuthState>();

    // Get user information from AuthState which provides unified access
    final fullName = authState.getFullName();
    final pictureUrl = authState.getPictureUrl();

    final nameParts = fullName.split(' ');
    final firstName = nameParts.isNotEmpty ? nameParts[0] : 'User';
    final lastName = nameParts.length > 1 ? nameParts.skip(1).join(' ') : 'Name';

    final picture = CloudinaryImage(url: pictureUrl, size: ImageSize.lg);
    var role = parseRole(state.role);

    // Create user member object for display
    final user = MemberForList(
      id: authState.userProfile?.id ?? authState.authProfile?.sub ?? '',
      typename: 'Member',
      status: 'Sheep',
      firstName: firstName,
      lastName: lastName,
      pictureUrl: pictureUrl,
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
              fullName,
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
