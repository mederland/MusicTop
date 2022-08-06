# Core Data Assignment

Create an application in MVVM that displays the top 100 in the Apple iTunes store with the attached link for Apple's RSS Generator. The application is to use a Tab Bar Controller to display two tabs. First tab is to show the top 100 albums from the api request. There needs to be 2 screens for the albums, the list and a detail screen. Both of them have a favorite button. When a album is favorited, it is stored in Core Data. The second tab is to show a list of only the favorited albums. Upon selecting an album, it will take you to a detail screen as well.

https://rss.itunes.apple.com/en-us


## Requirements

### General
    -App must be in MVVM Architecture
    -Implement a favoriting feature in the application to consistently save your favorite albums
    -Utilize Core data to implement a favorite feature. When selecting the favoriting button, you will save the info into Core data. When unfavorating, you will remove it from Core Data.
    -You need to utilize a UITabController for 2 main screens. The first being for the Network of the top 100 albums where you can select to favorite or unfavorite an album. The second tab is specifically just for the favorited albums.
    -Both sections when selecting a cell will take you to the same detail screen for the album info
    -Favoriting must persist across app launches and across all sections in the app.
    
### Main Screen
    -Main screen is to be a collection/tableview view displaying the image of the album, the title of the album, the artist name.
    -There should also be a small heart/star button on each cell on the bottom right to indicate if it has been favorited. Selecting the button will highlight/de-highlight it and store the album as a favorited Album in core data for persistence
    -Selecting the cell will navigate to the detail screen.
    -Reuse the same Viewcontroller and cells for both tabs, just different instances,
    -For the Favorite tab, still show the UI for the favorite button, but disable user interaction and "grey" it out to indicate to the user it is not selectable. The button should be fully function though on the top 100 tab.

### Detail Screen
    -Detail screen needs to show the album image, artist name, album name, list of genres, and date of release.
    -Release date needs to be formatted in the format example of "January 12, 2020"
    -Favorite button needs to be on screen on the bottom in the center, allowing for favoriting and still showing persistence

### Other
    -Make the Network layer generic
    
### Hint
    -Think about the different design patterns we went through in class. Particularly the ones I requested you to write a paragraph on

