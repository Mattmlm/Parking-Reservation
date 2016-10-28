//
//  ParkingLocationAnnotation.m
//  Parking Reservation
//
//  Created by Matt Mo on 10/27/16.
//  Copyright © 2016 Matt Mo. All rights reserved.
//

#import "ParkingLocationAnnotation.h"

@interface ParkingLocationAnnotation()

@property (nonatomic) CLLocationCoordinate2D coordinate;

@end

@implementation ParkingLocationAnnotation

- (instancetype)initWithParkingLocation:(ParkingLocationModel *)parkingLocation
{
    if (self = [super init]) {
        CLLocationDegrees latitude = [parkingLocation.latitude doubleValue];
        CLLocationDegrees longitude = [parkingLocation.longitude doubleValue];
        CLLocationCoordinate2D parkingCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
        self.coordinate = parkingCoordinate;
    }
    
    return self;
}

@end
