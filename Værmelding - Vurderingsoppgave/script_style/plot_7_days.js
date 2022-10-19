// Temperature graf

async function getTemperature() {
    var request = await fetch("https://api.open-meteo.com/v1/forecast?latitude=59.9138&longitude=10.7387&hourly=temperature_2m,apparent_temperature,rain,cloudcover,windspeed_10m,windgusts_10m&daily=weathercode,temperature_2m_max,temperature_2m_min,rain_sum,windspeed_10m_max,windgusts_10m_max,winddirection_10m_dominant&timezone=Europe%2FBerlin")
    var requested = await request.json()
    var answer = requested.hourly.temperature_2m
    return answer
}
//temperature_2m

async function plotTemperature() {
    var allTemperature = await getTemperature()
    var xVerdier = []
    var yVerdier = []
    for (let i = allTemperature.length - 168; i < allTemperature.length; i = i + 1) {
        yVerdier.push(allTemperature[i])
    }
    for (i in yVerdier) {
        xVerdier.push(i)
    }

    data = [{
        x: xVerdier,
        y: yVerdier,
        mode: "lines"
    }]

    oppsett = {
        xaxis: {
            range: [Math.min(xVerdier) - 1, Math.max(xVerdier) + 1],
            title: "Time"
        },
        yaxis: {
            range: [Math.min(yVerdier) - 1, Math.max(yVerdier) + 1],
            title: "Temperature"
        },
        title: "Temerature in Celsius for the next week",
        plot_bgcolor: "#fff",
        paper_bgcolor: "#00b4d8;",
        colorway: ["#0077be"]
    }

    Plotly.newPlot("Temperature", data, oppsett)
}

setInterval(plotTemperature, 10000)