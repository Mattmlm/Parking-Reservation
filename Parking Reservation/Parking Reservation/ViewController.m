//
//  ViewController.m
//  Parking Reservation
//
//  Created by Matt Mo on 10/26/16.
//  Copyright © 2016 Matt Mo. All rights reserved.
//

#import "ViewController.h"
#import "PRNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    BFTask *task = [[PRNetworking sharedInstance] search:@{
                                            @"lat"  : @0,
                                            @"lng"  : @0,
                                            }];
    [task continueWithBlock:^id _Nullable(BFTask * _Nonnull t) {
        for (id object in t.result) {
            NSLog(@"%@", [object description]);
        }
        NSLog(@"%@", t.error);
        return nil;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
