(function() {
function Starbar(element, rating) {
    this.element = element;
    this.rating = rating;
    this.star = this.element + " .star";
}

var klass = Starbar.prototype;
var self = Starbar;
SCF.Starbar = Starbar;

klass.init = function() {
    this.setDefaultRating();
    this.bindEvents();
};

klass.bindEvents = function() {
    var _this = this;

    $(this.star).hover(function() {
        _this.fillRatingUntil(this);
    }, function() {
        _this.setDefaultRating();
    });

    $(this.star).click(function() {
        $(_this.star).unbind();
    });
};

klass.setDefaultRating = function() {
    var last = $(this.star).eq(this.rating - 1);
    this.clearRating();
    this.fillRatingUntil(last);
};

klass.clearRating = function() {
    $(this.star).removeClass("full focus");
};

klass.fillRatingUntil = function(star) {
    this.clearRating();
    $(star).addClass("full focus");
    $(star).prevAll().addClass("full focus");
};

}());
