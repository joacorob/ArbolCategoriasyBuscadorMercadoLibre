//
//  SearchViewController.h
//  categoriesTreeMeli
//
//  Created by usuario on 02/08/14.
//  Copyright (c) 2014 usuario. All rights reserved.
//

#import "ViewController.h"

@interface SearchViewController : ViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)getSearch:(id)sender;

@end
