//
//  CVNRestaurantMenu.h
//  Pods
//
//  Created by Kerem Karatal on 3/30/14.
//
//

#import <Mantle/Mantle.h>

@interface CVNRestaurantMenu : MTLModel<MTLJSONSerializing>
@property(nonatomic, strong) NSArray *sections;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *timeInterval;

@end
