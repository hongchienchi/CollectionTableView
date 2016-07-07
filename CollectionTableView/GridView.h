//
//  GridView.h
//  NBCUAdSales
//
//  Created by CC Cooper on 5/31/16.
//  Copyright © 2016 CC Cooper. All rights reserved.//

#import <UIKit/UIKit.h>


@interface GridView : UIView

@property (nonatomic, copy) NSArray *dataForRows;

@property (nonatomic, copy) NSDictionary *classesToRegister;



- (void) reloadData;
@end
