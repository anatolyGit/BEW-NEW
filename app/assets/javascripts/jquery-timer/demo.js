/**
 * jQuery Timer doesn't natively act like a stopwatch, it only
 * aids in building one.  You need to keep track of the current
 * time in a variable and increment it manually.  Then on each
 * incrementation, update the page.
 *
 * The increment time for jQuery Timer is in milliseconds. So an
 * input time of 1000 would equal 1 time per second.  In this
 * example we use an increment time of 70 which is roughly 14
 * times per second.  You can adjust your timer if you wish.
 *
 * The update function converts the current time to minutes,
 * seconds and hundredths of a second.  It then outputs that to
 * the stopwatch element, $stopwatch, and then increments. Since
 * the current time is stored in hundredths of a second so the
 * increment time must be divided by ten.
 */
var Example1 = new (function() {
    var $stopwatch, // Stopwatch element on the page
        incrementTime = 70, // Timer speed in milliseconds
        currentTime = 0, // Current time in hundredths of a second
        updateTimer = function() {
            $stopwatch.html(formatTime(currentTime));
            currentTime += incrementTime / 10;
        },
        init = function() {
            $stopwatch = $('#stopwatch');
            Example1.Timer = $.timer(updateTimer, incrementTime, true);
        };
    this.resetStopwatch = function() {
    	alert(formatTime(currentTime));
        currentTime = 0;
        this.Timer.stop().once();

    };
    $(init);
});


/**
 * Example 2 is similar to example 1.  The biggest difference
 * besides counting up is the ability to reset the timer to a
 * specific time.  To do this, there is an input text field
 * in a form.
 */


/**
 * Example 4 is as simple as it gets.  Just a timer object and
 * a counter that is displayed as it updates.
 */


// Common functions
function pad(number, length) {
    var str = '' + number;
    while (str.length < length) {str = '0' + str;}
    return str;
}
function formatTime(time) {
    var min = parseInt(time / 6000),
        sec = parseInt(time / 100) - (min * 60),
        hundredths = pad(time - (sec * 100) - (min * 6000), 2);
    return (min > 0 ? pad(min, 2) : "00") + ":" + pad(sec, 2) + ":" + hundredths;
}