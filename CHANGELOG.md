#### 0.2.1 (2023-02-27)

##### Chores

*  incrememnt version number (c15162d3)
*  increase build number (2e2021a5)
*  update package dependencies for flutter 3.7 (039c2e5b)
*  version bump (ded745ed)
*  version  bump (60572261)
*  version bump (0ba9a27e)
*  version bump (61b0cea5)
*  version bump and update env constants (56b46c93)
*  set up permissions for flutter client to receive location (d1477bfe)

##### New Features

*  implement logging visitation button on idl screen (02681ed8)
*  revision for app submission guidelines (8a4ff925)
*  implement visitation logging for council level (5b99e15d)
*  implement logging visitation activity for fellowship level (3a98a018)
*  implement logging telepastoring activity for council (d851d993)
*  implement logging telepastoring activity for fellowship (4af5ea30)
*  implement logging prayer activity for council level (e08c2407)
*  implement logging prayer activity for constituency level (44ad5cf2)
*  implement search for all church levels (c425ff93)
*  implement search feature for fellowship level (87b95be7)
*  implement search form with text field (579d43c2)
*  implement scaffold for search page (5824e57c)
*  edit page title to add a permanent search icon to the right (ca75fd15)
*  implement feature for logging outstanding prayer (9b44abe0)
*  change app icon to reflect new design (b22e410d)
*  implement outstanding duties for constituency level (de891277)
*  implement outstanding visitation for constituency level (ab4e8af1)
*  implement  home screen with duties on constituency level (9c55c795)
*  implement outstanding telepastoring for bacenta level (acfac7e0)
*  implement outstanding visitation for bacenta level (d8a70262)
*  implement outstanding telepastoring with report form (dd93c127)
*  update outstanding duties numbers to live data (4f131c61)
*  implement completed visitations list screen (4f6e883c)
*  implement completed visits card on outstanding visitation page (42b045de)
*  implement visitation form in the flutter client (52709540)
*  implement button and bottom modal form filling visit report (a1ccad35)
*  implement button and bottom modal form filling visit report (4f5c4400)
*  implement outstanding visitation counter on home screen (7b79a12f)
*  implement all pastoral comments screen which shows 10 latest comments (e874c652)
*  implement feature such that a user can only see comments they are permitted to see (e180306b)
*  add divider for pastoral comments (77e7760c)
*  implement pastoral comments on member page (90e0e1e8)
*  implement dumb pastoral comments section on member profile (12d2fb93)
*  implement functionality to store church level permission in frontend (42feac76)
*  add buttons for outstanding work on home page (3cba677c)
*  implement understanding schools tracking feature (b2fae0c9)
*  implement attendance ticker for fellowships on sunday (fcd7ef5b)
*  implement viewing of bussing services on fellowship profile (c4bfaf15)
*  change attendance monitoring to last6 services (011d0ca7)
*  implement feature for leaders to fill bible translation upgrade for members (3021c2e5)
*  implement form to fill audio collection upgrade (51762ff0)
*  implement form for recording water baptism member upgrade (ccfea157)
*  implement form for recording holyGhost baptism date (bb3b358d)
*  implement page for inputting hg baptism date (5627c8e2)
*  implement conditional navigation for member upgrades page (aec4b958)
*  implement membership upgrade screen with live data (c1fdc44a)
*  implement member avatar on membership upgrades page (4f982f62)
*  implement member class in provider (fbc603ed)
*  implement membership upgrade page (0ecdc3fa)

##### Bug Fixes

