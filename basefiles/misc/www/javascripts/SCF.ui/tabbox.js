(function() {
function Tabbox(element) {
    this.element = element;
    this.tabboxStuff = this.element + " .tabbox-stuff";
    this.tabboxTabs = this.element + " .tabbox-tabs";
    this.tabboxTab = this.tabboxTabs + " li";
    this.activeTabIndex = null;
}

var klass = Tabbox.prototype;
var self = Tabbox;
SCF.Tabbox = Tabbox;

klass.init = function() {
    this.storeActiveTabIndex();
    this.openCorrectTabContent();
    this.bindEvents();
};

klass.bindEvents = function() {
    var _this = this;

    $(this.tabboxTab).click(function() {
        _this.switchTabs(this);
    });
};

klass.openCorrectTabContent = function() {
    $(this.tabboxStuff).addClass("hidden");
    $(this.tabboxStuff).eq(this.activeTabIndex).removeClass("hidden");
};

klass.storeActiveTabIndex = function() {
    var _this = this;

    $(this.tabboxTab).each(function(index) {
        if ($(this).hasClass("active")) {
            _this.activeTabIndex = index;
        }
    });
};

klass.switchTabs = function(tab) {
    $(this.tabboxTab).removeClass("active");
    $(tab).addClass("active");
    this.storeActiveTabIndex();
    this.openCorrectTabContent();
}

}());
