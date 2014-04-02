//
//  CVNRestaurant.h
//  Pods
//
//  Created by Kerem Karatal on 4/1/14.
//
//

#import <Mantle/Mantle.h>
#import "CVNRestaurantMenu.h"

@interface CVNRestaurant : MTLModel<MTLJSONSerializing>
@property(nonatomic, copy) NSString *name;
+ (instancetype) currentRestaurant;
- (void)  currentMenuWithSuccess:(void (^)(CVNRestaurantMenu *menu))success
                         failure:(void (^)(NSError *error))failure;
@end