*  increase image size returned from cloudinary to increase sharpness (55e3e310)
*  fix blurry pictures on attendance carousel (78e2a300)
*  fix bug where MarkedAttendance doesn't allow a second fellowship to also fill (bd5b16ae)
*  version bump (ae9e5820)
*  return pastoral comments for each member upgrade (92bd2188)
*  return comments after membership upgrades (41275103)
*  minor cosmetic changes to colors (34071365)
*  minor cosmetic changes to light annd dark mode (aa15dcf8)
*  removed persistent location from android permissions (1a62f896)
*  breaking bug on android (48d62f8a)
*  update deprecated synntax (d5776096)
*  fix bug in nav menu highlighting wrong  icon (6f4dfc50)
*  correct colors of text on light mode login screen (abf678ad)
*  a few minor improvements for different ios screen sizes (856e4057)
*  add phoneNumber and whatsappNumber to pages  to prevent breaking the UI (a5c23ea2)
*  add phonenumber and whatspp number  to properties being returned (77128aa4)
*  member tile in search screen phone and whatsaspp working (03452772)
*  update gql queries for prayer report form (4864ad19)
*  improve flow for member upgrade forms (97d41fd2)
*  update submit flow for member upgrades (bc8adb33)
*  update form submission flow for attendance forms (df542de0)
*  update form submission flow for pastoral duties (e3476f7a)
*  remove unnecessary print statements (7394bde7)
*  fix bugs in submitting recordPrayer (7cbde516)
*  improve AlertBox to show title also (43a6664f)
*  increase height of sized box for visitation report form (9cd65b86)
*  improve light mode colours for colorBlockTile and Page title (6ffc3d99)
*  update graphql_flutter package (0325772d)
*  remove redundant bits of code (948df2a2)
*  fix code for whatsapp and phone call to work more consistently (f4ff0c53)
*  update route for service record report (d95bb5dd)
*  update color of deer pill (8f064658)
*  change keyboard dismiss behaviour for visitation form (0559ee15)
*  change color of splash screen and primarySwatch (a9d7ae16)
*  update app icon images that were breaking  build (d5d88f34)
*  remove search icon in page title when on home page (338cb816)
*  fix bug breaking home screen on stream and gatheringservice levels (74f4c716)
*  fix typo pastoral comments page title (960879cf)
*  update bottom menu bar on outstanding prayer (084de98d)
*  remove unnecessary app icon dependency in pubspec.yaml (ecc2c3ab)
*  remove bacenta from profile selection page (d0247cae)
*  fix constituency outstanding telepastoring duties (ea203f52)
*  add a little padding in profile choose (897ce160)
*  change splash screen color to match new color scheme (d335b13c)
*  change  imcl to  IMCL uppercase (9fd0e8ec)
*  switch numbers from outstanding visit to completed (a3830468)
*  tidy up menu bars for duties and attendances (8821719d)
*  adjust alignment for pastoral comments (ee04e102)
*  minor tweaks to enable pastoral comments with roles (48bf9484)
*  update pastoral comments to include role level (8bbafa41)
*  implement camp attendance tracking for members (80dcd173)
*  complete flow for sunday attendance for fellowships with reports (e959c765)
*  complete flow for sunday attendance for fellowships (eeea130c)
*  change from monitoring last 4 services to last 6 services (9c75ce6b)
*  update spinning logo to the red color (8f6d8ace)
*  handles error when there are no service records for a fellowship (97ed7306)
*  implement membership upgrade button (9928d79b)
*  implement mutation that creates the cycle node if not exists (9ce6a4ae)
*  remove loader from short lists in member pagination (e116418b)

##### Refactors

*  extract submittingButtonText to a widget (4ad783e8)
*  moved duties folder into screens folder (08f4029d)
*  move imcl folder to a separate pastoral duties folder (21cea70e)
*  move upgrade folder to be in membership folder (fc66d31d)
*  refactored attendance code for better error handling (3c98329c)

### 0.2.0 (2022-10-23)

##### Chores

*  version bump (7325ad25)
*  version bump (b7987f06)
*  version bump (dc7ee2c4)
*  update pubspec.yaml (22d5f271)
*  update packages to work on macbook pro (a4c1ee9a)

##### Documentation Changes

*  update readme and bump version for testers (e3bfe0f2)

##### New Features

*  implement pagination for all church levels (9728d418)
*  implement pagination for stream member list (6b59e1c2)
*  implement pagination for gathering service member list (4bff3591)
*  implement light mode colors for Poimen App so far (42545be9)
*  poimen-76 implement submitting of imcl report (61f6814e)
*  implement feature where pictures uploaded in admin portal are used for membership pictures (e02ca806)
*  implement Klenams UX for the back buttons (8c742ac1)
*  implement final touches on drilling down from gathering service (f86a82df)
*  implement drilling downwards from gathering service to constituency (74e0f281)
*  implement phone and whatsapp of defaulters on sub church grouping page (a9149e6b)
*  implement display of council by constituency defaulters this week (013a5725)
*  implement imcl total card on higher church levels (335f7880)
*  implement new icons for menu navigation (7b3e176f)
*  implement missing persons call screen for fellowship and bacentas (5cb11fd4)
*  implement configurations for deployment to apple and android app stores (c5f6f5c2)
*  implement defaulters scresn for all church levels (9afb4e54)
*  implement highlight bottom nav bar selected item (45598928)
*  implement constituency fellowship defaulters menu page (900c9cea)
*  implement constituency defaulters menu page (e9243018)
*  scaffold constituency defaulters page (07f080e2)
*  implement shared dynamic bottom nav bar (2f6e0752)
*  implement feature to compute member status as forms are being filled (28f52601)
*  implement attendance ticking functionality for fellowships (102c93e8)
*  implement attendance report page and green buttons on member details (529baa4e)
*  implement scaffold for building attendance report screen (513b9b6e)
*  implement build config for running app on external phone (585aa0d2)
*  implement attendance submission for bacenta bussing (71cc4b38)
*  implement splash screen for android and ios (c2338b09)
*  implement styling of attendance ticker (b4b4d28b)
*  implement list of members on Bacenta Attendance Ticker Screen (0ca5e836)
*  implement services list screen for bacenta and fellowship (837010fb)
*  implement phone call and whatsapp buttons on member details page (ca4a5b38)
*  implement idl screen which includes call and whatsapp functionality (44673615)
*  finish implementation of member details page (b569a831)
*  implement 50% of member details page (0b28fb18)
*  implement 50% of member details page (f21d4707)
*  implement styling for membership list (69312227)
* **pastoral-cycle:**  implmemented countdown timer for pastoral cycles (e1a61b42)
* **login:**  implement login animation (e69c5f5a)

