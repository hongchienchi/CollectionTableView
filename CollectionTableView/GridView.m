//
//  GridView.m
//  NBCUAdSales
//
//  Created by CC Cooper on 5/31/16.
//  Copyright © 2016 CC Cooper. All rights reserved.//

#import "GridView.h"
#import "GridViewLayout.h"
#import "GridViewCell.h"
#import "GridViewSectionHeaderView.h"

static NSString *const GridViewCellId = @"GridViewCellId";
static NSString *const GridViewSectionHeaderId = @"GridViewSectionHeaderId";


@interface GridView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIView *xibView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet GridViewLayout *gridViewFlowLayout;

@end

@implementation GridView




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

#pragma mark - UICollecitonViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    NSInteger count = self.dataForRows.count;
    return count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GridViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GridViewCellId forIndexPath:indexPath];

    cell.data = self.dataForRows[indexPath.row];
    
    return cell;
}


// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{


    GridViewSectionHeaderView *headerView = (GridViewSectionHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GridViewSectionHeaderId forIndexPath:indexPath];
    return headerView;
}

#pragma mark - UICollecitonViewDelegate

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionView.width, 102);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.collectionView.width, 37);
}


//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    NSValue *value = self.sectionFooterSizeForColumns[section];
//    return value.CGSizeValue;
//}



#pragma mark - private methods

- (void) setup
{
    [self xibSetup];
    if ([DeviceHelper iosVersion] >= 9.0) {
        self.gridViewFlowLayout.sectionHeadersPinToVisibleBounds = YES;
    }
    self.collectionView.frame = self.bounds;
    
}

- (void) reloadData
{
    [self.collectionView reloadData];
}

- (void) setDataForRows:(NSArray *)dataForRows
{
    _dataForRows = dataForRows;
    [self.collectionView reloadData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) setClassesToRegister:(NSDictionary *)classesToRegister
{
    _classesToRegister = classesToRegister;
    
    [self.collectionView registerClass:NSClassFromString(classesToRegister[@"Cell"]) forCellWithReuseIdentifier: GridViewCellId];
    [self.collectionView registerClass:NSClassFromString(classesToRegister[UICollectionElementKindSectionHeader]) forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GridViewSectionHeaderId];
}
@end
