//
//  ViewController.m
//  NXLoadImage
//
//  Created by NuoXia on 10/17/13.
//  Copyright (c) 2013 NuoXia. All rights reserved.
//

#import "ViewController.h"

static NSString* urlStr = @"http://farm6.staticflickr.com/5524/9343383198_c2ab90031b_k.jpg";

@interface ViewController ()

@property UIActivityIndicatorView* aiView;
@property UILabel* loadingView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismiss {
    if (self.aiView) {
        [self.aiView stopAnimating];
        [self.loadingView removeFromSuperview];
    }
}

- (IBAction)loadImage:(id)sender {
    
    self.loadingView = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 40.0, self.view.bounds.size.height/2-20.0, 80.0, 40.0)];
    self.loadingView.backgroundColor = [UIColor blackColor];
    self.loadingView.alpha = 0.5f;
    [self.view addSubview:self.loadingView];
    
    self.aiView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.aiView.center = CGPointMake(self.loadingView.bounds.size.width/2, self.loadingView.bounds.size.height/2);
    [self.loadingView addSubview:self.aiView];
    [self.aiView startAnimating];
    
    [self imageFromUrl:[NSURL URLWithString:urlStr]];
    
//    [self performSelector:@selector(dismiss) withObject:nil afterDelay:3.0];
}

-(void)imageFromUrl: (NSURL*)url {
    dispatch_queue_t queue = dispatch_queue_create("loadImageFromUrl", NULL);
    dispatch_async(queue, ^{
        NSData* data = [NSData dataWithContentsOfURL:url];
        
        UIImage* image = [UIImage imageWithData:data];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
            
            [self dismiss];
        });
    });
}
@end
