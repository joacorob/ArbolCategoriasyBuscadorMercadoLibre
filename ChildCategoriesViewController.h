//
//  ChildCategoriesViewController.h
//  categoriesTreeMeli
//
//  Created by usuario on 31/07/14.
//  Copyright (c) 2014 usuario. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChildCategoriesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong) NSString *categoria;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

-(void) getChildCategories;
@end
