SCF = {};

$(document).ready(function() {
    // Init custom selects
    $(".js-select").chosen();

    // Init slideshow
    var slideshow = new SCF.Slideshow(".js-slideshow");
    slideshow.init();

    // Init slideshow
    var currentlyPlaying = new SCF.CurrentlyPlaying(".js-currently-playing");
    currentlyPlaying.init();

    // Init appreciate
    SCF.Appreciate.init();

    // Init equalizer
    SCF.Equalizer.init();

    // Init datepicker
    SCF.Datepicker.init();

    // Init scrollbox
    SCF.Scrollbox.init();

    // Init commutator
    SCF.Commutator.init();

    // Init tabbox
    var tabBox = new SCF.Tabbox(".tabbox");
    tabBox.init();
    $(".tabbox-stuff").tabs();

    // Init pagination
    SCF.Pagination.init();

    // Custom checkboxes
    var checkbox = new SCF.Checkbox(".js-checkbox");
    checkbox.init();

    // Custom radios
    $(".radiogroup").each(function(index) {
        var selector = "js-radiogroup-" + index;
        $(this).addClass(selector);
        var radioGroup = new SCF.Radio("." + selector);
        radioGroup.init();
    });

    // Init custom placeholder for text inputs
    $("input[placeholder], textarea[placeholder]").placeholder();

    // Init Starbar
    var starBar = new SCF.Starbar(".starbar", 3);
    starBar.init();

    // Init Player
    var player = new SCF.Player(".js-player");
    player.init();

});

