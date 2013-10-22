//
//  ViewController.m
//  NXLoadImage
//
//  Created by NuoXia on 10/17/13.
//  Copyright (c) 2013 NuoXia. All rights reserved.
//

#import "ViewController.h"
#import "HUDLoadingView.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

static NSString* urlStr = @"http://farm6.staticflickr.com/5524/9343383198_c2ab90031b_k.jpg";

typedef enum{
    ImageLoadTypeData,
    ImageLoadTypeConnection,
    ImageLoadTypeSDWebImage,
}ImageLoadType;

@interface ViewController () <NSURLConnectionDataDelegate> {
    NSMutableData* imageData;
    long long fileSize;
    
    ImageLoadType loadType;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    loadType = ImageLoadTypeSDWebImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadImage:(id)sender {
    
//    [HUDLoadingView showLoadingView];
    
    [self imageFromUrl:[NSURL URLWithString:urlStr] type:loadType];
}

- (IBAction)switchImageLoadType:(id)sender {
    if (ImageLoadTypeData == loadType) {
        loadType = ImageLoadTypeConnection;
    }else {
        loadType = ImageLoadTypeData;
    }
}

- (IBAction)removeImage:(id)sender {
    self.imageView.image = nil;
}

-(void)imageFromUrl: (NSURL*)url type: (ImageLoadType)type{
    
    switch (type) {
        case ImageLoadTypeData: {
            [HUDLoadingView showLoadingView];
            
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
            break;
        case ImageLoadTypeConnection: {
            NSURLRequest* request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:100.0];
            NSURLConnection* connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
            [connection start];
            [HUDLoadingView showLoadingView];
        }
            break;
        case ImageLoadTypeSDWebImage: {
//            [HUDLoadingView showLoadingView];
//            [self.imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"image_loading_default"] completed:^(UIImage* image, NSError* error, SDImageCacheType cacheType){
//                [HUDLoadingView hideLoadingView];
//                if (error) {
//                    NSLog(@"%@", error);
//                }
//            }];
            
            [self.imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"image_loading_default"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        }
        default:
            break;
    }
}

#pragma mark -
#pragma mark NSURLConnectionDataDelegate
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    imageData = [[NSMutableData alloc]init];
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    if (httpResponse && [httpResponse respondsToSelector:@selector(allHeaderFields)]) {
        NSDictionary* headFields = [httpResponse allHeaderFields];
        // 获取文件大小
        fileSize = [[headFields objectForKey:@"Content-Length"]longLongValue];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [imageData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"数据加载失败！！！");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    UIImage* image = [UIImage imageWithData:imageData];
    self.imageView.image = image;
    
    [HUDLoadingView hideLoadingView];
}
@end