##### Bug Fixes

*  minor improvements for infinite pagination (104a7f61)
*  improved error handling in some scenarios (53f5bc3e)
*  minor improvments and clean up (39f5acf1)
*  tweak helper functions to help with gql queries (561f3a6a)
*  implement pagination in graphql with flutter client (141979fa)
*  touch up light mode colours on member details page (97560bee)
*  refactor homescreen queries and split them up (ecb4a5c3)
*  implement minor ux improvements (f78004e3)
*  adjust padding on login button (5af64c7f)
*  clicking navigation for the same screen that you are on no longer navigates there (7fc1d268)
*  change loading ux of profile choose page to pass apple verification (442aea95)
*  add padding so that keyboard doesn't cover bottom sheet for imcl report (87c65a55)
*  made loadng icon smaller and more pleasing to the eye (223f0166)
*  update initial load on profile choosing screen (71ec1c6b)
*  add padding to button on servicereport page (971f1d93)
*  add padding for date summaries (0ab0a8b8)
*  increase font size on defaulters church by subchurch (68ca72a5)
*  pop navigation stack when returning to services list (008efcbf)
*  minor improvements to imcl screen (cf022d89)
*  implement dark mode regardless of what the user selects (fe3ad23d)
*  improve the ux of the bottom nav bar (041cc179)
*  implement selectedIndex for bottomNavigationBar using changenotifier (a54bb2b9)
*  implement cloudinary image view in attendance report (149e6165)
*  implement image upload with cloudinary for bacenta attendance ticker (445d2108)
*  switch from using the serviceDate object to using the createdAt property (3670b510)
*  change gender from const value to dynamic (e87f5af1)
*  update membership list widget to show number of members (19ba814c)
*  remove red screen of annoyance showing that null check was used on null value (307f5077)

##### Performance Improvements

*  moving countdown details to the DB instead of frontend (d4c5088a)
*  resolve all dart console problems (5f875a18)
*  implement cache invalidation on the flutter client (e734a4f0)
*  improve error message handling (52797777)

##### Refactors

* **pastoral-cycle:**  extract countdown widget to separate file (4c1714b2)
*  implement enum values for churchlevels in a†tendance menus (122d7d51)
*  tidy up home screen and add user details (2f36c73b)
*  change deprecated FlatButton to TextButton (8860ffd5)
*  implement stronger typing and named parameters on GQL container (488c7abf)
*  implement a gql container widget (f74affce)

### 2022-09-03

##### Chores

*  remove desktop platforms code bloating project (82ee87a7)
*  update the dependencies (c3322239)
*  update gitignore file (eb84af64)

##### Continuous Integration

*  remove files in gitignore (7c54d1de)
*  update gitignore file (6fe70edf)
*  update husky config (7dcdd881)
*  update husky config (9e28a10e)
*  added npm packages to lint commit messages (aaea4733)

##### Documentation Changes

*  update tooling for generating releases (1f20705e)
*  update CHANGELOG.md (c830a1dd)
*  update CHANGELOG.md (1d43e8c6)
*  update CHANGELOG.md (8c38ab70)
*  update CHANGELOG.md (545d6186)
*  update readme (095fd5fe)

##### New Features

