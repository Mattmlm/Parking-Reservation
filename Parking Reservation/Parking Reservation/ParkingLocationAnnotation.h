//
//  ParkingLocationAnnotation.h
//  Parking Reservation
//
//  Created by Matt Mo on 10/27/16.
//  Copyright © 2016 Matt Mo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParkingLocationModel.h"
@import MapKit;

@interface ParkingLocationAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (instancetype)initWithParkingLocation:(ParkingLocationModel *)parkingLocation;

@end
