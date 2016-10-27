//
//  BaseModel.h
//  Parking Reservation
//
//  Created by Matt Mo on 10/27/16.
//  Copyright © 2016 Matt Mo. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseModel : MTLModel <MTLJSONSerializing>

@property NSDictionary *originalJSON;

+ (nullable instancetype)modelWithDictionary:(NSDictionary *)dictionaryValue;

//+ (NSArray *)getModelsFromArray:(NSArray <NSDictionary *>*)array;

@end

NS_ASSUME_NONNULL_END
