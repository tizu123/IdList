//
//  NSManagedObjectID+getId.m
//  IdList
//
//  Created by tizu123 on 12/08/10.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import "NSManagedObjectID+getId.h"

@implementation NSManagedObjectID (getId)

- (NSString *)pid
{
    // favicon保存先のファイル名の決定
    // ファイル名をObjectIDから生成。正規表現を使う
    // objectID.descriptionの形式が<x-coredata://2953428C-8D53-4353-9D6F-4E954587EBF8/Account/p1>
    // 最後のp1をファイル名にしたいので、下記のような正規表現で取得する。
    NSRegularExpression *exp = [NSRegularExpression regularExpressionWithPattern:@".*/(p.*)>$" options:0 error:nil];
    NSTextCheckingResult *match = [exp firstMatchInString:self.description options:0 range:NSMakeRange(0, self.description.length)];
    return [self.description substringWithRange:[match rangeAtIndex:1]];
}

@end
