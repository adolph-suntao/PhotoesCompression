//
//  ViewController.m
//  PhotoesCompression
//
//  Created by 孙涛 on 16/9/8.
//  Copyright © 2016年 suntao. All rights reserved.
//

#import "ViewController.h"

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic, strong)UIImageView *oldImageView;
@property (nonatomic, strong)UIImageView *newImageView;
@property (nonatomic, strong)UILabel *oldLabel;
@property (nonatomic, strong)UILabel *newLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage *oldImage = [UIImage imageNamed:@"tupianceshi.jpg"];
    UIImage *newImage = [self imageCompressForWidth:oldImage targetWidth:500];
    
    self.oldImageView.image = oldImage;
    self.newImageView.image = newImage;
    self.oldLabel.text = @"压缩前";
    self.newLabel.text = @"压缩后";
    
    //写入沙河路径
    NSString *path_document = NSHomeDirectory();
    NSString *path_image = [path_document stringByAppendingString:@"/Documents/newImage.jpg"];
    NSString *path_image_old = [path_document stringByAppendingString:@"/Documents/oldImage.jpg"];
    [UIImageJPEGRepresentation(oldImage, 1.0) writeToFile:path_image_old atomically:YES];
    [UIImageJPEGRepresentation(newImage, 1.0) writeToFile:path_image atomically:YES];

}



//压缩图片
-(UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth {
    
    if (sourceImage && defineWidth > 0) {
        CGSize imageSize = sourceImage.size;
        CGFloat width = imageSize.width;
        CGFloat height = imageSize.height;
        CGFloat targetWidth = defineWidth;
        CGFloat targetHeight = (targetWidth / width) * height;
        UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
        [sourceImage drawInRect:CGRectMake(0,0,targetWidth, targetHeight)];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }
    
    return nil;
}

//压缩前
- (UIImageView *)oldImageView {
    if (!_oldImageView) {
        _oldImageView = [[UIImageView alloc]init];
        _oldImageView.frame = CGRectMake(20, 60, kWidth-40, (kHeight-110)/2);
        [self.view addSubview:_oldImageView];
    }
    return _oldImageView;
}
//压缩后
- (UIImageView *)newImageView {
    if (!_newImageView) {
        _newImageView = [[UIImageView alloc]init];
        _newImageView.frame = CGRectMake(20, (kHeight-110)/2+90, kWidth-40, (kHeight-110)/2);
        [self.view addSubview:_newImageView];
    }
    return _newImageView;
}
- (UILabel *)oldLabel {
    if (!_oldLabel) {
        _oldLabel = [[UILabel alloc]initWithFrame:CGRectMake((kWidth-100)/2, 30, 100, 30)];
        _oldLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_oldLabel];
    }
    return _oldLabel;
}
- (UILabel *)newLabel {
    if (!_newLabel) {
        _newLabel = [[UILabel alloc]initWithFrame:CGRectMake((kWidth-100)/2, (kHeight-110)/2+60, 100, 30)];
        _newLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_newLabel];
    }
    return _newLabel;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
