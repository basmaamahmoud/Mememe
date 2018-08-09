# Mememe

## Description
- It is an app that takes pictures and overlays text to make memes out of friends, family, or pets.
- It allows sharing with others via social media or email, and viewing past memes in a table or collection view.

## Setup
- Core Data was used to store pictures.

## How to run it
- When you first launch the app the Sent Memes View will appear. When you tap the + button in the top right corner the app will push the Meme Editor View on top of the Sent Memes View.
- In the Meme Editor View, when you click on the “Album” button, an Image Picker is presented, making it possible to choose an image from the Photo Album. 
- If there is a camera available on the device, pressing the camera button launches the camera, and a newly snapped photo can be chosen for the meme. If a camera is not available on the device, the camera button is disabled.
- After an image is chosen, the image picker is dismissed, allowing text to be entered into the top and bottom text fields of the editor. When you click inside one of the text fields, the default text disappears and the keyboard slides up. When you finish entering text and press return, the keyboard is dismissed and the new meme is displayed.
- When you press the share button, Apple’s stock Activity View appears, displaying several options for sharing the meme. After an option is chosen, the Activity View is dismissed and the Sent Memes View appears. The Sent Memes View also appears upon pressing the “Cancel” button.
- Selecting a meme from the table or collection presents the Meme Detail View. Clicking on the  back arrow of the Meme Detail View presents the previous Sent Memes View, either the table or collection.  
