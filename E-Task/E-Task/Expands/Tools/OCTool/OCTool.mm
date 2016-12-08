//
//  OCTool.m
//  FindWork
//
//  Created by bianxiang on 2016/11/9.
//  Copyright © 2016年 bianxiang. All rights reserved.
//

#import "OCTool.h"
#import <AVFoundation/AVFoundation.h>
#import "NSData+Encrypt.h"
@implementation OCTool
//获取视频桢图片
+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&thumbnailImageGenerationError];
    
    if (!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);
    
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage:thumbnailImageRef] : nil;
    
    return thumbnailImage;
}


+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;  
    }  
    
    // And now we just create a new UIImage from the drawing context  
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);  
    UIImage *img = [UIImage imageWithCGImage:cgimg];  
    CGContextRelease(ctx);  
    CGImageRelease(cgimg);  
    return img;  
}

static Byte iv[] = {2,0,1,5,1,1,2,5};
+ (NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key {
    NSData *ivdata = [[NSData alloc] initWithBytes:iv length:8];
    NSData *strData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    key = @"tW0k2!yw";
    NSData *data = [strData encryptedWithDESUsingKey:key andIV:ivdata];
    NSString *ciphertext = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return ciphertext;
}

/**
 * 倒计时
 *
 * @param endTime 截止的时间戳
 *
 * @return 返回的剩余时间
 */
+ (NSString*)remainingTimeMethodAction:(long long)endTime completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock
{
    //得到当前时间
//    NSDate *nowData = [NSDate date];
//    NSDate *endData=[NSDate dateWithTimeIntervalSince1970:endTime];
//    NSCalendar* chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSCalendarIdentifierGregorian ];
//    NSUInteger unitFlags =
//    NSHourCalendarUnit | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
//    NSDateComponents *cps = [chineseClendar components:unitFlags fromDate:nowData toDate: endData options:0];
//    NSInteger hour = [cps hour];
//    NSInteger min = [cps minute];
//    NSInteger sec = [cps second];
//    NSInteger day = [cps day];
//    NSInteger Mon = [cps month];
//    NSInteger Year = [cps year];
//    NSLog(@"%li年,%li,%li,%li,%li,%li", (long)Year, (long)Mon, (long)day, (long)hour, (long)min,(long)sec);
//    NSLog( @" From Now to %@, diff: Years: %d Months: %d, Days; %d, Hours: %d, Mins:%d, sec:%d",
//          [nowData description], Year, Mon, Day, Hour, Min,Sec );
    
    NSInteger totalsec = endTime/1000;
    NSInteger totalmin = totalsec/60;
    NSInteger totalhour = totalmin/60;
    NSInteger totalday = totalhour/24;
    
    NSInteger day = totalday;
    NSInteger hour = totalhour - day *24;
    NSInteger min = totalmin - day *24*60 - hour*60;
    NSInteger sec = totalsec - day *24*60*60 - hour*60*60 - min*60;
    
    completeBlock(day,hour,min,sec);
    NSString *countdown = [NSString stringWithFormat:@"距离结束还剩\n %zi天 %zi:%zi:%zi ", day,hour, min, sec];
    if (sec<0) {
        countdown=[NSString stringWithFormat:@"活动结束"];
    }
    return countdown;
}



+ (NSString *)ConvertStrToTime:(long long)time

{
//    [NSString stringWithFormat:@"%ld",timeStr];
//    long long time=[timeStr longLongValue];
    
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    NSString*timeString=[formatter stringFromDate:d];
    
    return timeString;
    
}
@end
