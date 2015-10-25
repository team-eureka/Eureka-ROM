(function() {
function Pagination() {
}

var klass = Pagination.prototype;
var self = Pagination;
SCF.Pagination = Pagination;

self.init = function() {
    self.bindEvents();
};

self.bindEvents = function() {
    $(self.paginationLink).click(function() {
        $(this).siblings().removeClass("active");
        $(this).addClass("active");
    });
}

// vars
self.element = ".pagination";
self.paginationLink = self.element + " li";

}());
