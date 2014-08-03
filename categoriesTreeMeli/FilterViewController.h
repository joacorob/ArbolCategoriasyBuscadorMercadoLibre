//
//  FilterViewController.h
//  categoriesTreeMeli
//
//  Created by usuario on 03/08/14.
//  Copyright (c) 2014 usuario. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Filter <NSObject>

-(void)dismissModal:(BOOL)ascending;


@end


@interface FilterViewController : UIViewController

@property id delegate;
- (IBAction)sortAscendente:(id)sender;
- (IBAction)sortDescendente:(id)sender;
-(IBAction)back:(id)sender;


@end
