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

 @param options - a dictionary containing the following query parameters
                    lat
                    lng

 @return task with result set to 
 */
- (BFTask *)search:(NSDictionary *)options;

@end
