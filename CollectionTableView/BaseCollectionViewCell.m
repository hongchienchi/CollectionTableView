//
//  BaseCollectionViewCell.m
//  NBCUAdSales
//
//  Created by CC Cooper on 6/16/16.
//  Copyright © 2016 CC Cooper. All rights reserved.//

#import "BaseCollectionViewCell.h"

@interface BaseCollectionViewCell()
@property (nonatomic, strong) UIView *xibView;

@end
@implementation BaseCollectionViewCell


- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void) setup
{
    [self xibSetup];
}

- (void) xibSetup
{
    self.xibView = [self loadViewFromNib];
    self.xibView.frame = self.bounds;
    self.xibView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.xibView];
}

- (UIView *) loadViewFromNib
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(self.class) bundle:[NSBundle mainBundle]];
    NSArray *views = [nib instantiateWithOwner:self options:nil];
    UIView *view = [views firstObject];
    return view;
}

@end
