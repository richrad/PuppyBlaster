//
//  LDCollectionViewController.m
//  Giphy
//
//  Created by Richard Allen on 1/20/14.
//  Copyright (c) 2014 lapdog. All rights reserved.
//

#import "LDCollectionViewController.h"
#import "GiphyCore.h"
#import "UIImage+animatedGIF.h"

@interface LDCollectionViewController ()

@end

@implementation LDCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAllGifs:) name:@"RetrievedPuppyGifs" object:nil];
    [[GiphyCore core] fetchPuppies];
}

-(void)updateAllGifs:(NSNotification *)note
{
    allGifs = [[note object] objectForKey:@"data"];
    [[self collectionView] reloadData];
}


#pragma mark - Collection View Delegate / Data Source

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [allGifs count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    spinner.tag = 200;
    spinner.frame = CGRectMake(100, 100, 1, 1);
    [cell addSubview:spinner];
    [spinner startAnimating];
    
    NSDictionary *gif = [allGifs objectAtIndex:indexPath.row];
    NSDictionary *fixedHeightGif = [[gif objectForKey:@"images"] objectForKey:@"fixed_height"];
    NSURL *fixedHeightGifURL = [NSURL URLWithString:[fixedHeightGif objectForKey:@"url"]];
    UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[fixedHeightGif objectForKey:@"width"] floatValue], [[fixedHeightGif objectForKey:@"height"] floatValue])];
    gifImageView.tag = 100;
    
    [cell addSubview:gifImageView];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        UIImage *image = [UIImage animatedImageWithAnimatedGIFURL:fixedHeightGifURL];
        
        dispatch_sync(dispatch_get_main_queue(), ^(void) {
            UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
            UIActivityIndicatorView *spinner = (UIActivityIndicatorView *)[cell viewWithTag:200];
            [spinner stopAnimating];
            [imageView setAlpha:0];
            imageView.image = image;
            
            [UIView animateWithDuration:.2 animations:^(void){
                [imageView setAlpha:1];
            }];
            
        });
    });
    
    return cell;
}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout  *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSDictionary *gif = [allGifs objectAtIndex:indexPath.row];
//    NSDictionary *fixedHeightGif = [[gif objectForKey:@"images"] objectForKey:@"fixed_height"];
//    
//    return CGSizeMake(200, [[fixedHeightGif objectForKey:@"width"] floatValue]);
//}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *gif = [allGifs objectAtIndex:indexPath.row];
    NSURL *bitlyGifURL = [NSURL URLWithString:[gif objectForKey:@"bitly_gif_url"]];
    activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[bitlyGifURL] applicationActivities:nil];
    
    [self presentViewController:activityViewController animated:YES completion:nil];
}

@end
