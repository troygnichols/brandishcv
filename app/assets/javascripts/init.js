/*
    init.js - things that happen on every page load
    please be judicious about what you add here
 */

$(function() {
    /* enable jquery-ui datatables */
    $(".datatable").each(function(i, el) {
        var dt = $(el),
            inputFilters =  dt.find("tfoot input"),
            selectFilters = dt.find("tfoot select"),
            allFilters = dt.find("tfoot input,select");
        dt.dataTable({
            sPaginationType: "full_numbers",
            bJQueryUI: true,
            bProcessing: true,
            bServerSide: true,
            sAjaxSource: dt.data("source")
        });
        inputFilters.keyup(function() {
            dt.fnFilter(this.value, allFilters.index(this));
        });
        selectFilters.change(function() {
            dt.fnFilter(this.value, allFilters.index(this));
        });
    });
});