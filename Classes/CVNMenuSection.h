//
//  CVNMenuSection.h
//  Pods
//
//  Created by Kerem Karatal on 4/1/14.
//
//

#import <Mantle/Mantle.h>

@interface CVNMenuSection : MTLModel<MTLJSONSerializing>
@property(nonatomic, copy) NSString *sectionId;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, strong) NSURL *imageURL;
@property(nonatomic, strong) NSArray *items;

@end
