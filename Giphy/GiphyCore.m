//
//  GiphyCore.m
//  Giphy
//
//  Created by Richard Allen on 1/20/14.
//  Copyright (c) 2014 lapdog. All rights reserved.
//

#import "GiphyCore.h"
#import "AFNetworking/AFHTTPRequestOperation.h"
#import "NSString+Better.h"

@implementation GiphyCore

-(NSString *)apiKey
{
    return @"dc6zaTOxFJmzC";
}

+(GiphyCore *)core
{
    static dispatch_once_t pred;
    static GiphyCore *core = nil;
    
    dispatch_once(&pred, ^{
        core = [[GiphyCore alloc] init];
    });
    
    return core;
}

-(id)init
{
    self = [super init];
    if(self)
    {
        
        return self;
    }
    return self;
}

-(void)fetchPuppies
{
    NSLog(@"Fetching puppy gifs");
    
    NSString *getString = [NSString stringWithFormat:@"http://api.giphy.com/v1/gifs/search?q=puppies&api_key=%@", [self apiKey]];
    NSLog(@"%@", getString);
    NSURL *url = [NSURL URLWithString:getString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setResponseSerializer:[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments]];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Succeeded With Response Code: %ld", (long)operation.response.statusCode);
         [[NSNotificationCenter defaultCenter] postNotificationName:@"RetrievedPuppyGifs" object:responseObject];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSString *statusCode = [[operation responseString] justNumbers];
         NSLog(@"Failed With Response Code: %@", statusCode);
     }];
    
    [[NSOperationQueue mainQueue] addOperation:operation];
}

@end
