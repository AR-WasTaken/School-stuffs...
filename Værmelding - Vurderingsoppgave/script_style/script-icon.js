async function weather_now_icon_loader() {
    var today = new Date();
    var time = today.getHours();

    var request = await fetch("https://api.open-meteo.com/v1/forecast?latitude=59.9138&longitude=10.7387&hourly=temperature_2m,apparent_temperature,rain,cloudcover,windspeed_10m,windgusts_10m&daily=weathercode,temperature_2m_max,temperature_2m_min,rain_sum,windspeed_10m_max,windgusts_10m_max,winddirection_10m_dominant&timezone=Europe%2FBerlin")
    var requested = await request.json()
    var answer = await requested.hourly.cloudcover[time]
    var answer_rain = await requested.hourly.rain[time]

    //clouds
    if (answer >= 0 && answer <= 20 && answer_rain <= 0.1) {
        img_sun();
    }
    if (answer >= 21 && answer <= 60 && answer_rain <= 0.1) {
        img_slight_cover();
    }
    if (answer >= 61 && answer <= 101 && answer_rain <= 0.1) {
        img_full_cover();
    }

    //rain
    if (answer >= 0 && answer <= 10 && answer_rain > 0.1) {
        img_rain();
    }
    if (answer >= 11 && answer <= 101 && answer_rain > 0.1) {
        img_rain_with_clouds();
    }
}


//cover

function img_sun() {
    var img = document.createElement('img');
    img.src = 'img/sun.gif';

    document.getElementById('weather').appendChild(img);
}

function img_slight_cover() {
    var img = document.createElement('img');
    img.src = 'img/cloudy.gif';

    document.getElementById('weather').appendChild(img);
}

function img_full_cover() {
    var img = document.createElement('img');
    img.src = 'img/clouds.gif';
    document.getElementById('weather').appendChild(img);
}


// IF RAIN
function img_rain() {
    var img = document.createElement('img');
    img.src = 'img/drop.gif';
    document.getElementById('weather').appendChild(img);
}

function img_rain_with_clouds() {
    var img = document.createElement('img');
    img.src = 'img/rain.gif';
    document.getElementById('weather').appendChild(img);
}