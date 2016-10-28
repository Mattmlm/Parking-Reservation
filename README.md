# Parking-Reservation

## Setup instructions
Options
1) Build yourself
2) Download through Fabric

### Build yourself
1) Clone the repo
2) Open up .xcworkspace project file
3) Build the app, this should run as is.

### Download through Fabric
Email me, and I can distribute a build through Fabric.

## Known bugs

- Duplicate pins are added
- After reserving a spot, the map is not updated
- There is no view available, to see already reserved spots
- UIAlert is used instead of separate UIViewControllers to separate out experience
- There is no flow for making a reservation and further adding details

## Further Polish Items

- Add the ability to search the map for the place you want to reserve a parking spot
- Fix duplicate pins
- Update and refresh map data according to reservations, etc.
- After reserving, reserved spot should be highlighted as a special pin
- User should be able to specify how long they want to reserve for

## Problem Statement:
Design a street parking reservation app.

## Problem Description:
X View all available street parking spots on a map.
X Select a parking spot to see more information about the spot
  X Spot name
  X Spot number
  X Per minute charge
X Reserve a parking spot.
X Option to extend reservation after the initial reservation time elapse.
X See a summary of the reservation at the end of the reservation duration.

## Bonus
X Distribution of app through Testflight/Fabric or one of the beta distribution
systems.

## Assumptions:
- App is for the city of San Francisco
- User has an account and is logged in.
- User has a payment method configured in their account

