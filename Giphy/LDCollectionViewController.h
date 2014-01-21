//
//  LDCollectionViewController.h
//  Giphy
//
//  Created by Richard Allen on 1/20/14.
//  Copyright (c) 2014 lapdog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    NSArray *allGifs;
    UIActivityViewController *activityViewController;
}

@end
