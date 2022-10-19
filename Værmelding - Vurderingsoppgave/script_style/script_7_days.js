async function weather_week_icon_loader() {
    var today = new Date();
    var time = today.getHours();

    var request = await fetch("https://api.open-meteo.com/v1/forecast?latitude=59.9138&longitude=10.7387&hourly=temperature_2m,apparent_temperature,rain,cloudcover,windspeed_10m,windgusts_10m&daily=weathercode,temperature_2m_max,temperature_2m_min,rain_sum,windspeed_10m_max,windgusts_10m_max,winddirection_10m_dominant&timezone=Europe%2FBerlin")
    var answer = await request.json()



    // DAY 1

    const average_rain_avg = answer.hourly.rain.slice(0, 24);
    const average_rain_value_avg = average_rain_avg.reduce((a, b) => a + b, 0) / average_rain_avg.length;

    const average_cloud_avg = answer.hourly.cloudcover.slice(0, 24);
    const average_cloud_value_avg = average_cloud_avg.reduce((a, b) => a + b, 0) / average_cloud_avg.length;

    //clouds
    if (average_cloud_value_avg >= 0 && average_cloud_value_avg <= 20 && average_rain_value_avg < 0.06) {
        img_sun_avg();
    }
    if (average_cloud_value_avg >= 21 && average_cloud_value_avg <= 60 && average_rain_value_avg < 0.06) {
        img_slight_cover_avg();
    }
    if (average_cloud_value_avg >= 61 && average_cloud_value_avg <= 100 && average_rain_value_avg < 0.06) {
        img_full_cover_avg();
    }

    //rain
    if (average_cloud_value_avg >= 0 && average_cloud_value_avg <= 10 && average_rain_value_avg > 0.06) {
        img_rain_avg();
    }
    if (average_cloud_value_avg >= 11 && average_cloud_value_avg <= 100 && average_rain_value_avg > 0.06) {
        img_rain_with_clouds_avg();
    }
}


//cover

function img_sun_avg() {
    var img = document.createElement('img');
    img.src = 'img/mini/sun.gif';

    document.getElementById('weather_avg_day1').appendChild(img);
}

function img_slight_cover_avg() {
    var img = document.createElement('img');
    img.src = 'img/mini/cloudy.gif';

    document.getElementById('weather_avg_day1').appendChild(img);
}

function img_full_cover_avg() {
    var img = document.createElement('img');
    img.src = 'img/mini/clouds.gif';
    document.getElementById('weather_avg_day1').appendChild(img);
}


// IF RAIN
function img_rain_avg() {
    var img = document.createElement('img');
    img.src = 'img/mini/drop.gif';
    document.getElementById('weather_avg_day1').appendChild(img);
}

function img_rain_with_clouds_avg() {
    var img = document.createElement('img');
    img.src = 'img/mini/rain.gif';
    document.getElementById('weather_avg_day1').appendChild(img);
}


async function weather_week_icon_loader_day2() {

    var request = await fetch("https://api.open-meteo.com/v1/forecast?latitude=59.9138&longitude=10.7387&hourly=temperature_2m,apparent_temperature,rain,cloudcover,windspeed_10m,windgusts_10m&daily=weathercode,temperature_2m_max,temperature_2m_min,rain_sum,windspeed_10m_max,windgusts_10m_max,winddirection_10m_dominant&timezone=Europe%2FBerlin")
    var answer = await request.json()


    // day 2

    const average_rain_avg_day2 = answer.hourly.rain.slice(24, 48);
    const average_rain_value_avg_day2 = average_rain_avg_day2.reduce((a, b) => a + b, 0) / average_rain_avg_day2.length;

    const average_cloud_avg_day2 = answer.hourly.cloudcover.slice(24, 48);
    const average_cloud_value_avg_day2 = average_cloud_avg_day2.reduce((a, b) => a + b, 0) / average_cloud_avg_day2.length;

    //clouds
    if (average_cloud_value_avg_day2 >= 0 && average_cloud_value_avg_day2 <= 20 && average_rain_value_avg_day2 < 0.06) {
        img_sun_avg_day2();
    }
    if (average_cloud_value_avg_day2 >= 21 && average_cloud_value_avg_day2 <= 60 && average_rain_value_avg_day2 < 0.06) {
        img_slight_cover_avg_day2();
    }
    if (average_cloud_value_avg_day2 >= 61 && average_cloud_value_avg_day2 <= 100 && average_rain_value_avg_day2 < 0.06) {
        img_full_cover_avg_day2();
    }

    //rain
    if (average_cloud_value_avg_day2 >= 0 && average_cloud_value_avg_day2 <= 10 && average_rain_value_avg_day2 > 0.06) {
        img_rain_avg_day2();
    }
    if (average_cloud_value_avg_day2 >= 11 && average_cloud_value_avg_day2 <= 100 && average_rain_value_avg_day2 > 0.06) {
        img_rain_with_clouds_avg_day2();
    }
}


