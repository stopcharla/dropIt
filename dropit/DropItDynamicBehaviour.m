//
//  DropItDynamicBehaviour.m
//  dropit
//
//  Created by Sidhartha Topcharla on 10/9/16.
//  Copyright © 2016 Sidhartha Topcharla. All rights reserved.
//

#import "DropItDynamicBehaviour.h"

@interface DropItDynamicBehaviour()
@property (nonatomic,strong) UIGravityBehavior *gravityBehavior;
@property (nonatomic,strong) UICollisionBehavior *collisionBehavior;
@property (nonatomic,strong) UIDynamicItemBehavior *itemBehavior;
@end

@implementation DropItDynamicBehaviour

- (instancetype)init{
    if (self = [super init]) {
        [self addChildBehavior:self.gravityBehavior];
        [self addChildBehavior:self.collisionBehavior];
        [self addChildBehavior:self.itemBehavior];
    }
    return self;
}
- (UIDynamicItemBehavior *)itemBehavior{
    if (!_itemBehavior) {
        _itemBehavior = [[UIDynamicItemBehavior alloc] init];
        _itemBehavior.allowsRotation = NO;
    }
    return _itemBehavior;
}

- (UIGravityBehavior *)gravityBehavior{
    if (!_gravityBehavior) {
        _gravityBehavior = [[UIGravityBehavior alloc] init];
        _gravityBehavior.magnitude = 1.0;
    }
    return _gravityBehavior;
}

- (UICollisionBehavior *)collisionBehavior{
    if (!_collisionBehavior) {
        _collisionBehavior = [[UICollisionBehavior alloc] init];
        _collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    }
    return _collisionBehavior;
}

- (void) addItem:(id<UIDynamicItem>) item{
    [self.gravityBehavior addItem:item];
    [self.collisionBehavior addItem:item];
    [self.itemBehavior addItem:item];
}

- (void) removeItem:(id<UIDynamicItem>) item{
    [self.gravityBehavior removeItem:item];
    [self.collisionBehavior removeItem:item];
    [self.itemBehavior removeItem:item];
}


@end
