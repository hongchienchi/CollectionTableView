//
//  GridViewCell.m
//  NBCUAdSales
//
//  Created by CC Cooper on 6/8/16.
//  Copyright © 2016 CC Cooper. All rights reserved.//

#import "GridViewCell.h"

@interface GridViewCell()
@property (nonatomic, strong) UIView *xibView;

@end

@implementation GridViewCell
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

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void) prepareForReuse
{
    [super prepareForReuse];
    
    NSArray *textViews = [self allTextViews];
    
    for (NSInteger index = 0; index < textViews.count ; index++) {
        UITextView *textView = textViews[index];
        textView.text = @"";
    }
}

- (void) layoutSubviews
{
    [super layoutSubviews];
}

- (void) setup
{
    [self xibSetup];
    [self updateTextInset];
}

- (void) updateTextInset
{
    NSArray *array = [self allTextViews];
    UIEdgeInsets inset = [self textInset];

    for (UITextView *textView in array) {
        textView.textContainerInset = inset;
        textView.layer.borderColor = [UIColor colorWithHexString:@"D7D7D7"].CGColor;
        textView.layer.borderWidth = 0.5;
    }
}


- (void) setData:(NSObject *)data
{
    _data = data;
    
    [self populateData:data];
}

- (void) populateData:(NSObject *)data
{

}

- (NSString *) myClassString
{
    return @"GridViewCell";
}
                                        
- (NSArray *) allTextViews
{
    return nil;
}

- (UIEdgeInsets) textInset;
{
    return UIEdgeInsetsZero;
}
@end