*  implement membership list screens for all church levels (5f2d6155)
*  implement fellowship members screen (599d5c3d)
*  implement member names showing in membership list (9864596e)
*  implement fellowship membership list scaffold (b7672efd)
*  implement custom app icon (3d35e19a)
*  implement choosing of profile and navigating home screen (109e26b9)
*  implement  global user state object  on pages (821c108d)
*  implement provider state management tool to track the church level on profile choose page (28226a45)
*  poimen-50 implement gql integration so that a user can see his different profiles (97daf218)
*  sorry attempts at layout design for home page (8a352d4b)
*  implement grid view for profile choose screen (5072d0fa)
*  implement basic splash screen (638330d6)
*  add a drawer to the flutter home page (0708a74f)
*  add npm run api to  package.json (6244f0ed)
*  implement auth0 login functionality (7b2fd287)
*  recreate project with the flutter starter (39298084)
*  initial commit (92716e60)

##### Bug Fixes

*  implement conditional rendering of attendance button on home page (5463c026)
*  create an app container component and implement some basic named routing (4d8bca35)

### 2022-09-03

##### Chores

*  remove desktop platforms code bloating project (82ee87a7)
*  update the dependencies (c3322239)
*  update gitignore file (eb84af64)

##### Continuous Integration

*  remove files in gitignore (7c54d1de)
*  update gitignore file (6fe70edf)
*  update husky config (7dcdd881)
*  update husky config (9e28a10e)
*  added npm packages to lint commit messages (aaea4733)

##### Documentation Changes

*  update CHANGELOG.md (c830a1dd)
*  update CHANGELOG.md (1d43e8c6)
*  update CHANGELOG.md (8c38ab70)
*  update CHANGELOG.md (545d6186)
*  update readme (095fd5fe)

##### New Features

*  implement membership list screens for all church levels (5f2d6155)
*  implement fellowship members screen (599d5c3d)
*  implement member names showing in membership list (9864596e)
*  implement fellowship membership list scaffold (b7672efd)
*  implement custom app icon (3d35e19a)
*  implement choosing of profile and navigating home screen (109e26b9)
*  implement  global user state object  on pages (821c108d)
*  implement provider state management tool to track the church level on profile choose page (28226a45)
*  poimen-50 implement gql integration so that a user can see his different profiles (97daf218)
*  sorry attempts at layout design for home page (8a352d4b)
*  implement grid view for profile choose screen (5072d0fa)
*  implement basic splash screen (638330d6)
*  add a drawer to the flutter home page (0708a74f)
*  add npm run api to  package.json (6244f0ed)
*  implement auth0 login functionality (7b2fd287)
*  recreate project with the flutter starter (39298084)
*  initial commit (92716e60)

##### Bug Fixes

*  implement conditional rendering of attendance button on home page (5463c026)
*  create an app container component and implement some basic named routing (4d8bca35)

### 2022-09-03

##### Chores

*  remove desktop platforms code bloating project (82ee87a7)
*  update the dependencies (c3322239)
*  update gitignore file (eb84af64)

##### Continuous Integration

*  remove files in gitignore (7c54d1de)
*  update gitignore file (6fe70edf)
*  update husky config (7dcdd881)
*  update husky config (9e28a10e)
*  added npm packages to lint commit messages (aaea4733)

##### Documentation Changes

*  update CHANGELOG.md (1d43e8c6)
*  update CHANGELOG.md (8c38ab70)
*  update CHANGELOG.md (545d6186)
*  update readme (095fd5fe)

##### New Features

*  implement membership list screens for all church levels (5f2d6155)
*  implement fellowship members screen (599d5c3d)
*  implement member names showing in membership list (9864596e)
*  implement fellowship membership list scaffold (b7672efd)
*  implement custom app icon (3d35e19a)
*  implement choosing of profile and navigating home screen (109e26b9)
*  implement  global user state object  on pages (821c108d)
*  implement provider state management tool to track the church level on profile choose page (28226a45)
*  poimen-50 implement gql integration so that a user can see his different profiles (97daf218)
*  sorry attempts at layout design for home page (8a352d4b)
*  implement grid view for profile choose screen (5072d0fa)
*  implement basic splash screen (638330d6)
*  add a drawer to the flutter home page (0708a74f)
*  add npm run api to  package.json (6244f0ed)
*  implement auth0 login functionality (7b2fd287)
*  recreate project with the flutter starter (39298084)
*  initial commit (92716e60)

##### Bug Fixes

*  implement conditional rendering of attendance button on home page (5463c026)
*  create an app container component and implement some basic named routing (4d8bca35)

### 2022-09-03

##### Chores

*  remove desktop platforms code bloating project (82ee87a7)
*  update the dependencies (c3322239)
*  update gitignore file (eb84af64)

##### Continuous Integration