//cover

function img_sun_avg_day2() {
    var img = document.createElement('img');
    img.src = 'img/mini/sun.gif';

    document.getElementById('weather_avg_day2').appendChild(img);
}

function img_slight_cover_avg_day2() {
    var img = document.createElement('img');
    img.src = 'img/mini/cloudy.gif';

    document.getElementById('weather_avg_day2').appendChild(img);
}

function img_full_cover_avg_day2() {
    var img = document.createElement('img');
    img.src = 'img/mini/clouds.gif';
    document.getElementById('weather_avg_day2').appendChild(img);
}


// IF RAIN
function img_rain_avg_day2() {
    var img = document.createElement('img');
    img.src = 'img/mini/drop.gif';
    document.getElementById('weather_avg_day2').appendChild(img);
}

function img_rain_with_clouds_avg_day2() {
    var img = document.createElement('img');
    img.src = 'img/mini/rain.gif';
    document.getElementById('weather_avg_day2').appendChild(img);
}


//day 3

async function weather_week_icon_loader_day3() {

    var request = await fetch("https://api.open-meteo.com/v1/forecast?latitude=59.9138&longitude=10.7387&hourly=temperature_2m,apparent_temperature,rain,cloudcover,windspeed_10m,windgusts_10m&daily=weathercode,temperature_2m_max,temperature_2m_min,rain_sum,windspeed_10m_max,windgusts_10m_max,winddirection_10m_dominant&timezone=Europe%2FBerlin")
    var answer = await request.json()


    // day 2

    const average_rain_avg_day3 = answer.hourly.rain.slice(48, 72);
    const average_rain_value_avg_day3 = average_rain_avg_day3.reduce((a, b) => a + b, 0) / average_rain_avg_day3.length;

    const average_cloud_avg_day3 = answer.hourly.cloudcover.slice(48, 72);
    const average_cloud_value_avg_day3 = average_cloud_avg_day3.reduce((a, b) => a + b, 0) / average_cloud_avg_day3.length;

    //clouds
    if (average_cloud_value_avg_day3 >= 0 && average_cloud_value_avg_day3 <= 20 && average_rain_value_avg_day3 < 0.06) {
        img_sun_avg_day3();
    }
    if (average_cloud_value_avg_day3 >= 21 && average_cloud_value_avg_day3 <= 60 && average_rain_value_avg_day3 < 0.06) {
        img_slight_cover_avg_day3();
    }
    if (average_cloud_value_avg_day3 >= 61 && average_cloud_value_avg_day3 <= 100 && average_rain_value_avg_day3 < 0.06) {
        img_full_cover_avg_day3();
    }

    //rain
    if (average_cloud_value_avg_day3 >= 0 && average_cloud_value_avg_day3 <= 10 && average_rain_value_avg_day3 > 0.06) {
        img_rain_avg_day3();
    }
    if (average_cloud_value_avg_day3 >= 11 && average_cloud_value_avg_day3 <= 100 && average_rain_value_avg_day3 > 0.06) {
        img_rain_with_clouds_avg_day3();
    }
}


//cover

function img_sun_avg_day3() {
    var img = document.createElement('img');
    img.src = 'img/mini/sun.gif';

    document.getElementById('weather_avg_day3').appendChild(img);
}

function img_slight_cover_avg_day3() {
    var img = document.createElement('img');
    img.src = 'img/mini/cloudy.gif';

    document.getElementById('weather_avg_day3').appendChild(img);
}

function img_full_cover_avg_day3() {
    var img = document.createElement('img');
    img.src = 'img/mini/clouds.gif';
    document.getElementById('weather_avg_day3').appendChild(img);
}


