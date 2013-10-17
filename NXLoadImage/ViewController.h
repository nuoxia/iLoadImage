//
//  ViewController.h
//  NXLoadImage
//
//  Created by NuoXia on 10/17/13.
//  Copyright (c) 2013 NuoXia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *imageButton;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)loadImage:(id)sender;

@end
