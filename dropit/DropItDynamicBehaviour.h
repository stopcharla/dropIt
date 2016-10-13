//
//  DropItDynamicBehaviour.h
//  dropit
//
//  Created by Sidhartha Topcharla on 10/9/16.
//  Copyright © 2016 Sidhartha Topcharla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropItDynamicBehaviour : UIDynamicBehavior

- (void) addItem:(id<UIDynamicItem>) item;
- (void) removeItem:(id<UIDynamicItem>) item;

@end
