//
//  ParkingLocationModel.m
//  Parking Reservation
//
//  Created by Matt Mo on 10/27/16.
//  Copyright © 2016 Matt Mo. All rights reserved.
//

#import "ParkingLocationModel.h"

@interface ParkingLocationModel()

@property (nonatomic) NSString *costPerMin;
@property (nonatomic) int parkingLocationID;
@property (nonatomic) BOOL isReserved;
@property (nonatomic) NSString *latitude;
@property (nonatomic) NSString *longitude;
@property (nonatomic) int maxReserveTime;
@property (nonatomic) int minReserveTime;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *reservedUntil;

@end

@implementation ParkingLocationModel

#pragma mark - Mantle

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"costPerMin"          : @"cost_per_minute",
             @"isReserved"          : @"is_reserved",
             @"latitude"            : @"lat",
             @"longitude"           : @"lng",
             @"maxReserveTime"      : @"max_reserve_time_mins",
             @"minReserveTime"      : @"min_reserve_time_mins",
             @"name"                : @"name",
             @"parkingLocationID"   : @"id",
             @"reservedUntil"       : @"reserved_until",
             };
}

@end
