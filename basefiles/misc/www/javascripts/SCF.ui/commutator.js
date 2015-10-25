(function() {
function Commutator() {
}

var klass = Commutator.prototype;
var self = Commutator;
SCF.Commutator = Commutator;

self.init = function() {
    self.bindEvents();
};

self.bindEvents = function() {
    $(self.element).mousedown(function() {
        if ($(this).hasClass("off")) {
            $(this).removeClass("off").addClass("on");
        } else {
            $(this).addClass("off").removeClass("on");
        }
    });
};

// vars
self.element = ".commutator";

}());
