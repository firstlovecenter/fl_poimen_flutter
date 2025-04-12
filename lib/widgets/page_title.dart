import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/profile_choose/models_profile.dart';
import 'package:poimen/theme.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    Key? key,
    this.church,
    this.trailing,
    required this.pageTitle,
    this.showBackButton = true,
    this.onBackPressed,
    this.showSearchIcon = true,
    this.titleFontSize,
    this.subtitleFontSize,
    this.contentPadding,
    this.elevation = 0,
    this.centerTitle = false,
    this.isMobileLayout = true,
    this.maxTitleLength,
  }) : super(key: key);

  final ProfileChurch? church;
  final String pageTitle;
  final Widget? trailing;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final bool showSearchIcon;
  final double? titleFontSize;
  final double? subtitleFontSize;
  final EdgeInsetsGeometry? contentPadding;
  final double elevation;
  final bool centerTitle;
  final bool isMobileLayout;
  final int? maxTitleLength;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    final screenWidth = mediaQuery.size.width;
    final isTablet = screenWidth >= 600 && screenWidth < 900;
    final isDesktop = screenWidth >= 900;
    final isMobile = screenWidth < 600;

    // Force show back button on mobile if we can navigate back
    final canNavigateBack = Navigator.of(context).canPop();
    final shouldShowBackButton = (showBackButton && canNavigateBack);

    // Improved back button handling
    void handleBackNavigation() {
      if (onBackPressed != null) {
        onBackPressed!();
      } else if (canNavigateBack) {
        // Check if we should go to home instead of popping
        try {
          Navigator.of(context).pop();
        } catch (e) {
          // If pop fails, navigate to home as fallback
          Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
        }
      } else {
        // If we can't pop, navigate to home
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      }
    }

    // Dynamic font sizes based on device size
    final dynamicTitleSize = titleFontSize ??
        (isDesktop
            ? 22.0
            : isTablet
                ? 20.0
                : 18.0);
    final dynamicSubtitleSize = subtitleFontSize ??
        (isDesktop
            ? 16.0
            : isTablet
                ? 14.0
                : 13.0);

    // Determine colors based on theme
    final titleColor = isDarkMode ? Colors.white : Colors.black87;
    final subtitleColor = isDarkMode ? PoimenTheme.brandTextPrimary : PoimenTheme.textSecondary;

    // Format title to fit in app bar
    final formattedTitle = _formatTitle(pageTitle, maxTitleLength ?? (isMobile ? 20 : 30));

    // Use Material 3 styles for elevation and shadows
    final List<BoxShadow> titleElevation = elevation > 0
        ? [
            BoxShadow(
              color: isDarkMode ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.2),
              blurRadius: elevation * 2,
              offset: const Offset(0, 1),
            )
          ]
        : [];

    // Default page title without church context
    Widget title = ListTile(
      title: Text(
        formattedTitle,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: dynamicTitleSize,
          overflow: TextOverflow.ellipsis,
          color: titleColor,
        ),
        maxLines: 1,
      ),
      trailing: trailing,
      contentPadding: contentPadding ?? EdgeInsets.zero,
      leading: shouldShowBackButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: isDarkMode ? PoimenTheme.brand : Colors.black87,
                size: 24,
              ),
              onPressed: handleBackNavigation,
            )
          : null,
      dense: true,
    );

    // Enhanced page title with church context
    if (church != null) {
      // Generate a shorter church display for mobile
      final churchDisplay = isMobile ? church!.name : '${church?.name} ${church?.typename}';

      title = Material(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: titleElevation,
          ),
          child: ListTile(
            title: Text(
              formattedTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: dynamicTitleSize,
                overflow: TextOverflow.ellipsis,
                color: titleColor,
              ),
              maxLines: 1,
            ),
            subtitle: Text(
              churchDisplay,
              style: TextStyle(
                fontSize: dynamicSubtitleSize,
                color: subtitleColor,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            leading: shouldShowBackButton
                ? IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: isDarkMode ? PoimenTheme.brand : Colors.black87,
                      size: 24,
                    ),
                    onPressed: handleBackNavigation,
                  )
                : null,
            contentPadding: contentPadding ?? EdgeInsets.zero,
            trailing: trailing ??
                (showSearchIcon &&
                        ModalRoute.of(context)!.settings.name != '/search' &&
                        ModalRoute.of(context)!.settings.name != '/home'
                    ? InkWell(
                        borderRadius: BorderRadius.circular(30),
                        splashColor: PoimenTheme.brand.withOpacity(0.3),
                        highlightColor: PoimenTheme.brand.withOpacity(0.1),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            FontAwesomeIcons.magnifyingGlass,
                            size: 20,
                            color: isDarkMode ? PoimenTheme.brand : Colors.black54,
                          ),
                        ),
                        onTap: () {
                          // Add haptic feedback for a more interactive feel
                          HapticFeedback.lightImpact();
                          Navigator.pushNamed(context, '/search');
                        },
                      )
                    : null),
            dense: true,
          ),
        ),
      );
    }

    // Apply desktop-specific adjustments if needed
    if (!isMobileLayout && isDesktop) {
      // For desktop layout, you might want to adjust padding or width
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: title,
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(elevation > 0 ? 8 : 0),
      ),
      child: title,
    );
  }

  // Helper method to format titles to fit in app bar
  String _formatTitle(String title, int maxLength) {
    // If the title is already short enough, return as is
    if (title.length <= maxLength) {
      return title;
    }

    // Try to truncate at a space to avoid cutting words
    int lastSpaceIndex = title.substring(0, maxLength).lastIndexOf(' ');
    if (lastSpaceIndex > maxLength / 2) {
      return '${title.substring(0, lastSpaceIndex)}...';
    }

    // If no good truncation point found, just cut at maxLength
    return '${title.substring(0, maxLength)}...';
  }
}
