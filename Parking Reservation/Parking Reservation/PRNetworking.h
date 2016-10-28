//
//  PRNetworking.h
//  Parking Reservation
//
//  Created by Matt Mo on 10/26/16.
//  Copyright © 2016 Matt Mo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <Bolts/Bolts.h>

@interface PRNetworking : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *manager;

- (instancetype)init NS_UNAVAILABLE NS_DESIGNATED_INITIALIZER;
+ (instancetype)sharedInstance;

/**
 EP /parkinglocations/search

 @param options - a dictionary containing the following query parameters:
                    lat
                    lng

 @return BFTask - with:
                    result set to an array of ParkingLocationModel
                    error set to networking or json parsing error
 */
- (BFTask *)search:(NSDictionary *)options;


/**
 EP /parkinglocations/<id>/reserve

 @param parkingLocationID - id of the parking location to reserve
 @param options - a dictionary containing the following query parameters:
                    minutes -> Options number of minutes for which you want to reserve the spot for.

 @return BFTask - with:
                    result set to HTTP response from server
                    error set to networking error
 */
- (BFTask *)reserve:(int)parkingLocationID withOptions:(NSDictionary *)options;

@end
