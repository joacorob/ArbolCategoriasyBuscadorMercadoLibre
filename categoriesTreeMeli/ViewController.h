//
//  ViewController.h
//  categoriesTreeMeli
//
//  Created by usuario on 31/07/14.
//  Copyright (c) 2014 usuario. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) NSMutableArray *categories;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
-(void)getCategories;


@end