// IF RAIN
function img_rain_avg_day3() {
    var img = document.createElement('img');
    img.src = 'img/mini/drop.gif';
    document.getElementById('weather_avg_day3').appendChild(img);
}

function img_rain_with_clouds_avg_day3() {
    var img = document.createElement('img');
    img.src = 'img/mini/rain.gif';
    document.getElementById('weather_avg_day3').appendChild(img);
}



// day 4

async function weather_week_icon_loader_day4() {

    var request = await fetch("https://api.open-meteo.com/v1/forecast?latitude=59.9138&longitude=10.7387&hourly=temperature_2m,apparent_temperature,rain,cloudcover,windspeed_10m,windgusts_10m&daily=weathercode,temperature_2m_max,temperature_2m_min,rain_sum,windspeed_10m_max,windgusts_10m_max,winddirection_10m_dominant&timezone=Europe%2FBerlin")
    var answer = await request.json()


    // day 2

    const average_rain_avg_day4 = answer.hourly.rain.slice(72, 96);
    const average_rain_value_avg_day4 = average_rain_avg_day4.reduce((a, b) => a + b, 0) / average_rain_avg_day4.length;

    const average_cloud_avg_day4 = answer.hourly.cloudcover.slice(72, 96);
    const average_cloud_value_avg_day4 = average_cloud_avg_day4.reduce((a, b) => a + b, 0) / average_cloud_avg_day4.length;

    //clouds
    if (average_cloud_value_avg_day4 >= 0 && average_cloud_value_avg_day4 <= 20 && average_rain_value_avg_day4 < 0.06) {
        img_sun_avg_day4();
    }
    if (average_cloud_value_avg_day4 >= 21 && average_cloud_value_avg_day4 <= 60 && average_rain_value_avg_day4 < 0.06) {
        img_slight_cover_avg_day4();
    }
    if (average_cloud_value_avg_day4 >= 61 && average_cloud_value_avg_day4 <= 100 && average_rain_value_avg_day4 < 0.06) {
        img_full_cover_avg_day4();
    }

    //rain
    if (average_cloud_value_avg_day4 >= 0 && average_cloud_value_avg_day4 <= 10 && average_rain_value_avg_day4 > 0.06) {
        img_rain_avg_day4();
    }
    if (average_cloud_value_avg_day4 >= 11 && average_cloud_value_avg_day4 <= 100 && average_rain_value_avg_day4 > 0.06) {
        img_rain_with_clouds_avg_day4();
    }
}


//cover

function img_sun_avg_day4() {
    var img = document.createElement('img');
    img.src = 'img/mini/sun.gif';

    document.getElementById('weather_avg_day4').appendChild(img);
}

function img_slight_cover_avg_day4() {
    var img = document.createElement('img');
    img.src = 'img/mini/cloudy.gif';

    document.getElementById('weather_avg_day4').appendChild(img);
}

function img_full_cover_avg_day4() {
    var img = document.createElement('img');
    img.src = 'img/mini/clouds.gif';
    document.getElementById('weather_avg_day4').appendChild(img);
}


// IF RAIN
function img_rain_avg_day4() {
    var img = document.createElement('img');
    img.src = 'img/mini/drop.gif';
    document.getElementById('weather_avg_day4').appendChild(img);
}

function img_rain_with_clouds_avg_day4() {
    var img = document.createElement('img');
    img.src = 'img/mini/rain.gif';
    document.getElementById('weather_avg_day4').appendChild(img);
}


// day 5

