(function() {
function Slideshow(element) {
    this.element     = element;
    this.slides      = this.element + " .js-slideshow-slides";
    this.slide       = this.element + " .js-slideshow-slide";
    this.nextSlide   = this.element + " .js-slideshow-next-slide";
    this.prevSlide   = this.element + " .js-slideshow-prev-slide";
    this.slidesCount = $(this.slide).size();
    this.slideWidth  = $(this.slide).width();
    this.slidesWidth = this.slideWidth * this.slidesCount;
}

var klass = Slideshow.prototype;
var self = Slideshow;
SCF.Slideshow = Slideshow;

klass.init = function() {
    this.setSlidesWidth();
    this.bindEvents();
};

klass.bindEvents = function() {
    var _this = this;

    $(this.nextSlide).click(function() {
        _this.showNextSlide();
    });

    $(this.prevSlide).click(function() {
        _this.showPrevSlide();
    });
}

klass.setSlidesWidth = function() {
    $(this.slides).width(this.slidesWidth);
}

klass.showNextSlide = function() {
    var _this = this;
    var currentSlidesPosition = $(this.slides).position().left;
    var slideShiftWidth       = currentSlidesPosition - this.slideWidth;
    var lastSlidePosition     = (1 - this.slidesCount) * this.slideWidth;

    $(this.slides).css("left", slideShiftWidth);

    if (currentSlidesPosition <= lastSlidePosition) {
        $(_this.slides).css("left", 0);
    }
};

klass.showPrevSlide = function() {
    var _this = this;
    var currentSlidesPosition = $(this.slides).position().left;
    var slideShiftWidth       = currentSlidesPosition + this.slideWidth;
    var firstSlidePosition    = this.slideWidth - this.slidesWidth;

    $(this.slides).css("left", (slideShiftWidth));

    if (currentSlidesPosition >= 0) {
        $(_this.slides).css("left", firstSlidePosition);
    }
};

}());
