//
//  ViewController.m
//  dropit
//
//  Created by Sidhartha Topcharla on 10/9/16.
//  Copyright © 2016 Sidhartha Topcharla. All rights reserved.
//

#import "ViewController.h"
#import "DropItDynamicBehaviour.h"
#import "UIBezierPathView.h"
@interface ViewController () <UIDynamicAnimatorDelegate>{
    UIView *droppingView;
}
@property (weak, nonatomic) IBOutlet UIBezierPathView *gameView;
@property (nonatomic,strong) UIDynamicAnimator *animator;
@property (nonatomic,strong) DropItDynamicBehaviour *dynamicBehavior;
@property (nonatomic,strong) UIAttachmentBehavior *attachmentBehavior;

@end

@implementation ViewController

static CGSize DROP_SIZE = {40,40};


- (DropItDynamicBehaviour *)dynamicBehavior{
    if (!_dynamicBehavior) {
        _dynamicBehavior = [[DropItDynamicBehaviour alloc] init];
        [self.animator addBehavior:_dynamicBehavior];
    }
    return _dynamicBehavior;
}

- (UIDynamicAnimator *)animator{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gameView];
        _animator.delegate = self;
    }
    return _animator;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    
    [self drop];
    
}
- (IBAction)pan:(UIPanGestureRecognizer *)sender {
    CGPoint anchorPoint = [sender locationInView:self.gameView];
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self attachmentDropViewToAnchor:anchorPoint];
    } else  if (sender.state == UIGestureRecognizerStateChanged) {
        self.attachmentBehavior.anchorPoint = anchorPoint;
    }else  if (sender.state == UIGestureRecognizerStateEnded) {
        [self.animator removeBehavior:self.attachmentBehavior];
        self.gameView.path = nil;
    }
}

- (void) attachmentDropViewToAnchor:(CGPoint)point{
    if (droppingView) {
        self.attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:droppingView attachedToAnchor:point];
        __weak typeof(self) weakSelf = self;
        UIView *dropView = droppingView;
        self.attachmentBehavior.action = ^{
            UIBezierPath *path = [[UIBezierPath alloc] init];
            [path moveToPoint:weakSelf.attachmentBehavior.anchorPoint];
            [path addLineToPoint:dropView.center];
            weakSelf.gameView.path = path;
        };
        
        droppingView = nil;
        [self.animator addBehavior:self.attachmentBehavior];
    }
}

- (void) drop{
    CGRect frame;
    frame.origin = CGPointMake(0, 0);
    frame.size = DROP_SIZE;
    
    int x = (arc4random()%(int)self.gameView.bounds.size.width)/DROP_SIZE.width;
    frame.origin.x = x * DROP_SIZE.width;
    
    UIView *dropView = [[UIView alloc] initWithFrame:frame];
    dropView.backgroundColor = [self getBackgroundColor];
    
    [self.gameView addSubview:dropView];
    //    UIGravityBehavior *beh = self.gravityBehavior;
    
    //    [self initAnimations];
    droppingView = dropView;
    [self.dynamicBehavior addItem:dropView];
}

- (UIColor*)getBackgroundColor{
    switch ((arc4random()%5)) {
        case 0:return [UIColor redColor];
        case 1:return [UIColor greenColor];
        case 2:return [UIColor orangeColor];
        case 3:return [UIColor blueColor];
        case 4:return [UIColor purpleColor];
        default:
            return [UIColor blackColor];
    }
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator{
    [self removeCompletedRows];
}

- (void) removeCompletedRows{
    
}

@end
