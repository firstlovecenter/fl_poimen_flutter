import 'package:flutter/material.dart';
import 'package:poimen/screens/home/utils_home.dart';
import 'package:poimen/screens/membership/models_membership.dart';
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

    // Get screen dimensions for responsive layout
    final screenSize = MediaQuery.of(context).size;
    final isTabletOrLarger = screenSize.width > 600;
    final isDesktop = screenSize.width > 1100;

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

    // Desktop and tablet layout (horizontal with more information)
    if (isTabletOrLarger) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  fullName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: PoimenTheme.brand.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    role,
                    style: TextStyle(
                      color: PoimenTheme.brand,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                if (isDesktop) const SizedBox(height: 8),
                if (isDesktop)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 16,
                        color: PoimenTheme.textSecondary,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "Last active: Today",
                        style: TextStyle(
                          color: PoimenTheme.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Hero(
            tag: 'user-avatar',
            child: AvatarWithInitials(
              foregroundImage: picture.image,
              member: user,
              radius: isDesktop ? 50 : 45,
            ),
          ),
        ],
      );
    }

    // Mobile layout (more compact, vertical orientation)
    return Column(
      children: [
        Hero(
          tag: 'user-avatar',
          child: AvatarWithInitials(
            foregroundImage: picture.image,
            member: user,
            radius: 50,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          fullName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          decoration: BoxDecoration(
            color: PoimenTheme.brand.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            role,
            style: TextStyle(
              color: PoimenTheme.brand,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
