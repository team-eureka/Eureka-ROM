(function() {
function Scrollbox() {
}

var klass = Scrollbox.prototype;
var self = Scrollbox;
SCF.Scrollbox = Scrollbox;

self.init = function() {
    self.bindEvents();
};

self.bindEvents = function() {
    $(self.element).each(function() {
        // Get a default value for all bars
        var scaleInitialWidth = $(this).find(self.scale).width();
        var scrollboxWidth = $(this).find(self.hitbox).width();

        // Slider mechanics
        $(this).find(self.hitbox).slider({
            slide: function(event, ui){
                var scaleWidth = ui.value;

                $(this).next(self.scale).css({
                    'width': scaleWidth
                });
            },
            max: scrollboxWidth,
            value: scaleInitialWidth
        });
    });
};

// vars
self.element = ".js-scrollbox";
self.scale = ".scale";
self.hitbox = ".hitbox";

}());
