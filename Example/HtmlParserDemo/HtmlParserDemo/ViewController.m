//
//  ViewController.m
//  HtmlParserDemo
//
//  Created by Vytautas Galaunia on 11/3/14.
//  Copyright (c) 2014 Vytautas Galaunia. All rights reserved.
//

#import "ViewController.h"
#import "VGHtmlParser.h"


@interface ViewController ()

@property (nonatomic, weak) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *string = @"<p>Hello world!<p><a href=\"http://google.com\">LINK</a><p>Bye Bye World!<p>";
    NSData *htmlData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    VGHtmlParser *parser = [[VGHtmlParser alloc] initWithHtmlData:htmlData];
    NSAttributedString *attrString = [parser parse];
    
    if (attrString.length > 16000) {
        attrString = [attrString attributedSubstringFromRange:NSMakeRange(0, 16000)];
    }
    self.label.attributedText = attrString;
}

@end
