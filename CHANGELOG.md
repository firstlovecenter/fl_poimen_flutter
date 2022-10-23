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