async function weather_week_icon_loader_day5() {

    var request = await fetch("https://api.open-meteo.com/v1/forecast?latitude=59.9138&longitude=10.7387&hourly=temperature_2m,apparent_temperature,rain,cloudcover,windspeed_10m,windgusts_10m&daily=weathercode,temperature_2m_max,temperature_2m_min,rain_sum,windspeed_10m_max,windgusts_10m_max,winddirection_10m_dominant&timezone=Europe%2FBerlin")
    var answer = await request.json()


    // day 2

    const average_rain_avg_day5 = answer.hourly.rain.slice(96, 120);
    const average_rain_value_avg_day5 = average_rain_avg_day5.reduce((a, b) => a + b, 0) / average_rain_avg_day5.length;

    const average_cloud_avg_day5 = answer.hourly.cloudcover.slice(96, 120);
    const average_cloud_value_avg_day5 = average_cloud_avg_day5.reduce((a, b) => a + b, 0) / average_cloud_avg_day5.length;

    //clouds
    if (average_cloud_value_avg_day5 >= 0 && average_cloud_value_avg_day5 <= 20 && average_rain_value_avg_day5 < 0.06) {
        img_sun_avg_day5();
    }
    if (average_cloud_value_avg_day5 >= 21 && average_cloud_value_avg_day5 <= 60 && average_rain_value_avg_day5 < 0.06) {
        img_slight_cover_avg_day5();
    }
    if (average_cloud_value_avg_day5 >= 61 && average_cloud_value_avg_day5 <= 100 && average_rain_value_avg_day5 < 0.06) {
        img_full_cover_avg_day5();
    }

    //rain
    if (average_cloud_value_avg_day5 >= 0 && average_cloud_value_avg_day5 <= 10 && average_rain_value_avg_day5 > 0.06) {
        img_rain_avg_day5();
    }
    if (average_cloud_value_avg_day5 >= 11 && average_cloud_value_avg_day5 <= 100 && average_rain_value_avg_day5 > 0.06) {
        img_rain_with_clouds_avg_day5();
    }
}


//cover

function img_sun_avg_day5() {
    var img = document.createElement('img');
    img.src = 'img/mini/sun.gif';

    document.getElementById('weather_avg_day5').appendChild(img);
}

function img_slight_cover_avg_day5() {
    var img = document.createElement('img');
    img.src = 'img/mini/cloudy.gif';

    document.getElementById('weather_avg_day5').appendChild(img);
}

function img_full_cover_avg_day5() {
    var img = document.createElement('img');
    img.src = 'img/mini/clouds.gif';
    document.getElementById('weather_avg_day5').appendChild(img);
}


// IF RAIN
function img_rain_avg_day5() {
    var img = document.createElement('img');
    img.src = 'img/mini/drop.gif';
    document.getElementById('weather_avg_day5').appendChild(img);
}

function img_rain_with_clouds_avg_day5() {
    var img = document.createElement('img');
    img.src = 'img/mini/rain.gif';
    document.getElementById('weather_avg_day5').appendChild(img);
}

// day 6

async function weather_week_icon_loader_day6() {

    var request = await fetch("https://api.open-meteo.com/v1/forecast?latitude=59.9138&longitude=10.7387&hourly=temperature_2m,apparent_temperature,rain,cloudcover,windspeed_10m,windgusts_10m&daily=weathercode,temperature_2m_max,temperature_2m_min,rain_sum,windspeed_10m_max,windgusts_10m_max,winddirection_10m_dominant&timezone=Europe%2FBerlin")
    var answer = await request.json()


    // day 2

    const average_rain_avg_day6 = answer.hourly.rain.slice(120, 144);
    const average_rain_value_avg_day6 = average_rain_avg_day6.reduce((a, b) => a + b, 0) / average_rain_avg_day6.length;

    const average_cloud_avg_day6 = answer.hourly.cloudcover.slice(120, 144);
    const average_cloud_value_avg_day6 = average_cloud_avg_day6.reduce((a, b) => a + b, 0) / average_cloud_avg_day6.length;

    //clouds
    if (average_cloud_value_avg_day6 >= 0 && average_cloud_value_avg_day6 <= 20 && average_rain_value_avg_day6 < 0.06) {
        img_sun_avg_day6();
    }
    if (average_cloud_value_avg_day6 >= 21 && average_cloud_value_avg_day6 <= 60 && average_rain_value_avg_day6 < 0.06) {
        img_slight_cover_avg_day6();
    }
    if (average_cloud_value_avg_day6 >= 61 && average_cloud_value_avg_day6 <= 100 && average_rain_value_avg_day6 < 0.06) {
        img_full_cover_avg_day6();
    }

    //rain
    if (average_cloud_value_avg_day6 >= 0 && average_cloud_value_avg_day6 <= 10 && average_rain_value_avg_day6 > 0.06) {
        img_rain_avg_day6();
    }
    if (average_cloud_value_avg_day6 >= 11 && average_cloud_value_avg_day6 <= 100 && average_rain_value_avg_day6 > 0.06) {
        img_rain_with_clouds_avg_day6();
    }
}


//cover

