//
//  CVNOrder.h
//  Pods
//
//  Created by Kerem Karatal on 3/30/14.
//
//

#import "MTLModel.h"
#import "CVNMenuItem.h"
#import "CVNOrderItem.h"

@class CVNOrder;

@protocol CVNOrderChange <NSObject>
- (void) didChangeOrder:(CVNOrder *) order;
@end

@interface CVNOrder : MTLModel
//+ (CVNOrder *) currentOrder;
@property(nonatomic, weak) id<CVNOrderChange> delegate;
@property(nonatomic, readonly) double total;
@property(nonatomic, readonly) double barSubtotal;
@property(nonatomic, readonly) double foodSubtotal;
@property(nonatomic, readonly) double taxTotal;
@property(nonatomic, readonly) double sfhcTaxTotal;

- (NSArray *) orderItems;
- (void) addMenuItem:(CVNMenuItem *)menuItem forItemCount:(NSInteger) itemCount;
- (void) removeItemByName:(NSString *) itemName;
- (void) removeMenuItem:(CVNMenuItem *)menuItem;
- (NSDictionary *) calculateOrderSummary;

- (CVNOrderItem *) orderItemFromMenuItem:(CVNMenuItem *) menuItem;
- (NSInteger) itemCountForMenuItem:(CVNMenuItem *) menuItem;
@end
