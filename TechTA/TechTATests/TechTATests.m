//
//  TechTATests.m
//  TechTATests
//
//  Created by Shih Sunnia on 12/11/5.
//  Copyright (c) 2012年 Shih Sunnia. All rights reserved.
//

#import "TechTATests.h"

@implementation TechTATests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //宣告一個 NSURL 並給予記憶體空間、連線位置
    NSURL *connection = [[NSURL alloc] initWithString:@"http://api.ezcomet.com/write"];
    //宣告要post的值
    NSString *httpBodyString=[NSString stringWithFormat:@"qname=q0423546006-my_channel&api_key=675dc209df5e4ff59e021a1a33547f69&msg=hello"];
    //NSLog(@"httpBodyString = %@",httpBodyString);
    //設定連線位置
    [request setURL:connection];
    //設定連線方式
    [request setHTTPMethod:@"POST"];
    //將編碼改為UTF8
    [request setHTTPBody:[httpBodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    //轉換為NSData傳送
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //看request出來的值
    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}

@end
