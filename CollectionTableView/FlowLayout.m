//
//  FlowLayout.m
//  NBCUAdSales
//
//  Created by CC Cooper on 6/3/16.
//
/*
 http://stackoverflow.com/questions/19047972/how-to-make-sticky-headers-in-uicollectionview-on-ios7
 http://blog.radi.ws/post/32905838158/sticky-headers-for-uicollectionview-using
 */

#import "FlowLayout.h"

@implementation FlowLayout


#pragma mark STICKY HEADERS CODE BELOW

- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect
{

    if ([DeviceHelper iosVersion] >= 9.0) {
        return [super layoutAttributesForElementsInRect:rect];
    }
    
    NSMutableArray *itemsAttributesInRect = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    UICollectionView * const cv = self.collectionView;
    CGPoint const contentOffset = cv.contentOffset;
        
    // move section header attribues to the end of array
    
    NSMutableIndexSet *sectionHeaderItems = [NSMutableIndexSet indexSet];
    
    for (NSUInteger idx=0; idx < [itemsAttributesInRect count]; ++idx) {
        UICollectionViewLayoutAttributes *layoutAttributes = itemsAttributesInRect[idx];
        
        if (layoutAttributes.representedElementCategory == UICollectionElementCategoryCell || layoutAttributes.representedElementCategory == UICollectionElementCategorySupplementaryView) {
            // Keep track of the largest section index found in the rect (maxSectionIndex)
            NSUInteger sectionIndex = (NSUInteger)layoutAttributes.indexPath.section;
            [sectionHeaderItems addIndex:sectionIndex];
        }
        if ([layoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            // Remove layout of header done by our super, as we will update its attributes later
            [itemsAttributesInRect removeObjectAtIndex:idx];
            idx--;
        }
    }

    
    [sectionHeaderItems enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:idx];
        
        UICollectionViewLayoutAttributes *layoutAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        
        [itemsAttributesInRect addObject:layoutAttributes];
        
    }];
    
    CGSize contentSize = self.collectionViewContentSize;
    
    
    for (UICollectionViewLayoutAttributes *layoutAttributes in itemsAttributesInRect) {
        
        if ([layoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            
            if ([self.collectionView numberOfSections] == 1 && contentSize.height <= self.collectionView.height) {
                break;
            }
            
            // we have more content than collectionView height
            
            CGFloat limit = ceil(contentSize.height - self.collectionView.height);
            if ([self.collectionView numberOfSections] == 1 && contentOffset.y >= limit) {

                CGPoint contentOffset = self.collectionView.contentOffset;
                CGRect frame = layoutAttributes.frame;
                frame.origin.y = contentOffset.y;
                layoutAttributes.frame = frame;
                break;
            }
            
            NSInteger section = layoutAttributes.indexPath.section;
            NSInteger numberOfItemsInSection = [cv numberOfItemsInSection:section];
            
            NSIndexPath *firstCellIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
            NSIndexPath *lastCellIndexPath = [NSIndexPath indexPathForItem:MAX(0, (numberOfItemsInSection - 1)) inSection:section];
            
            UICollectionViewLayoutAttributes *firstCellAttrs = [self layoutAttributesForItemAtIndexPath:firstCellIndexPath];
            UICollectionViewLayoutAttributes *lastCellAttrs = [self layoutAttributesForItemAtIndexPath:lastCellIndexPath];
            
            CGFloat headerHeight = CGRectGetHeight(layoutAttributes.frame);
            CGPoint origin = layoutAttributes.frame.origin;
            origin.y = MIN(
                           MAX(
                               contentOffset.y,
                               (CGRectGetMinY(firstCellAttrs.frame) - headerHeight)
                               ),
                           (CGRectGetMaxY(lastCellAttrs.frame) - headerHeight)
                           );
            
            layoutAttributes.zIndex = 1024;
            layoutAttributes.frame = (CGRect){
                .origin = origin,
                .size = layoutAttributes.frame.size
            };
            
        }
        
    }
    
    return itemsAttributesInRect;
    
}
//- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    if ([DeviceHelper iosVersion] >= 9.0) {
//        return [super layoutAttributesForSupplementaryViewOfKind:kind
//                                                     atIndexPath:indexPath];
//    }
//    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForSupplementaryViewOfKind:kind atIndexPath:indexPath];
//    
//    return attributes;
//}
//
//- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    
//    if ([DeviceHelper iosVersion] >= 9.0) {
//        return [super layoutAttributesForSupplementaryViewOfKind:kind
//                                                     atIndexPath:indexPath];
//    }
//    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:kind atIndexPath:indexPath];
//    return attributes;
//}
//
//- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    if ([DeviceHelper iosVersion] >= 9.0) {
//        return [super finalLayoutAttributesForDisappearingSupplementaryElementOfKind:kind
//                                                     atIndexPath:indexPath];
//    }
//    
//    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:kind atIndexPath:indexPath];
//    return attributes;
//}
//
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBound
//{
//    if ([DeviceHelper iosVersion] >= 9.0) {
//        return [super shouldInvalidateLayoutForBoundsChange:newBound];
//    }
//    return YES;
//}
@end
