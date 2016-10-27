//
//  BaseModel.m
//  Parking Reservation
//
//  Created by Matt Mo on 10/27/16.
//  Copyright © 2016 Matt Mo. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

#pragma mark - MTLJSONSerializing
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}

#pragma mark - Helpers

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionaryValue
{
    NSError *error;
    id model = [super modelWithDictionary:dictionaryValue error:&error];
    
    if (error) {
        return nil;
    } else {
        [model setOriginalJSON:dictionaryValue];
    }
    
    return model;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error
{
    self = [super initWithDictionary:dictionaryValue error:error];
    return self ?: nil;
}

//+ (NSArray *)getModelsFromArray:(NSArray *)array
//{
//    NSString *modelName = NSStringFromClass([self class]);
//    
//    if ([modelName isEqualToString:NSStringFromClass([BaseModel class])]) {
//        return nil;
//    }
//    
//    NSMutableArray *mutableArray = [NSMutableArray new];
//    for (id json in array) {
//        NSDictionary *dict = [json copy];
//        id model = [NSClassFromString(modelName) modelWithDictionary:dict];
//        [mutableArray addObject:model];
//    }
//    
//    return [mutableArray copy];
//}

@end
