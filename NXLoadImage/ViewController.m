//
//  ViewController.m
//  NXLoadImage
//
//  Created by NuoXia on 10/17/13.
//  Copyright (c) 2013 NuoXia. All rights reserved.
//

#import "ViewController.h"
#import "HUDLoadingView.h"

static NSString* urlStr = @"http://farm6.staticflickr.com/5524/9343383198_c2ab90031b_k.jpg";

@interface ViewController ()

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


- (IBAction)loadImage:(id)sender {
    
    [HUDLoadingView showLoadingView];
    
    [self imageFromUrl:[NSURL URLWithString:urlStr]];
}

-(void)imageFromUrl: (NSURL*)url {
    dispatch_queue_t queue = dispatch_queue_create("loadImageFromUrl", NULL);
    dispatch_async(queue, ^{
        NSData* data = [NSData dataWithContentsOfURL:url];
        
        UIImage* image = [UIImage imageWithData:data];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.imageView.image = image;

            [HUDLoadingView hideLoadingView];
        });
    });
}
@end
