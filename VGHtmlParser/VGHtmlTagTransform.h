//
//  VGHtmlNodeTransformer.h
//  HtmlParserDemo
//
//  Created by Vytautas Galaunia on 11/3/14.
//  Copyright (c) 2014 Vytautas Galaunia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TFHpple.h>

@protocol VGHtmlTagTransform <NSObject>

- (NSString *)tagName;
- (NSAttributedString *)transformAttributedString:(NSAttributedString *)attrString element:(TFHppleElement *)element;

@end
