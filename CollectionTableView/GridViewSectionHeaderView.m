//
//  GridViewSectionHeaderView.m
//  NBCUAdSales
//
//  Created by CC Cooper on 6/7/16.
//  Copyright © 2016 CC Cooper. All rights reserved.//

#import "GridViewSectionHeaderView.h"

@interface GridViewSectionHeaderView()

@property (nonatomic, strong) UIView *xibView;

@end

@implementation GridViewSectionHeaderView

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
    NSArray *array = [self allLabels];
    
    for (UILabel *label in array) {
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];

        //style.alignment = NSTextAlignmentLeft;
        style.firstLineHeadIndent = [self textIndent];
        style.headIndent = [self textIndent];
        style.tailIndent = -[self textIndent];
        
        UIFont *font = [self textFont];
        NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:label.text
                                                                       attributes:@{
                                                                                    NSFontAttributeName:[UIFont fontWithName:font.fontName size:font.pointSize]
                                                                                    ,NSParagraphStyleAttributeName:style
                                                                                    
                                                                                    ,NSForegroundColorAttributeName:[UIColor colorWithHexString:@"9b9b9b"]                                                                                    
                                                                                    }];
        
        label.numberOfLines = 1;
        label.attributedText = attrText;
        label.layer.borderColor = [UIColor colorWithHexString:@"D7D7D7"].CGColor;
        label.layer.borderWidth = .5;
        
    }
}

- (NSArray *) allLabels
{
    return nil;
}

- (CGFloat) textIndent
{
    return 0;
}

- (UIFont *) textFont
{
    return [UIFont fontWithName:@"Flexo-Regular" size:14];
}

@end
