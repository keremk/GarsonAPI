//
//  CVNOrder.h
//  Pods
//
//  Created by Kerem Karatal on 3/30/14.
//
//

#import "MTLModel.h"

@interface CVNOrder : MTLModel
+ (CVNOrder *) currentOrder;
- (NSArray *) orderItems;
@end
