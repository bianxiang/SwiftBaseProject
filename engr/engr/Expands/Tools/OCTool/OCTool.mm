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



//unicodeToUtf8
+(NSString *) unescape:(NSString *)string
{
    
//    return [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSMutableString *outputStr = [NSMutableString stringWithString:string];
//    
//    [outputStr replaceOccurrencesOfString:@"+"
//     
//                               withString:@" "
//     
//                                  options:NSLiteralSearch
//     
//                                    range:NSMakeRange(0, [outputStr length])];
//    
//    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    
//    NSString *tempStr1 = [string stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
//    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
//    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
//    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
//    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
//                                                           mutabilityOption:NSPropertyListImmutable
//                                                                     format:NULL
//                                                           errorDescription:NULL];
//    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
    return [self replaceUnicodeTest:string];
}
+(NSString *)escape:(NSString *)str
{
    NSArray *hex = [NSArray arrayWithObjects:
                    @"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"0A",@"0B",@"0C",@"0D",@"0E",@"0F",
                    @"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"1A",@"1B",@"1C",@"1D",@"1E",@"1F",
                    @"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"2A",@"2B",@"2C",@"2D",@"2E",@"2F",
                    @"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"3A",@"3B",@"3C",@"3D",@"3E",@"3F",
                    @"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"4A",@"4B",@"4C",@"4D",@"4E",@"4F",
                    @"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59",@"5A",@"5B",@"5C",@"5D",@"5E",@"5F",
                    @"60",@"61",@"62",@"63",@"64",@"65",@"66",@"67",@"68",@"69",@"6A",@"6B",@"6C",@"6D",@"6E",@"6F",
                    @"70",@"71",@"72",@"73",@"74",@"75",@"76",@"77",@"78",@"79",@"7A",@"7B",@"7C",@"7D",@"7E",@"7F",
                    @"80",@"81",@"82",@"83",@"84",@"85",@"86",@"87",@"88",@"89",@"8A",@"8B",@"8C",@"8D",@"8E",@"8F",
                    @"90",@"91",@"92",@"93",@"94",@"95",@"96",@"97",@"98",@"99",@"9A",@"9B",@"9C",@"9D",@"9E",@"9F",
                    @"A0",@"A1",@"A2",@"A3",@"A4",@"A5",@"A6",@"A7",@"A8",@"A9",@"AA",@"AB",@"AC",@"AD",@"AE",@"AF",
                    @"B0",@"B1",@"B2",@"B3",@"B4",@"B5",@"B6",@"B7",@"B8",@"B9",@"BA",@"BB",@"BC",@"BD",@"BE",@"BF",
                    @"C0",@"C1",@"C2",@"C3",@"C4",@"C5",@"C6",@"C7",@"C8",@"C9",@"CA",@"CB",@"CC",@"CD",@"CE",@"CF",
                    @"D0",@"D1",@"D2",@"D3",@"D4",@"D5",@"D6",@"D7",@"D8",@"D9",@"DA",@"DB",@"DC",@"DD",@"DE",@"DF",
                    @"E0",@"E1",@"E2",@"E3",@"E4",@"E5",@"E6",@"E7",@"E8",@"E9",@"EA",@"EB",@"EC",@"ED",@"EE",@"EF",
                    @"F0",@"F1",@"F2",@"F3",@"F4",@"F5",@"F6",@"F7",@"F8",@"F9",@"FA",@"FB",@"FC",@"FD",@"FE",@"FF", nil];
    
    NSMutableString *result = [NSMutableString stringWithString:@""];
    int strLength = str.length;
    for (int i=0; i<strLength; i++) {
        int ch = [str characterAtIndex:i];
        if (ch == ' ')
        {
            [result appendFormat:@"%C",'+'];
        }
        else if ('A' <= ch && ch <= 'Z')
        {
            [result appendFormat:@"%C",(char)ch];
            
        }
        else if ('a' <= ch && ch <= 'z')
        {
            [result appendFormat:@"%C",(char)ch];
        }
        else if ('0' <= ch && ch<='9')
        {
            [result appendFormat:@"%C",(char)ch];
        }
        else if (ch == '-' || ch == '_'
                 || ch == '.' || ch == '!'
                 || ch == '~' || ch == '*'
                 || ch == '\'' || ch == '('
                 || ch == ')')
        {
            [result appendFormat:@"%C",(char)ch];
        }
        else if (ch <= 0x007F)
        {
            [result appendFormat:@"%%",'%'];
            [result appendString:[hex objectAtIndex:ch]];
        }
        else
        {
            [result appendFormat:@"%%",'%'];
            [result appendFormat:@"%C",'u'];
            [result appendString:[hex objectAtIndex:ch>>8]];
            [result appendString:[hex objectAtIndex:0x00FF & ch]];
        }
    }
    return result;
}
//utf8ToUnicode
//+(NSString *) escape:(NSString *)str
//{
//    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@"\\r\\n"];
//
//    NSArray *hex = [NSArray arrayWithObjects:
//                    @"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"0A",@"0B",@"0C",@"0D",@"0E",@"0F",
//                    @"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"1A",@"1B",@"1C",@"1D",@"1E",@"1F",
//                    @"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"2A",@"2B",@"2C",@"2D",@"2E",@"2F",
//                    @"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"3A",@"3B",@"3C",@"3D",@"3E",@"3F",
//                    @"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"4A",@"4B",@"4C",@"4D",@"4E",@"4F",
//                    @"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59",@"5A",@"5B",@"5C",@"5D",@"5E",@"5F",
//                    @"60",@"61",@"62",@"63",@"64",@"65",@"66",@"67",@"68",@"69",@"6A",@"6B",@"6C",@"6D",@"6E",@"6F",
//                    @"70",@"71",@"72",@"73",@"74",@"75",@"76",@"77",@"78",@"79",@"7A",@"7B",@"7C",@"7D",@"7E",@"7F",
//                    @"80",@"81",@"82",@"83",@"84",@"85",@"86",@"87",@"88",@"89",@"8A",@"8B",@"8C",@"8D",@"8E",@"8F",
//                    @"90",@"91",@"92",@"93",@"94",@"95",@"96",@"97",@"98",@"99",@"9A",@"9B",@"9C",@"9D",@"9E",@"9F",
//                    @"A0",@"A1",@"A2",@"A3",@"A4",@"A5",@"A6",@"A7",@"A8",@"A9",@"AA",@"AB",@"AC",@"AD",@"AE",@"AF",
//                    @"B0",@"B1",@"B2",@"B3",@"B4",@"B5",@"B6",@"B7",@"B8",@"B9",@"BA",@"BB",@"BC",@"BD",@"BE",@"BF",
//                    @"C0",@"C1",@"C2",@"C3",@"C4",@"C5",@"C6",@"C7",@"C8",@"C9",@"CA",@"CB",@"CC",@"CD",@"CE",@"CF",
//                    @"D0",@"D1",@"D2",@"D3",@"D4",@"D5",@"D6",@"D7",@"D8",@"D9",@"DA",@"DB",@"DC",@"DD",@"DE",@"DF",
//                    @"E0",@"E1",@"E2",@"E3",@"E4",@"E5",@"E6",@"E7",@"E8",@"E9",@"EA",@"EB",@"EC",@"ED",@"EE",@"EF",
//                    @"F0",@"F1",@"F2",@"F3",@"F4",@"F5",@"F6",@"F7",@"F8",@"F9",@"FA",@"FB",@"FC",@"FD",@"FE",@"FF", nil];
//    
//    NSMutableString *result = [NSMutableString stringWithString:@""];
//    int strLength = str.length;
//    for (int i=0; i<strLength; i++) {
//        int ch = [str characterAtIndex:i];
//        if (ch == ' ')
//        {
//            [result appendFormat:@"%C",'+'];
//        }
//        else if ('A' <= ch && ch <= 'Z')
//        {
//            [result appendFormat:@"%C",(char)ch];
//            
//        }
//        else if ('a' <= ch && ch <= 'z')
//        {
//            [result appendFormat:@"%C",(char)ch];
//        }
//        else if ('0' <= ch && ch<='9')
//        {
//            [result appendFormat:@"%C",(char)ch];
//        }
//        else if (ch == '-' || ch == '_'
//                 || ch == '.' || ch == '!'
//                 || ch == '~' || ch == '*'
//                 || ch == '\'' || ch == '('
//                 || ch == ')')
//        {
//            [result appendFormat:@"%C",(char)ch];
//        }
//        else if (ch <= 0x007F)
//        {
//            [result appendFormat:@"%%",'%'];
//            [result appendString:[hex objectAtIndex:ch]];
//        }
//        else
//        {
//            [result appendFormat:@"%%",'%'];
//            [result appendFormat:@"%C",'u'];
//            [result appendString:[hex objectAtIndex:ch>>8]];
//            [result appendString:[hex objectAtIndex:0x00FF & ch]];
//        }
//    }
//    return result;
//    
//}



