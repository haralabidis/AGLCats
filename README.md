# AGLCodeTest
A simple iOS app that retrieves a list of pets and their owners from an API. 
It displays cat names in an alphabetical order grouped by owner gender.

## App Requirements
Requirements:

App is to integrate with an API to fetch people and pet data information, link below.
http://agl-developer-test.azurewebsites.net/people.json

Create a listing screen listing all the cats in alphabetical order under a heading of the gender of their owner.


## UI Design
Minimal UI design was applied in order to keep this app clean and simple.

No app icons were generated as this was beyod the point of this exersice.

## Code Structure

### Networking
A Network / service class for fetching API data and serialising into models. The class utilises protocol delegation instead of closures. This was selected to provide clarity in the code, and because the class may be used under different contexts.

All models are codable and networking was performed with the use of URLSession to avoid any dependencies on third party libraries.

### View models
All service models were transormed to view model that match the app requirements.

### Data Store
Data is stored in memory within a datasource class that also enables delegation via protocol.

### List view
A simple table view with two sections utilising an activity indicator.

### UI Layout
Auto layout :)

## Testing
I added a couple of unit in the app, code coverage is quie low but I wanted to keep this exercise short. 
I created mock classes with depedency injection for Networking tests.
Stub data was also included for testing networking and serialisation of json to models.

Given the simplicity of the design and the lack of user interaction, I only added a single UI test to verify that the main table contains data.

## Further steps
Please let me know if you would like me to extend on any of the app features or tests.
