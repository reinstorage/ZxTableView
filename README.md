# ZxTableView
如何写好一个TableView

基于MVC架构封装的一个tableView;

以下C中的代码:

@implementation DemoViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    [self createModel];
    
}

-(void)createModel{

    self.listModel = [[DemoTableModel alloc]initWithAddress:@"/mooclist.php"];
    self.listModel.delegate = self;
}

-(void)createDataSource{
    self.dataSource = [[DemoTableViewDataSource alloc] init]; // 创建数据源
}

-(void)requestDidSuccess{
    for (DemoTableBookItem *book in ((DemoTableModel *)self.listModel).tableViewItem.books) {
        ZxTableViewBaseItem *item = [[ZxTableViewBaseItem alloc] init];
        item.itemTitle = book.bookTitle;
        [self.dataSource appendItem:item];
    }
}

@end

