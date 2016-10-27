//
//  ParkingLocationModel.h
//  Parking Reservation
//
//  Created by Matt Mo on 10/27/16.
//  Copyright © 2016 Matt Mo. All rights reserved.
//

#import "BaseModel.h"

@interface ParkingLocationModel : BaseModel

@property (readonly, nonatomic) NSString *costPerMin;
@property (readonly, nonatomic) int parkingLocationID;
@property (readonly, nonatomic) BOOL isReserved;
@property (readonly, nonatomic) NSString *latitude;
@property (readonly, nonatomic) NSString *longitude;
@property (readonly, nonatomic) int maxReserveTime;
@property (readonly, nonatomic) int minReserveTime;
@property (readonly, nonatomic) NSString *name;
@property (readonly, nonatomic) NSString *reservedUntil;

@end
