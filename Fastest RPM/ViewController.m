//
//  ViewController.m
//  Fastest RPM
//
//  Created by Cody Zazulak on 2015-07-09.
//  Copyright (c) 2015 Cody Zazulak. All rights reserved.
//

#import "ViewController.h"
#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    CGPoint startLocation;
}

@property (weak, nonatomic) IBOutlet UIImageView *needleImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    [self.view addGestureRecognizer:panGesture];
    
    
    //Starting point of the Needle
    [self.needleImageView setTransform:CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(140))];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

float degreesToMove(float x, float y) {
    
    float a = fabsf(x);
    float b = fabsf(y);
    float result = ((a + b) / 2);
    
    if (result > 270) {
        result = 270;
    }
    
    result = (10.0 * floor((result/10.0)+0.5));
    return result;
}

-(void)didPan:(id)sender{
    
    UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer*)sender;

    CGPoint velocity = [sender velocityInView:self.view];
    float vx = velocity.x;
    float vy = velocity.y;
    float speedTotal = degreesToMove(vx,vy);
    NSLog(@"Speed Total: %f", speedTotal);
    
    [self.needleImageView setTransform:CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(speedTotal + 140))];
    
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        startLocation = [sender locationInView:self.view];
    } else if (panGesture.state == UIGestureRecognizerStateEnded) {
        [self.needleImageView setTransform:CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(140))];
    }
}

@end
