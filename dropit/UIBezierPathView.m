//
//  UIBezierPathView.m
//  dropit
//
//  Created by Sidhartha Topcharla on 10/9/16.
//  Copyright © 2016 Sidhartha Topcharla. All rights reserved.
//

#import "UIBezierPathView.h"

@implementation UIBezierPathView

- (void)setPath:(UIBezierPath *)path{
    _path = path;
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self.path stroke];
}

@end