*  remove files in gitignore (7c54d1de)
*  update gitignore file (6fe70edf)
*  update husky config (7dcdd881)
*  update husky config (9e28a10e)
*  added npm packages to lint commit messages (aaea4733)

##### Documentation Changes

*  update CHANGELOG.md (8c38ab70)
*  update CHANGELOG.md (545d6186)
*  update readme (095fd5fe)

##### New Features

*  implement membership list screens for all church levels (5f2d6155)
*  implement fellowship members screen (599d5c3d)
*  implement member names showing in membership list (9864596e)
*  implement fellowship membership list scaffold (b7672efd)
*  implement custom app icon (3d35e19a)
*  implement choosing of profile and navigating home screen (109e26b9)
*  implement  global user state object  on pages (821c108d)
*  implement provider state management tool to track the church level on profile choose page (28226a45)
*  poimen-50 implement gql integration so that a user can see his different profiles (97daf218)
*  sorry attempts at layout design for home page (8a352d4b)
*  implement grid view for profile choose screen (5072d0fa)
*  implement basic splash screen (638330d6)
*  add a drawer to the flutter home page (0708a74f)
*  add npm run api to  package.json (6244f0ed)
*  implement auth0 login functionality (7b2fd287)
*  recreate project with the flutter starter (39298084)
*  initial commit (92716e60)

##### Bug Fixes

*  implement conditional rendering of attendance button on home page (5463c026)
*  create an app container component and implement some basic named routing (4d8bca35)

### 2022-09-03

##### Chores

*  remove desktop platforms code bloating project (82ee87a7)
*  update the dependencies (c3322239)
*  update gitignore file (eb84af64)

##### Continuous Integration

*  remove files in gitignore (7c54d1de)
*  update gitignore file (6fe70edf)
*  update husky config (7dcdd881)
*  update husky config (9e28a10e)
*  added npm packages to lint commit messages (aaea4733)

##### Documentation Changes

*  update CHANGELOG.md (545d6186)
*  update readme (095fd5fe)

##### New Features

*  implement membership list screens for all church levels (5f2d6155)
*  implement fellowship members screen (599d5c3d)
*  implement member names showing in membership list (9864596e)
*  implement fellowship membership list scaffold (b7672efd)
*  implement custom app icon (3d35e19a)
*  implement choosing of profile and navigating home screen (109e26b9)
*  implement  global user state object  on pages (821c108d)
*  implement provider state management tool to track the church level on profile choose page (28226a45)
*  poimen-50 implement gql integration so that a user can see his different profiles (97daf218)
*  sorry attempts at layout design for home page (8a352d4b)
*  implement grid view for profile choose screen (5072d0fa)
*  implement basic splash screen (638330d6)
*  add a drawer to the flutter home page (0708a74f)
*  add npm run api to  package.json (6244f0ed)
*  implement auth0 login functionality (7b2fd287)
*  recreate project with the flutter starter (39298084)
*  initial commit (92716e60)

##### Bug Fixes

*  implement conditional rendering of attendance button on home page (5463c026)
*  create an app container component and implement some basic named routing (4d8bca35)

### 2022-09-03

##### Chores

*  remove desktop platforms code bloating project (82ee87a7)
*  update the dependencies (c3322239)
*  update gitignore file (eb84af64)

##### Continuous Integration

*  remove files in gitignore (7c54d1de)
*  update gitignore file (6fe70edf)
*  update husky config (7dcdd881)
*  update husky config (9e28a10e)
*  added npm packages to lint commit messages (aaea4733)

##### Documentation Changes

*  update readme (095fd5fe)

##### New Features

*  implement membership list screens for all church levels (5f2d6155)
*  implement fellowship members screen (599d5c3d)
*  implement member names showing in membership list (9864596e)
*  implement fellowship membership list scaffold (b7672efd)
*  implement custom app icon (3d35e19a)
*  implement choosing of profile and navigating home screen (109e26b9)
*  implement  global user state object  on pages (821c108d)
*  implement provider state management tool to track the church level on profile choose page (28226a45)
*  poimen-50 implement gql integration so that a user can see his different profiles (97daf218)
*  sorry attempts at layout design for home page (8a352d4b)
*  implement grid view for profile choose screen (5072d0fa)
*  implement basic splash screen (638330d6)
*  add a drawer to the flutter home page (0708a74f)
*  add npm run api to  package.json (6244f0ed)
*  implement auth0 login functionality (7b2fd287)
*  recreate project with the flutter starter (39298084)
*  initial commit (92716e60)

##### Bug Fixes

*  implement conditional rendering of attendance button on home page (5463c026)
*  create an app container component and implement some basic named routing (4d8bca35)

