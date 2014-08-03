//
//  ViewController.m
//  categoriesTreeMeli
//
//  Created by usuario on 31/07/14.
//  Copyright (c) 2014 usuario. All rights reserved.
//

#import "ViewController.h"
#import "ChildCategoriesViewController.h"

@interface ViewController ()
{
    NSMutableArray *categories;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    categories = [NSMutableArray array];
    [self getCategories];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getCategories {
    NSString *url = [NSString stringWithFormat:@"https://api.mercadolibre.com/sites/MLU/categories"];
    
    
    //busco los datos
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    //los dejo en un data
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    
    //armo el array
    NSError *jsonParsingError = nil;
    NSMutableArray *datos = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonParsingError];
    
    
    for (NSUInteger i=0; i<[datos count]; i++) {
        NSDictionary *elemento = [datos objectAtIndex:i];
        [categories insertObject:elemento atIndex:i];
        [self.tableView reloadData];
    }

}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    
//    // Return the number of sections.
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [categories count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [[categories objectAtIndex:indexPath.row] objectForKey:@"name"];
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSIndexPath *indiceSeleccionado = [self.tableView indexPathForCell:sender];
    
    NSString *categoriaSeleccionada = [[categories objectAtIndex:indiceSeleccionado.row] objectForKey:@"id"];
    
    ChildCategoriesViewController *apasar = [segue destinationViewController];
    apasar.categoria = categoriaSeleccionada;
    
    
}

@end
