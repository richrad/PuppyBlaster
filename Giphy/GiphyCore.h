//
//  GiphyCore.h
//  Giphy
//
//  Created by Richard Allen on 1/20/14.
//  Copyright (c) 2014 lapdog. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GiphyCore;
@interface GiphyCore : NSObject

+(GiphyCore *)core;

-(void)fetchPuppies;

@end
