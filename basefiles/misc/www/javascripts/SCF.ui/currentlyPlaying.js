(function() {
function CurrentlyPlaying(element) {
    this.element    = element;
    this.scale      = this.element + " .js-currently-playing-scale";
    this.hitbox     = this.element + " .js-currently-playing-hitbox";
}

var klass = CurrentlyPlaying.prototype;
var self = CurrentlyPlaying;
SCF.CurrentlyPlaying = CurrentlyPlaying;

klass.init = function() {
    this.bindEvents();
};

klass.bindEvents = function() {
    var _this = this;
    var scaleInitialWidth = $(this.scale).width();
    var scrollboxWidth = $(this.hitbox).width();

    // Slider mechanics
    $(this.hitbox).slider({
        slide: function(event, ui){
            var scaleWidth = ui.value;

            $(_this.scale).css({
                'width': scaleWidth
            });
        },
        max: scrollboxWidth,
        value: scaleInitialWidth
    });
}

}());
