(function() {
function Equalizer() {
}

var klass = Equalizer.prototype;
var self = Equalizer;
SCF.Equalizer = Equalizer;

self.init = function() {
    self.bindEvents();
};

self.bindEvents = function() {
    $(self.bar).each(function() {
        // Get a default value for all bars
        var scaleInitialHeight = $(this).find(self.scale).height();

        // Slider mechanics
        $(this).slider({
            slide: function(event, ui){
                var scaleHeight = ui.value;

                $(this).find(self.scale).css({
                    'height': scaleHeight
                });
            },
            max: 114,
            orientation: 'vertical',
            value: scaleInitialHeight
        });
    });
};

// vars
self.element = ".equalizer";
self.bar = self.element + " .equalizer-bar";
self.scale = ".equalizer-scale";

}());
