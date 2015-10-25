(function() {
function Appreciate() {
}

var klass = Appreciate.prototype;
var self = Appreciate;
SCF.Appreciate = Appreciate;

self.init = function() {
    self.bindEvents();
};

self.bindEvents = function() {
    $(self.element).click(function() {
        $(this).toggleClass("tnx");
    });
}

// vars
self.element = ".appreciate";

}());
