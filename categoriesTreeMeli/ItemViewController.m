//
//  ItemViewController.m
//  categoriesTreeMeli
//
//  Created by usuario on 02/08/14.
//  Copyright (c) 2014 usuario. All rights reserved.
//

#import "ItemViewController.h"
#import "CustomTableViewCell.h"
#import "SingleItemViewController.h"
#import "FilterViewController.h"

@interface ItemViewController ()
{
    NSMutableArray *itemToShow;
}

@end

@implementation ItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    itemToShow = [[NSMutableArray alloc] initWithArray:self.idToShow];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma  mark - delegate

-(void) dismissModal:(BOOL)ascending {
    [self dismissViewControllerAnimated:YES completion:nil];
    if (ascending) {
        NSSortDescriptor *sortByPrice = [[NSSortDescriptor alloc] initWithKey:@"price" ascending: FALSE];
        
        NSMutableArray *sortResults = [itemToShow sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortByPrice]];
        if ([sortResults count] != 0)
        {
            for (NSUInteger i = 0; i < [sortResults count]; i++)
            {
                NSDictionary *elem = [ sortResults objectAtIndex:i];
                [itemToShow insertObject:elem atIndex:i];
                [self.tableView reloadData];
            }
            
        } else
        {
            [self.tableView reloadData];
        }
    } else {
        NSSortDescriptor *sortByPrice = [[NSSortDescriptor alloc] initWithKey:@"price" ascending: TRUE];
        
        NSMutableArray *sortResults = [itemToShow sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortByPrice]];
        if ([sortResults count] != 0)
        {
            for (NSUInteger i = 0; i < [sortResults count]; i++)
            {
                NSDictionary *elem = [ sortResults objectAtIndex:i];
                [itemToShow insertObject:elem atIndex:i];
                [self.tableView reloadData];
            }
            
        } else
        {
            [self.tableView reloadData];
        }

        
    }
    
}



#pragma mark- tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [itemToShow count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    
    //preparo precio
    NSString *precio = [[itemToShow objectAtIndex:indexPath.row] objectForKey:@"price"];
    if ([precio isKindOfClass:[NSNull class]]) {
        cell.lblPrecio.text = @"Precio a convenir";
        
    }
    else
    {
        cell.lblPrecio.text = [NSString stringWithFormat:@"%@ %@",[[itemToShow objectAtIndex:indexPath.row] objectForKey:@"currency_id"], precio];
    }
    
    //preparo thumnail
    NSURL *url = [NSURL URLWithString:[[itemToShow objectAtIndex:indexPath.row] objectForKey:@"thumbnail"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    
    //declaro propiedades de la celda
    cell.lblTitulo.text = [[itemToShow objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    cell.imageView.image = img;
    

    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ( [segue.identifier isEqualToString:@"item"]) {
        NSIndexPath *itemSelected = [self.tableView indexPathForCell:sender];
        NSDictionary *toSingleItem = [itemToShow objectAtIndex:itemSelected.row];
        
        SingleItemViewController *instance = [segue destinationViewController];
        instance.itemSelected = toSingleItem;
    }
    else {
        FilterViewController *modal = [segue destinationViewController];
        modal.delegate = self;
    }
    
    
    
}




@end
