//
//  PRParkingLocationPreviewView.m
//  Parking Reservation
//
//  Created by Matt Mo on 10/27/16.
//  Copyright © 2016 Matt Mo. All rights reserved.
//

#import "PRParkingLocationPreviewView.h"

@interface PRParkingLocationPreviewView()

@property (nonatomic) UILabel *parkingSpotNameTitleLabel;
@property (nonatomic) UILabel *parkingSpotNameLabel;
@property (nonatomic) UILabel *parkingSpotNumberTitleLabel;
@property (nonatomic) UILabel *parkingSpotNumberLabel;
@property (nonatomic) UILabel *parkingSpotCostTitleLabel;
@property (nonatomic) UILabel *parkingSpotCostLabel;

@end

@implementation PRParkingLocationPreviewView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.parkingSpotNumberTitleLabel];
        [self addSubview:self.parkingSpotNumberLabel];
        [self addSubview:self.parkingSpotNameTitleLabel];
        [self addSubview:self.parkingSpotNameLabel];
        [self addSubview:self.parkingSpotCostTitleLabel];
        [self addSubview:self.parkingSpotCostLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSLog(@"layoutSubviews");
    
    [self.parkingSpotNumberTitleLabel sizeToFit];
    CGRect numberTitleLabelFrame = self.parkingSpotNumberTitleLabel.frame;
    numberTitleLabelFrame.origin.x = 15;
    numberTitleLabelFrame.origin.y = 15;
    self.parkingSpotNumberTitleLabel.frame = numberTitleLabelFrame;
    
    CGAffineTransform rightOfTitleLabelTransform = CGAffineTransformMakeTranslation(CGRectGetMaxX(self.parkingSpotNumberTitleLabel.frame), 0);
    self.parkingSpotNumberLabel.frame = CGRectApplyAffineTransform(self.parkingSpotNumberTitleLabel.frame, rightOfTitleLabelTransform);
    
    CGAffineTransform bottomOfNumberLabelTransform = CGAffineTransformMakeTranslation(0, self.parkingSpotNumberTitleLabel.frame.size.height + 10);
    self.parkingSpotNameTitleLabel.frame = CGRectApplyAffineTransform(self.parkingSpotNumberTitleLabel.frame, bottomOfNumberLabelTransform);
    [self.parkingSpotNameTitleLabel sizeToFit];
    
    rightOfTitleLabelTransform = CGAffineTransformMakeTranslation(CGRectGetMaxX(self.parkingSpotNameTitleLabel.frame), 0);
    self.parkingSpotNameLabel.frame = CGRectApplyAffineTransform(self.parkingSpotNameTitleLabel.frame, rightOfTitleLabelTransform);
    
    CGAffineTransform bottomOfNameLabelTransform = CGAffineTransformMakeTranslation(0, self.parkingSpotNameTitleLabel.frame.size.height + 10);
    self.parkingSpotCostTitleLabel.frame = CGRectApplyAffineTransform(self.parkingSpotNameTitleLabel.frame, bottomOfNameLabelTransform);
    [self.parkingSpotCostTitleLabel sizeToFit];
    
    rightOfTitleLabelTransform = CGAffineTransformMakeTranslation(CGRectGetMaxX(self.parkingSpotCostTitleLabel.frame), 0);
    self.parkingSpotCostLabel.frame = CGRectApplyAffineTransform(self.parkingSpotCostTitleLabel.frame, rightOfTitleLabelTransform);
    
}

- (void)updateSearchViewWith:(ParkingLocationModel *)parkingLocation
{
    self.parkingSpotNameLabel.text = parkingLocation.name;
    self.parkingSpotNumberLabel.text = [NSString stringWithFormat:@"%d", parkingLocation.parkingLocationID];
    self.parkingSpotCostLabel.text = [NSString stringWithFormat:@"%@/min", parkingLocation.costPerMin];
}

#pragma mark - Lazy initializers

- (UILabel *)parkingSpotNameTitleLabel
{
    return !_parkingSpotNameTitleLabel ? _parkingSpotNameTitleLabel =
    ({
        UILabel *label = [UILabel new];
        label.text = @"Spot Name:";
        label;
    }) : _parkingSpotNameTitleLabel;
}

- (UILabel *)parkingSpotNameLabel
{
    return !_parkingSpotNameLabel ? _parkingSpotNameLabel =
    ({
        UILabel *label = [UILabel new];
        label.text = @"N/A";
        label;
    }) : _parkingSpotNameLabel;
}

- (UILabel *)parkingSpotNumberTitleLabel
{
    return !_parkingSpotNumberTitleLabel ? _parkingSpotNumberTitleLabel =
    ({
        UILabel *label = [UILabel new];
        label.text = @"Spot #:";
        label;
    }) : _parkingSpotNumberTitleLabel;
}

- (UILabel *)parkingSpotNumberLabel
{
    return !_parkingSpotNumberLabel ? _parkingSpotNumberLabel =
    ({
        UILabel *label = [UILabel new];
        label.text = @"--";
        label;
    }) : _parkingSpotNumberLabel;
}

- (UILabel *)parkingSpotCostTitleLabel
{
    return !_parkingSpotCostTitleLabel ? _parkingSpotCostTitleLabel =
    ({
        UILabel *label = [UILabel new];
        label.text = @"Cost per min:";
        label;
    }) : _parkingSpotCostTitleLabel;
}

- (UILabel *)parkingSpotCostLabel
{
    return !_parkingSpotCostLabel ? _parkingSpotCostLabel =
    ({
        UILabel *label = [UILabel new];
        label.text = @"--/min";
        label;
    }) : _parkingSpotCostLabel;
}

@end
