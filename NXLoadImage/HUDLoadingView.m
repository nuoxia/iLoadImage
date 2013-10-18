//
//  HUDLoadingView.m
//  NXLoadImage
//
//  Created by NuoXia on 10/18/13.
//  Copyright (c) 2013 NuoXia. All rights reserved.
//

#import "HUDLoadingView.h"

@interface HUDLoadingView ()

@property UIActivityIndicatorView* aiView;
@property UILabel* loadingView;

@end

@implementation HUDLoadingView

+(HUDLoadingView*)HUDLoadingView {
    static HUDLoadingView* shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc]init];
    });
    return shareInstance;
}

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

+(void)showLoadingView {
    [[HUDLoadingView HUDLoadingView]showLoadingView];
}

-(void)showLoadingView {
    UIView* view = (UIView*)[[UIApplication sharedApplication]keyWindow];
    self.loadingView = [[UILabel alloc]initWithFrame:CGRectMake(view.bounds.size.width/2 - 40.0, view.bounds.size.height/2-20.0, 80.0, 40.0)];
    self.loadingView.backgroundColor = [UIColor blackColor];
    self.loadingView.alpha = 0.5f;
    [view addSubview:self.loadingView];
    
    self.aiView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.aiView.center = CGPointMake(self.loadingView.bounds.size.width/2, self.loadingView.bounds.size.height/2);
    [self.loadingView addSubview:self.aiView];
    [self.aiView startAnimating];
}

+(void)hideLoadingView {
    [[HUDLoadingView HUDLoadingView]hideLoadingView];
}

-(void)hideLoadingView {
    if (self.aiView) {
        [self.aiView stopAnimating];
    }
    if (self.loadingView) {
        [self.loadingView removeFromSuperview];
    }
}

@end