+ (NSString *)replaceUnicodeTest:(NSString *)test
{// test为需要解码的字符串
    NSString *body = test;
    NSMutableString *mutableStr = [[NSMutableString alloc] initWithCapacity:1];
    NSScanner*scanner=[NSScanner scannerWithString:body];
    [scanner setCaseSensitive:YES]; // yes 区分大小写
    NSString *keyString01 = @"%";
    
    int lastPos = 0;  int pos = 0;
    while (lastPos < body.length) {
        @autoreleasepool{
            pos = [self indexOf:body andPre:keyString01 andStartLocation:lastPos];
            if (pos == lastPos) {
                // 转为unicode 编码 再解码
                if ([body characterAtIndex:(pos + 1)] == 'u') {
                    NSRange range = NSMakeRange(pos, 6);
                    NSString *tempBody =[body substringWithRange:range];
                    NSString *temp01 = [tempBody stringByReplacingOccurrencesOfString:@"%" withString:@"\\"];
                    NSString *temp02 = [self replaceUnicode:temp01]; // 转为中文
                    //                NSLog(@"--%@",temp02);
                    [mutableStr appendString:temp02];
                    lastPos = pos + 6;
                } else {
                    NSRange range = NSMakeRange(pos, 3);
                    NSString *tempBody =[body substringWithRange:range];
                    NSString *temp01 = [tempBody stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//                    NSLog(@"--%@",temp01);
                    if (temp01) {
                        [mutableStr appendString:temp01];
                    }
                    
                    lastPos = pos + 3;
                }
            }else if (pos == -1) {
                NSString *tempBody =[body substringFromIndex:lastPos];
                [mutableStr appendFormat:@"%@",tempBody];
                lastPos = (int)body.length;
            }else {
                NSRange range = NSMakeRange(lastPos, pos-lastPos);
                NSString *tempBody =[body substringWithRange:range];
                [mutableStr appendString:tempBody];
                lastPos = pos;
            }
        }
    }
    
    return mutableStr;
}
// 转为中文
+ (NSString *)replaceUnicode:(NSString *)msg
{
    NSString *tempStr1 = [msg stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF16StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}
// 查找有咩有百分号 并返回ta的位置
+ (int)indexOf:(NSString *)allStr andPre:(NSString *)pre andStartLocation:(int)StartLocation
{
    NSString *body = [allStr substringFromIndex:StartLocation];
    NSScanner*scanner=[NSScanner scannerWithString:body];
    NSString *keyString01 = pre;
    [scanner setCaseSensitive:YES]; // yes 区分大小写
    
    BOOL b = NO;
    int returnInt = 0;
    while (![scanner isAtEnd]) {
        b = [scanner scanString:keyString01 intoString:NULL];
        if(b) {
            returnInt = StartLocation + (int)scanner.scanLocation - 1;
            break;
        }
        
        scanner.scanLocation++;
    }
    
    if (!b) {
        returnInt = -1;
    }
    
    return returnInt;
    
    
}
@end
