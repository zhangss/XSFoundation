//
//  ImageCompressionViewController.m
//  XSFoundation
//
//  Created by 张松松 on 16/8/29.
//  Copyright © 2016年 com.zhangss.foundation. All rights reserved.
//

#import "ImageCompressionViewController.h"
#import "DataUtil.h"
#import <ImageIO/ImageIO.h>

@interface ImageCompressionViewController ()

@end

@implementation ImageCompressionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Image Compression";
    // Do any additional setup after loading the view.
    
    //压缩后的图片保存位置
    NSString *imageCompressionPath = [[XSConfig shareConfig] imageCompressionPath];
    NSLog(@"imageCompressionPath:\n%@",imageCompressionPath);

    /**
     *  原图信息
     *  种类：JPEG 图像
     *  大小：2,531,878 字节（磁盘上的 2.5 MB）
     *  尺寸：1512 × 2016
     */
    NSLog(@"种类：JPEG 图像 大小：2,531,878 字节（磁盘上的 2.5 MB）");
    NSData *imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_test" ofType:@"jpg"]];
    [imageData writeToFile:[imageCompressionPath stringByAppendingPathComponent:@"image_test.jpg"] atomically:YES];
    NSLog(@"Orignal:%ld byte",imageData.length);
    NSLog(@"Orignal:%@",[DataUtil formatDataSizeByCalculate:imageData.length]);
    NSLog(@"Orignal:%@",[DataUtil formatDataSizeIniOS:imageData.length]);
    
    //JPG
    UIImage *image = [UIImage imageNamed:@"image_test.jpg"];
    imageData = UIImageJPEGRepresentation(image, 1);
    NSLog(@"Orignal JPEG 10:%ld byte",imageData.length);
    NSLog(@"Orignal JPEG 10:%@",[DataUtil formatDataSizeByCalculate:imageData.length]);
    NSLog(@"Orignal JPEG 10:%@",[DataUtil formatDataSizeIniOS:imageData.length]);
    [imageData writeToFile:[imageCompressionPath stringByAppendingPathComponent:@"image_test_10.jpg"] atomically:YES];
    //PNG
    imageData = UIImagePNGRepresentation(image);
    NSLog(@"Orignal PNG 10:%ld byte",imageData.length);
    NSLog(@"Orignal PNG 10:%@",[DataUtil formatDataSizeByCalculate:imageData.length]);
    NSLog(@"Orignal PNG 10:%@",[DataUtil formatDataSizeIniOS:imageData.length]);
    [imageData writeToFile:[imageCompressionPath stringByAppendingPathComponent:@"image_test_10.png"] atomically:YES];
    
    CGFloat imageWidth = 100.0f;
    CGFloat imageHeight = imageWidth * image.size.height / image.size.width;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - imageWidth / 2, 5, imageWidth, imageHeight)];
    imageView.image = image;
//    imageView.layer.cornerRadius = imageWidth/2;
//    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    
    for (int i = 1; i < 10; i ++)
    {
        //压缩
        imageData = UIImageJPEGRepresentation(image, i * 0.1);
        [imageData writeToFile:[imageCompressionPath stringByAppendingPathComponent:[NSString stringWithFormat:@"image_test_%d.jpg",i]] atomically:YES];
        NSLog(@"%d:%ld byte",i,imageData.length);
        NSLog(@"%d:%@",i,[DataUtil formatDataSizeByCalculate:imageData.length]);
        NSLog(@"%d:%@",i,[DataUtil formatDataSizeIniOS:imageData.length]);
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(((i - 1) % 3) * imageWidth + ((i - 1) % 3) * 10, imageHeight + 10 + ((i - 1) / 3) * imageHeight + ((i - 1) / 3) * 10, imageWidth, imageHeight)];
        imageView.image = [UIImage imageWithData:imageData];
//        imageView.layer.cornerRadius = imageWidth/2;
//        imageView.layer.masksToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:imageView];
    }
    
    NSLog(@"总结：\n\
          1.文件大小格式化，简单的除以1024会有问题，计算不精确\n\
          2.JPG->DATA:通过读取文件内容方式,文件大小不变\n\
          2.JPG->DATA->JPG:UIImageJPEGRepresentation,文件大小变大\n\
          4.JPG->DATA->PNG:UIImagePNGRepresentation,文件大小成倍增加\n\
          5.JPG->DATA->JPG:UIImageJPEGRepresentation(i),文件大小与i的大小不成比例,压缩率待确定\n\
          6.JPG->DATA->JPG:UIImageJPEGRepresentation(i),压缩方式，与显示效果差别不大。\n\
          ");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)imageEXIF {
    NSData *imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_test" ofType:@"jpg"]];
    CGImageSourceRef imageSource = CGImageSourceCreateIncremental(NULL);
    CGImageSourceUpdateData(imageSource, (CFDataRef)imageData, YES);
    CGImageRef imageRef = CGImageSourceCreateImageAtIndex(imageSource, 0, NULL);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
}

@end
