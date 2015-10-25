(function() {
function Datepicker() {
}

var klass = Datepicker.prototype;
var self = Datepicker;
SCF.Datepicker = Datepicker;

self.init = function() {
    self.bindEvents();
};

self.bindEvents = function() {
    $(self.element).datepicker({
        showButtonPanel: true,
        minDate: -20,
        maxDate: "+1M +10D",
        dayNamesMin: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
        firstDay: 1
    });
};

// vars
self.element = ".datepicker-placeholder";

}());
