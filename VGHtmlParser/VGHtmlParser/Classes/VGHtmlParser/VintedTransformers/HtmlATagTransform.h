//
//  HtmlATagTransform.h
//  Vinted
//
//  Created by Vytautas Galaunia on 11/5/14.
//  Copyright (c) 2014 Vinted. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VGHtmlTagTransform.h>

extern NSString * const VintedLinkAttributeName;

@interface HtmlATagTransform : NSObject<VGHtmlTagTransform>

@property (nonatomic) NSDictionary *linkAttributes;

@end
