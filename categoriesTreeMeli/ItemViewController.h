//
//  ItemViewController.h
//  categoriesTreeMeli
//
//  Created by usuario on 02/08/14.
//  Copyright (c) 2014 usuario. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterViewController.h"

@interface ItemViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, Filter>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *idToShow;



@end
