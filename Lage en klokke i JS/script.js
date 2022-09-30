window.onload = startClock

function startClock() {
    setInterval(updateClock, 1000);
}

function updateClock() {
    const d = new Date();
    var sec = d.getSeconds();
    if (sec < 10) {
        sec = "0" + sec;
    }
    var min = d.getMinutes();
    var hour = d.getHours();

    var date = d.getDate();



    document.getElementById("clock").innerHTML = hour + ":" + min + ":" + sec;
}