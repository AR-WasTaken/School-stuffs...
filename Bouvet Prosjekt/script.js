async function getPowerprice() {
    var request = await fetch("https://innafjord.azurewebsites.net/api/PowerPrice/all")
    var answer = await request.json()
    return answer
}

async function plotPowerprice() {
    var allPowerPrices = await getPowerprice()
    var xVerdier = []
    var yVerdier = []
    for (let i = allPowerPrices.length - 800; i < allPowerPrices.length; i = i + 1) {
        yVerdier.push(allPowerPrices[i])
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
            title: "Time/indekser"
        },
        yaxis: {
            range: [Math.min(yVerdier) - 1, Math.max(yVerdier) + 1],
            title: "Powerprice/NOK"
        },
        title: "Powerprice",
        plot_bgcolor: "#fff",

        paper_bgcolor: "#00b4d8;",
        colorway: ["#0077be"]
    }

    Plotly.newPlot("powerprice-history", data, oppsett)
}

setInterval(plotPowerprice, 1000)


async function getWaterinflux() {
    var request = await fetch("https://innafjord.azurewebsites.net/api/WaterInflux/all")
    var answer = await request.json()
    return answer
}

async function plotWaterinflux() {
    var allWaterinflux = await getWaterinflux()
    var xVerdier = []
    var yVerdier = []
    for (let i = allWaterinflux.length - 800; i < allWaterinflux.length; i = i + 1) {
        yVerdier.push(allWaterinflux[i])
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
            title: "Time/indekser"
        },
        yaxis: {
            range: [Math.min(yVerdier) - 1, Math.max(yVerdier) + 1],
            title: "Waterinflux"
        },
        title: "Waterinflux",
        plot_bgcolor: "#fff",
        paper_bgcolor: "#00b4d8;",
        colorway: ["#0077be"]
    }

    Plotly.newPlot("Waterinflux-history", data, oppsett)
}

setInterval(plotWaterinflux, 1000)