$(document).ready(function() {
    /**
    Custom slider labels
    */
    var now = new Date();
    var now_bin = now.getHours() * 2; // bin number, 30-minute bins
    if (now.getMinutes() >= 30) {
        now_bin += 1;
    }
    // Convert bin numbers 0 to 47 to time segments in words
    function binNumberToWords(bin_num) {
        var hour = Math.floor(bin_num / 2);
        if (hour > 12) {
            ampm_start = "pm";
            ampm_finish = "pm";
            hour -= 12;
        } else if (hour === 0) {
            ampm_start = "am";
            ampm_finish = "am";
            hour = 12;
        } else if (hour == 12) {
            ampm_start = "pm";
            ampm_finish = "pm";
        } else {
            ampm_start = "am";
            ampm_finish = "am";
        }
        var remainder = bin_num % 2;
        var time_span = "";
        if (remainder > 0) {
            time_span = hour + ":30" + ampm_start + "-" + hour + ":59" + ampm_finish;
        } else {
            time_span = hour + ":00" + ampm_start + "-" + hour + ":29" + ampm_finish;
        }

        return time_span;
    }

    var slider = $("#timeOfDay").ionRangeSlider({
        prettify: binNumberToWords,
        force_edges: true,
        grid: true,
        grid_num: 4
    });
})