import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/widgets/loading_screen.dart';
import 'package:poimen/widgets/page_title.dart';

class GQLQueryContainer extends StatefulWidget {
  final dynamic query;
  final Map<String, dynamic> variables;
  final String defaultPageTitle;
  final Function bodyFunction;
  final Widget? bottomNavBar;
  final bool? infiniteScroll;
  final Widget? loadingWidget;
  final List<Widget>? actions;
  final bool? centerTitle;
  final double? elevation;
  final Widget? leading;
  final bool? automaticallyImplyLeading;
  final Color? backgroundColor;
  final VoidCallback? onBackPressed;

  const GQLQueryContainer({
    Key? key,
    required this.query,
    required this.variables,
    required this.defaultPageTitle,
    required this.bodyFunction,
    this.infiniteScroll,
    this.bottomNavBar,
    this.loadingWidget,
    this.actions,
    this.centerTitle,
    this.elevation,
    this.leading,
    this.automaticallyImplyLeading =
        false, // Changed default to false to avoid duplicate back buttons
    this.backgroundColor,
    this.onBackPressed,
  }) : super(key: key);

  @override
  State<GQLQueryContainer> createState() => _GQLQueryContainerState();
}

class _GQLQueryContainerState extends State<GQLQueryContainer> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    final screenWidth = mediaQuery.size.width;
    final isTabletOrLarger = screenWidth > 600;

    // Safe navigation method
    void handleBackNavigation() {
      if (widget.onBackPressed != null) {
        widget.onBackPressed!();
      } else if (Navigator.of(context).canPop()) {
        try {
          Navigator.of(context).pop();
        } catch (e) {
          debugPrint('Navigation error: $e');
          // Fallback to home if there's an error
          Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
        }
      } else {
        // If we can't pop, go to home
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      }
    }

    return Query(
      options: QueryOptions(document: widget.query, variables: widget.variables),
      builder: (
        QueryResult result, {
        VoidCallback? refetch,
        FetchMore? fetchMore,
      }) {
        Widget? pageTitle = widget.defaultPageTitle.isNotEmpty
            ? Text(
                widget.defaultPageTitle,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black87,
                  fontSize: isTabletOrLarger ? 22 : 20,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1, // Ensure the title doesn't wrap to multiple lines
              )
            : null;
        Widget body;

        if (result.hasException) {
          body = _handleQueryError(result.exception);
        } else if (widget.infiniteScroll != true && (result.isLoading || result.data == null)) {
          body = widget.loadingWidget ?? const LoadingScreen();
        } else {
          // Handle both old and new function signatures to maintain backward compatibility
          GQLQueryContainerReturnValue res;

          try {
            // Try new signature with fetchMore
            res = widget.bodyFunction(result.data, fetchMore);
          } catch (e) {
            try {
              // Fall back to old signature without fetchMore
              res = widget.bodyFunction(result.data);
            } catch (e2) {
              // If both fail, show error
              body = _handleQueryError("Error calling bodyFunction: $e2");
              return Scaffold(
                appBar: pageTitle != null
                    ? AppBar(
                        title: pageTitle,
                        centerTitle: widget.centerTitle ?? (isTabletOrLarger ? true : false),
                        elevation: widget.elevation ?? 2,
                        backgroundColor: widget.backgroundColor,
                        // Custom back button with fallback logic - only show if explicitly set
                        leading: widget.leading ??
                            (widget.automaticallyImplyLeading == true
                                ? IconButton(
                                    icon: const Icon(Icons.arrow_back),
                                    onPressed: handleBackNavigation,
                                  )
                                : null),
                        automaticallyImplyLeading: widget.automaticallyImplyLeading ?? false,
                        actions: widget.actions,
                      )
                    : null,
                body: body,
                bottomNavigationBar: widget.bottomNavBar,
              );
            }
          }

          pageTitle = res.pageTitle;
          body = res.body;
        }

        return WillPopScope(
          onWillPop: () async {
            // Try to handle the back button press in a controlled way
            handleBackNavigation();
            // Prevent the default behavior which might cause the white screen
            return false;
          },
          child: Scaffold(
            appBar: pageTitle != null
                ? AppBar(
                    title: pageTitle,
                    titleSpacing: 0, // Reduce spacing to fit longer titles
                    centerTitle: widget.centerTitle ?? (isTabletOrLarger ? true : false),
                    elevation: widget.elevation ?? (isDarkMode ? 0 : 1),
                    backgroundColor: widget.backgroundColor,
                    // Custom back button with fallback logic - only show if explicitly requested
                    leading: widget.leading,
                    automaticallyImplyLeading: widget.automaticallyImplyLeading ?? false,
                    actions: widget.actions,
                    shape: widget.elevation == 0
                        ? null
                        : const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(10),
                            ),
                          ),
                  )
                : null,
            body: body,
            bottomNavigationBar: widget.bottomNavBar,
          ),
        );
      },
    );
  }

  Widget _handleQueryError(dynamic error) {
    String errorMessage = 'An unknown error occurred';

    if (error is OperationException) {
      if (error.linkException != null) {
        errorMessage = 'Network error: ${error.linkException.toString()}';
      } else if (error.graphqlErrors.isNotEmpty) {
        errorMessage = 'GraphQL error: ${error.graphqlErrors.map((e) => e.message).join(", ")}';
      }
    } else {
      errorMessage = 'Error: ${error.toString()}';
    }

    debugPrint('GQLQueryContainer error: $errorMessage');

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // Refresh the query by rebuilding the widget
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class GQLQueryContainerReturnValue {
  final PageTitle? pageTitle;
  final Widget body;

  GQLQueryContainerReturnValue({this.pageTitle, required this.body});
}
