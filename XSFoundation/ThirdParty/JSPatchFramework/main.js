defineClass("JSPatchManager", {
            tableView_didSelectRowAtIndexPath: function(tableView, indexPath) {
            var row = indexPath.row()
            if (self.dataSource().length > row) {  //加上判断越界的逻辑
            var content = self.dataArr()[row];
            var controller = XRViewController.alloc().initWithContent(content);
            self.navigationController().pushViewController(controller);
            }
        }
    }
)
