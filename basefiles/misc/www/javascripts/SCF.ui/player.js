(function() {
function Player(element) {
    this.element          = element;
    this.volumeScale      = this.element + " .js-volume-scale";
    this.volumeBar        = this.element + " .js-volume-bar";
}

var klass = Player.prototype;
var self = Player;
SCF.Player = Player;

klass.init = function() {
    this.bindEvents();
};

klass.bindEvents = function() {
    var _this = this;

    $(this.element).click(function() {
        _this.toggleVolume();
    });

    $(this.volumeScale).mousedown(function(event) {
        $(this).mousemove(function(event) {
            _this.setVolume(event);
        });

        $(this).mouseup(function(event) {
            $(this).unbind("mousemove");
            _this.collapseVolume();
        });
    });

    $(this.volumeScale).click(function(event) {
        _this.setVolume(event);
    });
}

klass.setVolume = function(event) {
    var offsetLeftValue  = $(this.volumeScale).offset().left;
    var trackPosition    = event.pageX - offsetLeftValue - 12;
    var volumeScaleWidth = $(this.volumeScale).width() * 1.06;
    var volumeBarWidth   = trackPosition * 100 / volumeScaleWidth;
    $(this.volumeBar).width(volumeBarWidth + "%");
}

klass.toggleVolume = function() {
    var _this = this;

    if ($(this.element).hasClass("opened")) {
        _this.collapseVolume();
    } else {
        _this.expandVolume();
    }
};

klass.expandVolume = function() {
    $(this.element).addClass("opened");
};

klass.collapseVolume = function() {
    var _this = this;

    setTimeout(function() {
        $(_this.element).removeClass("opened");
    }, 300);
};

}());
