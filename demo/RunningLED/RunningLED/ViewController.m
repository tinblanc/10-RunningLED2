//
//  ViewController.m
//  RunningLED
//
//  Created by Tin Blanc on 3/15/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    
    CGFloat _margin; // lon' hon radius ( căn lề)
    int _numberOfBall;
    CGFloat _space; // lon' hon diameter
    CGFloat _ballDiameter;
    NSTimer * _timer;
    
    int lastOnLED;// store last turn on LED (lưu trữ)
    int lastOnLED1;
    int lastOnLED2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _margin = 40.0; // căn lề
    _ballDiameter=24.0;
    _numberOfBall = 8;
    lastOnLED = _numberOfBall-1;
    lastOnLED1 = 3;
    lastOnLED2 = 4;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(runningLED) userInfo:nil repeats:true];
    
    //[self checkSizeOfApp];
    //[self numberOfBallvsSpace];
    [self drawRowOfBall: _numberOfBall];
    [self drawRowOfBall2:_numberOfBall];

    //[self placeGreyBallAtX:100 andY:100 withTag:1];
}

-(void) runningLED {
    
    // ------------ LED sáng từ trái qua phải -----------
    // lastOnLED khác -1 tức là đã có đèn được bật
    if(lastOnLED != _numberOfBall){
        [self turnOFFLed:lastOnLED];
    }
    
    if(lastOnLED != -1){
        lastOnLED--;
    }else {
        lastOnLED = _numberOfBall-1;
    }
    
    [self turnONLed:lastOnLED];
    
    
    // ------------ LED sáng sang 2 bên -----------
    if(lastOnLED1 != _numberOfBall){
        [self turnOFFLed2:lastOnLED1];
    }
    
    if(lastOnLED1 != -1){
        lastOnLED1--;
    }else{
        lastOnLED1 = _numberOfBall-5;
    }
    
    [self turnONLed2:lastOnLED1];

    if(lastOnLED2 != _numberOfBall){
        [self turnOFFLed2:lastOnLED2];
    }

    if(lastOnLED2 != _numberOfBall-1){
        lastOnLED2++;
    }else{
        lastOnLED2 = _numberOfBall-4;
    }
    
    [self turnONLed2:lastOnLED2];
    
    
}


-(void) turnONLed: (int) index{
    UIView* view = [self.view viewWithTag:index +100];
    
    // Check view có tồn tại không và có phải kiểu UIImageView không
    if(view && [view isMemberOfClass:[UIImageView class]]){
        UIImageView* ball = (UIImageView*) view; // ép kiểu
        ball.image = [UIImage imageNamed:@"green"];
    }
}

-(void) turnOFFLed: (int) index{
    UIView* view = [self.view viewWithTag:index +100];
    
    // Check view có tồn tại không và có phải kiểu UIImageView không
    if(view && [view isMemberOfClass:[UIImageView class]]){
        UIImageView* ball = (UIImageView*) view; // ép kiểu
        ball.image = [UIImage imageNamed:@"grey"];
    }
}


-(void) turnONLed2: (int) index{
    UIView* view = [self.view viewWithTag:index +1000];
    
    // Check view có tồn tại không và có phải kiểu UIImageView không
    if(view && [view isMemberOfClass:[UIImageView class]]){
        UIImageView* ball = (UIImageView*) view; // ép kiểu
        ball.image = [UIImage imageNamed:@"green"];
    }
}

-(void) turnOFFLed2: (int) index{
    UIView* view = [self.view viewWithTag:index +1000];
    
    // Check view có tồn tại không và có phải kiểu UIImageView không
    if(view && [view isMemberOfClass:[UIImageView class]]){
        UIImageView* ball = (UIImageView*) view; // ép kiểu
        ball.image = [UIImage imageNamed:@"grey"];
    }
}


// -------------------------


// place: địa điểm
-(void) placeGreyBallAtX:(CGFloat) x
                    andY: (CGFloat) y
                 withTag: (int) tag
{
    UIImageView* ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grey"]];
    // tọa độ
    ball.center = CGPointMake(x, y);
    
    // phân biệt các quả bóng với nhau
    ball.tag = tag;
    
    [self.view addSubview:ball];
}


-(CGFloat) spaceBetweenBallCenterWhenNumberBallIsKnow: (int) n {
    return (self.view.bounds.size.width - 2 * _margin) / (n-1);
}

-(CGFloat) spaceHeightBetweenBallCenterWhenNumberBallIsKnow: (int) n {
    return (self.view.bounds.size.height - 2 * _margin) / (n-1);
}



-(void) numberOfBallvsSpace {
    bool stop = false;
    int n = 3;
    while (!stop) {
        CGFloat space = [self spaceBetweenBallCenterWhenNumberBallIsKnow: n];
        // diameter: đường kính
        if (space < _ballDiameter) {
            stop = true;
        } else {
            NSLog(@"Number of ball %d, space between ball center %3.0f", n, space);
        }
        n++;
    }
}


-(void) drawRowOfBall: (int) numberBalls{
    CGFloat space = [self spaceBetweenBallCenterWhenNumberBallIsKnow:numberBalls];

    int y = 100;
    for(int i = 0; i < numberBalls; i++){
        
            [self placeGreyBallAtX:_margin + i * space
                              andY:y
                           withTag:i + 100];
    }
}

-(void) drawRowOfBall2: (int) numberBalls{
    CGFloat space = [self spaceBetweenBallCenterWhenNumberBallIsKnow:numberBalls];
    
    int y = 180;
    for(int i = 0; i < numberBalls; i++){
        
        [self placeGreyBallAtX:_margin + i * space
                          andY:y
                       withTag:i + 1000];
    }
}



//-(void) drawRowOfBall: (int) numberBalls{
//    CGFloat space = [self spaceBetweenBallCenterWhenNumberBallIsKnow:numberBalls];
//    CGFloat spaceHeight = [self spaceHeightBetweenBallCenterWhenNumberBallIsKnow:numberBalls];
//    int y = 100;
//    for(int i = 0; i < numberBalls; i++){
//        for(int j = 0; j < numberBalls; j++){
//            [self placeGreyBallAtX:_margin + j * space
//                              andY:y
//                           withTag:i + 100];
//        }
//        y = _margin + i * spaceHeight;
//        
//        
//    }
//}


-(void) checkSizeOfApp{
    CGSize size = self.view.bounds.size;
    NSLog(@"width = %3.0f, height = %3.0f", size.width, size.height);
}




@end
