
jQuery.fn.exists = function() {
    return this.length > 0;
};

jQuery.fn.enable = function(bEnable) {
    if (false == bEnable) return this.attr("disabled", "disabled");
    else return this.removeAttr("disabled");
}

jQuery.fn.disable = function(bDisable) {
    if (false == bDisable) return this.removeAttr("disabled");
    else return this.attr("disabled", "disabled");
};