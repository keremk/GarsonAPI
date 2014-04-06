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

- (NSArray *) orderItems;
- (void) addMenuItem:(CVNMenuItem *)menuItem forItemCount:(NSInteger) itemCount;
- (void) removeItemByName:(NSString *) itemName;
- (void) removeMenuItem:(CVNMenuItem *)menuItem;
- (CVNOrderItem *) orderItemFromMenuItem:(CVNMenuItem *) menuItem;
- (NSInteger) itemCountForMenuItem:(CVNMenuItem *) menuItem;
@end
