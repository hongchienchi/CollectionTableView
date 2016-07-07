//
//  GridViewCell.h
//  NBCUAdSales
//
//  Created by CC Cooper on 6/8/16.
//  Copyright © 2016 CC Cooper. All rights reserved.//

#import <UIKit/UIKit.h>

@interface GridViewCell : UICollectionViewCell

@property (copy, nonatomic) NSObject *data;

- (NSArray *) allTextViews;
- (UIEdgeInsets) textInset;
@end