function img_sun_avg_day6() {
    var img = document.createElement('img');
    img.src = 'img/mini/sun.gif';

    document.getElementById('weather_avg_day6').appendChild(img);
}

function img_slight_cover_avg_day6() {
    var img = document.createElement('img');
    img.src = 'img/mini/cloudy.gif';

    document.getElementById('weather_avg_day6').appendChild(img);
}

function img_full_cover_avg_day6() {
    var img = document.createElement('img');
    img.src = 'img/mini/clouds.gif';
    document.getElementById('weather_avg_day6').appendChild(img);
}


// IF RAIN
function img_rain_avg_day6() {
    var img = document.createElement('img');
    img.src = 'img/mini/drop.gif';
    document.getElementById('weather_avg_day6').appendChild(img);
}

function img_rain_with_clouds_avg_day6() {
    var img = document.createElement('img');
    img.src = 'img/mini/rain.gif';
    document.getElementById('weather_avg_day6').appendChild(img);
}


// day 7

async function weather_week_icon_loader_day7() {

    var request = await fetch("https://api.open-meteo.com/v1/forecast?latitude=59.9138&longitude=10.7387&hourly=temperature_2m,apparent_temperature,rain,cloudcover,windspeed_10m,windgusts_10m&daily=weathercode,temperature_2m_max,temperature_2m_min,rain_sum,windspeed_10m_max,windgusts_10m_max,winddirection_10m_dominant&timezone=Europe%2FBerlin")
    var answer = await request.json()


    // day 2

    const average_rain_avg_day7 = answer.hourly.rain.slice(144, 168);
    const average_rain_value_avg_day7 = average_rain_avg_day7.reduce((a, b) => a + b, 0) / average_rain_avg_day7.length;

    const average_cloud_avg_day7 = answer.hourly.cloudcover.slice(144, 168);
    const average_cloud_value_avg_day7 = average_cloud_avg_day7.reduce((a, b) => a + b, 0) / average_cloud_avg_day7.length;

    //clouds
    if (average_cloud_value_avg_day7 >= 0 && average_cloud_value_avg_day7 <= 20 && average_rain_value_avg_day7 < 0.06) {
        img_sun_avg_day7();
    }
    if (average_cloud_value_avg_day7 >= 21 && average_cloud_value_avg_day7 <= 60 && average_rain_value_avg_day7 < 0.06) {
        img_slight_cover_avg_day7();
    }
    if (average_cloud_value_avg_day7 >= 61 && average_cloud_value_avg_day7 <= 100 && average_rain_value_avg_day7 < 0.06) {
        img_full_cover_avg_day7();
    }

    //rain
    if (average_cloud_value_avg_day7 >= 0 && average_cloud_value_avg_day7 <= 10 && average_rain_value_avg_day7 > 0.06) {
        img_rain_avg_day7();
    }
    if (average_cloud_value_avg_day7 >= 11 && average_cloud_value_avg_day7 <= 100 && average_rain_value_avg_day7 > 0.06) {
        img_rain_with_clouds_avg_day7();
    }
}


//cover

function img_sun_avg_day7() {
    var img = document.createElement('img');
    img.src = 'img/mini/sun.gif';

    document.getElementById('weather_avg_day7').appendChild(img);
}

function img_slight_cover_avg_day7() {
    var img = document.createElement('img');
    img.src = 'img/mini/cloudy.gif';

    document.getElementById('weather_avg_day7').appendChild(img);
}

function img_full_cover_avg_day7() {
    var img = document.createElement('img');
    img.src = 'img/mini/clouds.gif';
    document.getElementById('weather_avg_day7').appendChild(img);
}


// IF RAIN
function img_rain_avg_day7() {
    var img = document.createElement('img');
    img.src = 'img/mini/drop.gif';
    document.getElementById('weather_avg_day7').appendChild(img);
}

function img_rain_with_clouds_avg_day7() {
    var img = document.createElement('img');
    img.src = 'img/mini/rain.gif';
    document.getElementById('weather_avg_day7').appendChild(img);
}




