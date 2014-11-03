//
//  HtmlParserDemoTests.m
//  HtmlParserDemoTests
//
//  Created by Vytautas Galaunia on 11/3/14.
//  Copyright (c) 2014 Vytautas Galaunia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "VGHtmlParser.h"
#import "VGHtmlATagTransfom.h"
#import "VGHtmlBrTagTransform.h"

#define EXP_SHORTHAND
#import "Expecta.h"

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

@interface HtmlParserDemoTests : XCTestCase

@end

@implementation HtmlParserDemoTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

#pragma mark - Helpers

- (NSData *)dataFromString:(NSString *)string
{
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - Tests

- (void)testParserInitialization
{
    NSData *htmlData = [NSData data];
    VGHtmlParser *parser = [[VGHtmlParser alloc] initWithHtmlData:htmlData];
    NSAttributedString *attrString = [parser parse];
    
    expect(parser.htmlData).to.equal(htmlData);
    expect([parser htmlTagTransformForTagName:@"a"]).toNot.beNil;
    expect([parser htmlTagTransformForTagName:@"br"]).toNot.beNil;
    expect(attrString.length).to.equal(0);
}

- (void)testBrTagParsing
{
    VGHtmlParser *parser = [[VGHtmlParser alloc] initWithHtmlData:[self dataFromString:@"<br/><br/>"]];
    NSAttributedString *attrString = [parser parse];
    
    expect([attrString string]).to.equal(@"");
}

- (void)testSimpleTextParsing
{
    VGHtmlParser *parser = [[VGHtmlParser alloc] initWithHtmlData:[self dataFromString:@"Hello world!"]];
    NSAttributedString *attrString = [parser parse];
    expect([attrString string]).to.equal(@"Hello world!");
}

- (void)testHtmlEscape1
{
    VGHtmlParser *parser = [[VGHtmlParser alloc] initWithHtmlData:[self dataFromString:@"&amp;"]];
    NSAttributedString *attrString = [parser parse];
    expect([attrString string]).to.equal(@"&");
}

- (void)testHtmlEscape2
{
    NSString *string = @"&iexcl;&cent;&pound;&curren;&yen;&brvbar;&sect;&auml;&sup2;&sup3;&thorn;&ucirc;&oslash;";
    VGHtmlParser *parser = [[VGHtmlParser alloc] initWithHtmlData:[self dataFromString:string]];
    NSAttributedString *attrString = [parser parse];
    expect([attrString string]).to.equal(@"¡¢£¤¥¦§ä²³þûø");
}

- (void)testHtmlEscape3
{
    NSString *string = @"&#161;&#162;&#163;&#164;&#165;&#166;&#167;&#228;&#178;&#179;&#254;&#251;&#248;";
    VGHtmlParser *parser = [[VGHtmlParser alloc] initWithHtmlData:[self dataFromString:string]];
    NSAttributedString *attrString = [parser parse];
    expect([attrString string]).to.equal(@"¡¢£¤¥¦§ä²³þûø");
}

- (void)testLinkParsing
{
    NSString *string = @"<a href=\"http://www.google.com\">Link to google</a>";
    VGHtmlParser *parser = [[VGHtmlParser alloc] initWithHtmlData:[self dataFromString:string]];
    NSAttributedString *attrString = [parser parse];
    expect([attrString string]).to.equal(@"Link to google");
    NSURL *url = [attrString attribute:NSLinkAttributeName atIndex:1 effectiveRange:NULL];
    expect(url).to.equal([NSURL URLWithString:@"http://www.google.com"]);
}

- (void)testPreinstalledHtmlTagTransforms
{
    VGHtmlParser *parser = [[VGHtmlParser alloc] initWithHtmlData:[self dataFromString:@""]];
    expect([[parser htmlTagTransforms] count]).to.equal(3);
}

- (void)testHtmlTagTransformRemoval
{
    VGHtmlParser *parser = [[VGHtmlParser alloc] initWithHtmlData:[self dataFromString:@""]];
    id <VGHtmlTagTransform> transform = [[parser htmlTagTransforms] firstObject];
    [parser removeHtmlTagTransformForTagName:transform.tagName];
    expect([[parser htmlTagTransforms] count]).to.equal(2);
}

- (void)testAllHtmlTagTransformRemoval
{
    VGHtmlParser *parser = [[VGHtmlParser alloc] initWithHtmlData:[self dataFromString:@""]];
    [parser removeAllHtmlTagTranforms];
    expect([[parser htmlTagTransforms] count]).to.equal(0);
}

- (void)testHtmlTagTransformGetException
{
    VGHtmlParser *parser = [[VGHtmlParser alloc] initWithHtmlData:[self dataFromString:@""]];
    expect(^{ [parser htmlTagTransformForTagName:nil]; }).to.raise(VGHtmlParserMissingTagNameException);
    expect(^{ [parser htmlTagTransformForTagName:@""]; }).to.raise(VGHtmlParserMissingTagNameException);
}

- (void)testHtmlTagTransformRemoveException
{
    VGHtmlParser *parser = [[VGHtmlParser alloc] initWithHtmlData:[self dataFromString:@""]];
    expect(^{ [parser removeHtmlTagTransformForTagName:nil]; }).to.raise(VGHtmlParserMissingTagNameException);
    expect(^{ [parser removeHtmlTagTransformForTagName:@""]; }).to.raise(VGHtmlParserMissingTagNameException);
}

- (void)testHtmlTagTransformAddException
{
    NSObject<VGHtmlTagTransform> *transformTagNameNil = mockProtocol(@protocol(VGHtmlTagTransform));
    [given([transformTagNameNil tagName]) willReturn:nil];
    NSObject<VGHtmlTagTransform> *transformTagNameEmptyString = mockProtocol(@protocol(VGHtmlTagTransform));
    [given([transformTagNameEmptyString tagName]) willReturn:@""];
    
    VGHtmlParser *parser = [[VGHtmlParser alloc] initWithHtmlData:[self dataFromString:@""]];
    expect(^{ [parser addHtmlTagTransform:transformTagNameNil]; }).to.raise(VGHtmlParserMissingTagNameException);
    expect(^{ [parser addHtmlTagTransform:transformTagNameEmptyString]; }).to.raise(VGHtmlParserMissingTagNameException);
}

- (void)testPerformance1
{
    [self measureBlock:^{
        NSURL *htmlUrl = [[NSBundle mainBundle] URLForResource:@"html1" withExtension:@"html"];
        NSData *htmlData = [NSData dataWithContentsOfURL:htmlUrl];
        VGHtmlParser *parser = [[VGHtmlParser alloc] initWithHtmlData:htmlData];
        NSAttributedString *attrString = [parser parse];
        expect(attrString.length).to.equal(44206);
    }];
}

- (void)testPerformance2
{
    [self measureBlock:^{
        NSString *string = @"Example of message with a link <a href=\"http://www.google.com\">Link to google</a>";
        VGHtmlParser *parser = [[VGHtmlParser alloc] initWithHtmlData:[self dataFromString:string]];
        NSAttributedString *attrString = [parser parse];
        expect(attrString.length).to.equal(45);
    }];
}

@end

#pragma mark -
