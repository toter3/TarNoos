var kofApp = angular.module('kofApp', [
    'treeControl',
    'angularSpinner'
]);

kofApp.controller('main', function($scope, $http){

    // server and request paths
    var server_url = 'http://localhost:4567/';
    var urls = {
        db: 'get_schemas',
        schema: 'get_tables',
        table: 'get_columns'
    };

    //set tree options
    $scope.treeOptions = {
        nodeChildren: "children",
        dirSelectable: false,
        injectClasses: {
            ul: "a1",
            li: "node",
            iExpanded : "expanded_node",
            iCollapsed : "collapsed_node",
            liSelected: "a7",
            iLeaf: "column",
            label: "a6",
            labelSelected: "a8"
        },
        isLeaf : function (node){
            return node.type == 'column'
        }
    };

    // init controller initial vals
    $scope.init = function() {
        $scope.dataForTheTree =
            [
                { "name" : "sql_sevrver_amazon_sheker_colshehu"}
            ];
    };

    // gets a node children from server (choose path by node type)
    $scope.get_children =function(node, expanded){
        node.expanded = expanded;
        if(!node.loaded) {
            node.failed = false;
            node.loading = true;
            req_url = server_url + urls[node.type ? node.type : 'db'];
            ancestors = (node.ancestors ? node.ancestors : [])
            ancestors.push(node.name);
            $http.get(req_url, {
                params: {
                    "ancestors[]": ancestors
                }
            }).then(function (data) {
                node.children = data.data;
                node.loaded = true;
            }, function () {
                console.log("faild loading children for " + node.name);
                node.failed = true;
            }).finally(function(){
                node.loading = false;
            })
        }
    };
});