async function weather_week() {
    var request = await fetch("https://api.open-meteo.com/v1/forecast?latitude=59.9138&longitude=10.7387&hourly=temperature_2m,apparent_temperature,rain,cloudcover,windspeed_10m,windgusts_10m&daily=weathercode,temperature_2m_max,temperature_2m_min,rain_sum,windspeed_10m_max,windgusts_10m_max,winddirection_10m_dominant&timezone=Europe%2FBerlin")
    var requested = await request.json()
    var answer = requested

    for (let i = 1; i <= 7; i++) {

        document.getElementById("weather_week" + i + "_temperature_max").innerHTML = answer.daily.temperature_2m_max[i - 1] + "°";
        document.getElementById("weather_week" + i + "_temperature_min").innerHTML = answer.daily.temperature_2m_min[i - 1] + "°";

        document.getElementById("weather_week" + i + "_rain").innerHTML = answer.daily.rain_sum[i - 1] + "mm";

        document.getElementById("weather_week" + i + "_wind_speed").innerHTML = answer.daily.windspeed_10m_max[i - 1] + "km/h";
        document.getElementById("weather_week" + i + "_wind_gust").innerHTML = answer.daily.windgusts_10m_max[i - 1] + "km/h";
    }



    const d = new Date("January 01, 1970 00:00:00");
    let day = d.getDay()

    var day1 = (day + 0)
    console.log(day1)
    var day2 = (day + 1)
    console.log(day2)
    var day3 = (day + 2)
    console.log(day3)
    var day4 = (day + 3)
    console.log(day4)
    var day5 = (day + 4)
    console.log(day5)
    var day6 = (day + 5)
    console.log(day6)
    var day7 = (day + 6)
    console.log(day7)


    if (day1 == 0) {
        var day1 = "Thursday"
    }
    if (day1 == 1) {
        var day1 = "Friday"
    }
    if (day1 == 2) {
        var day1 = "Saturday"
    }
    if (day1 == 3) {
        var day1 = "Sunday"
    }
    if (day1 == 4) {
        var day1 = "Monday"
    }
    if (day1 == 5) {
        var day1 = "Tuesday"
    }
    if (day1 == 6) {
        var day1 = "Wednesday"
    }
    if (day1 == 7) {
        var day1 = "Thursday"
    }
    if (day1 == 8) {
        var day1 = "Friday"
    }
    if (day1 == 9) {
        var day1 = "Saturday"
    }
    if (day1 == 10) {
        var day1 = "Sunday"
    }
    if (day1 == 11) {
        var day1 = "Monday"
    }
    if (day1 == 12) {
        var day1 = "Tuesday"
    }
    if (day1 == 13) {
        var day1 = "Wednesday"
    }




    if (day2 == 0) {
        var day2 = "Thursday"
    }
    if (day2 == 1) {
        var day2 = "Friday"
    }
    if (day2 == 2) {
        var day2 = "Saturday"
    }
    if (day2 == 3) {
        var day2 = "Sunday"
    }
    if (day2 == 4) {
        var day2 = "Monday"
    }
    if (day2 == 5) {
        var day2 = "Tuesday"
    }
    if (day2 == 6) {
        var day2 = "Wednesday"
    }
    if (day2 == 7) {
        var day2 = "Thursday"
    }
    if (day2 == 8) {
        var day2 = "Friday"
    }
    if (day2 == 9) {
        var day2 = "Saturday"
    }
    if (day2 == 10) {
        var day2 = "Sunday"
    }
    if (day2 == 11) {
        var day2 = "Monday"
    }
    if (day2 == 12) {
        var day2 = "Tuesday"
    }
    if (day2 == 13) {
        var day2 = "Wednesday"
    }




    if (day3 == 0) {
        var day3 = "Thursday"
    }
    if (day3 == 1) {
        var day3 = "Friday"
    }
    if (day3 == 2) {
        var day3 = "Saturday"
    }
    if (day3 == 3) {
        var day3 = "Sunday"
    }
    if (day3 == 4) {
        var day3 = "Monday"
    }
    if (day3 == 5) {
        var day3 = "Tuesday"
    }
    if (day3 == 6) {
        var day3 = "Wednesday"
    }
    if (day3 == 7) {
        var day3 = "Thursday"
    }
    if (day3 == 8) {
        var day3 = "Friday"
    }
    if (day3 == 9) {
        var day3 = "Saturday"
    }
    if (day3 == 10) {
        var day3 = "Sunday"
    }
    if (day3 == 11) {
        var day3 = "Monday"
    }
    if (day3 == 12) {
        var day3 = "Tuesday"
    }
    if (day3 == 13) {
        var day3 = "Wednesday"
    }




    if (day4 == 0) {
        var day4 = "Thursday"
    }
    if (day4 == 1) {
        var day4 = "Friday"
    }
    if (day4 == 2) {
        var day4 = "Saturday"
    }
    if (day4 == 3) {
        var day4 = "Sunday"
    }
    if (day4 == 4) {
        var day4 = "Monday"
    }
    if (day4 == 5) {
        var day4 = "Tuesday"
    }
    if (day4 == 6) {
        var day4 = "Wednesday"
    }
    if (day4 == 7) {
        var day4 = "Thursday"
    }
    if (day4 == 8) {
        var day4 = "Friday"
    }
    if (day4 == 9) {
        var day4 = "Saturday"
    }
    if (day4 == 10) {
        var day4 = "Sunday"
    }
    if (day4 == 11) {
        var day4 = "Monday"
    }
    if (day4 == 12) {
        var day4 = "Tuesday"
    }
    if (day4 == 13) {
        var day4 = "Wednesday"
    }




    if (day5 == 0) {
        var day5 = "Thursday"
    }
    if (day5 == 1) {
        var day5 = "Friday"
    }
    if (day5 == 2) {
        var day5 = "Saturday"
    }
    if (day5 == 3) {
        var day5 = "Sunday"
    }
    if (day5 == 4) {
        var day5 = "Monday"
    }
    if (day5 == 5) {
        var day5 = "Tuesday"
    }
    if (day5 == 6) {
        var day5 = "Wednesday"
    }
    if (day5 == 7) {
        var day5 = "Thursday"
    }
    if (day5 == 8) {
        var day5 = "Friday"
    }
    if (day5 == 9) {
        var day5 = "Saturday"
    }
    if (day5 == 10) {
        var day5 = "Sunday"
    }
    if (day5 == 11) {
        var day5 = "Monday"
    }
    if (day5 == 12) {
        var day5 = "Tuesday"
    }
    if (day5 == 13) {
        var day5 = "Wednesday"
    }




    if (day6 == 0) {
        var day6 = "Thursday"
    }
    if (day6 == 1) {
        var day6 = "Friday"
    }
    if (day6 == 2) {
        var day6 = "Saturday"
    }
    if (day6 == 3) {
        var day6 = "Sunday"
    }
    if (day6 == 4) {
        var day6 = "Monday"
    }
    if (day6 == 5) {
        var day6 = "Tuesday"
    }
    if (day6 == 6) {
        var day6 = "Wednesday"
    }
    if (day6 == 7) {
        var day6 = "Thursday"
    }
    if (day6 == 8) {
        var day6 = "Friday"
    }
    if (day6 == 9) {
        var day6 = "Saturday"
    }
    if (day6 == 10) {
        var day6 = "Sunday"
    }
    if (day6 == 11) {
        var day6 = "Monday"
    }
    if (day6 == 12) {
        var day6 = "Tuesday"
    }
    if (day6 == 13) {
        var day6 = "Wednesday"
    }




    if (day7 == 0) {
        var day7 = "Thursday"
    }
    if (day7 == 1) {
        var day7 = "Friday"
    }
    if (day7 == 2) {
        var day7 = "Saturday"
    }
    if (day7 == 3) {
        var day7 = "Sunday"
    }
    if (day7 == 4) {
        var day7 = "Monday"
    }
    if (day7 == 5) {
        var day7 = "Tuesday"
    }
    if (day7 == 6) {
        var day7 = "Wednesday"
    }
    if (day7 == 7) {
        var day7 = "Thursday"
    }
    if (day7 == 8) {
        var day7 = "Friday"
    }
    if (day7 == 9) {
        var day7 = "Saturday"
    }
    if (day7 == 10) {
        var day7 = "Sunday"
    }
    if (day7 == 11) {
        var day7 = "Monday"
    }
    if (day7 == 12) {
        var day7 = "Tuesday"
    }
    if (day7 == 13) {
        var day7 = "Wednesday"
    }



    document.getElementById("day1").innerHTML = day1;
    document.getElementById("day2").innerHTML = day2;
    document.getElementById("day3").innerHTML = day3;
    document.getElementById("day4").innerHTML = day4;
    document.getElementById("day5").innerHTML = day5;
    document.getElementById("day6").innerHTML = day6;
    document.getElementById("day7").innerHTML = day7;


}