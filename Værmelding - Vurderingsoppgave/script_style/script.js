function timeNow() {

    var today = new Date();
    var month = today.toLocaleString('en-GB', {
        month: 'short'
    });

    var today = new Date();
    var date = today.getDate() + '-' + month + '-' + today.getFullYear();

    var dateTime = date + ' ';
    document.getElementById("date_today").innerHTML = dateTime;

    console.log(dateTime)
}

function startTime() {
    const today = new Date();
    let h = today.getHours();
    let m = today.getMinutes();
    let s = today.getSeconds();
    m = checkTime(m);
    s = checkTime(s);
    document.getElementById('date_today_1').innerHTML = h + ":" + m + ":" + s;
    setTimeout(startTime, 1000);
}

function checkTime(i) {
    if (i < 10) { i = "0" + i };
    return i;
}


async function weatherNow() {
    var today = new Date();
    var time = today.getHours();

    var request = await fetch("https://api.open-meteo.com/v1/forecast?latitude=59.9138&longitude=10.7387&hourly=temperature_2m,apparent_temperature,rain,cloudcover,windspeed_10m,windgusts_10m&daily=weathercode,temperature_2m_max,temperature_2m_min,rain_sum,windspeed_10m_max,windgusts_10m_max,winddirection_10m_dominant&timezone=Europe%2FBerlin")
    var answer = await request.json()


    document.getElementById("amount_of_rain").innerHTML = answer.hourly.rain[time]

    document.getElementById("amount_of_wind").innerHTML = answer.hourly.windspeed_10m[time]
    document.getElementById("amount_of_wind_gusts").innerHTML = answer.hourly.windgusts_10m[time] + "km/h"

    document.getElementById("amount_of_temperature").innerHTML = answer.hourly.temperature_2m[time]
    document.getElementById("amount_of_temperature_apparent").innerHTML = answer.hourly.apparent_temperature[time]
}


// weather today

async function weatherToday() {
    var request = await fetch("https://api.open-meteo.com/v1/forecast?latitude=59.9138&longitude=10.7387&hourly=temperature_2m,apparent_temperature,rain,cloudcover,windspeed_10m,windgusts_10m&daily=weathercode,temperature_2m_max,temperature_2m_min,rain_sum,windspeed_10m_max,windgusts_10m_max,winddirection_10m_dominant&timezone=Europe%2FBerlin")
    var answer = await request.json()
        //temperature
    for (let i = 1; i <= 24; i++) {
        //document.getElementById("weather_today_hour" + i + "").innerHTML = [i];
        document.getElementById("weather_today_hour" + i + "_rain").innerHTML = answer.hourly.rain[i] + "mm";
        document.getElementById("weather_today_hour" + i + "_wind").innerHTML = answer.hourly.windspeed_10m[i] + "km/h";
        document.getElementById("weather_today_hour" + i + "_temperature").innerHTML = answer.hourly.temperature_2m[i] + "°";
    }
}



setTimeout(function() {
    window.location.reload(timeNow);
}, 120000);