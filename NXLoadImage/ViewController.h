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

@property (strong, nonatomic) IBOutlet UIButton *removeButton;

@property (strong, nonatomic) IBOutlet UISwitch *typeSwitch;

- (IBAction)loadImage:(id)sender;
- (IBAction)switchImageLoadType:(id)sender;
- (IBAction)removeImage:(id)sender;

@end
