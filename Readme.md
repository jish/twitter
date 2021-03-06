
#### How many hours did it take to complete?

Phase1: About 10 hours

Phase2: About 6 hours

#### Stories

##### Phase 1

- [x] User can sign into Twitter using the OAuth 1.0a workflow
- [x] User can view the latest 20 tweets from their timeline
- [x] The current signed in user will be persisted across restarts
- [x] In the home timeline the user can view:
  - [x] The user profile picture
  - [x] Username
  - [x] Tweet text
  - [x] Timestamp
- [x] User can pull to refresh
- [x] User can compose a new tweet by tapping on a compose button
- [x] User can tap on a tweet to view it, with controls to:
  - [x] Retweet the tweet
  - [x] Favorite the tweet
  - [x] Reply to the tweet

##### Phase 2

- [x] Add a hamburger menu
  - [x] Dragging anywhere in the view should reveal the menu
- [x] Create a profile page which contains:
  - [x] User header view
  - [x] Basic user stats
    - [x] Number of tweets
    - [x] Number of followers
    - [x] Number following
- [x] Tapping on an image in the home timeline brings up that users profile

#### GIF Walkthrough

Walthrough of initial functionality

![Twitter GIF Walkthrough](twitter.gif)

Walkthrough of hamburger menu and profile page enhancement

![Twitter GIF Walkthrough Hamburger Menu](twitter2.gif)

#### Open source software used:

* [Cocoa Pods][1]
* [AFNetworking][2]
* [BDBOAuth1Manager][3]

#### License

[MIT](License)

[1]: http://cocoapods.org/
[2]: http://afnetworking.com/
[3]: https://github.com/bdbergeron/BDBOAuth1Manager
