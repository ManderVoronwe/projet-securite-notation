//get data from the server 
function getData() {
    //get the data from the server
    $.getJSON('../data/data.json', function(data) {
        //update the data on the page
        updateData(data);
    });
}

//update the data on the page
function updateData(data) {
    //update the data on the page
    $('#data').html(data);
}

//update the data every 1 minute
setInterval(getData, 60000);

//src="https://cdn.jsdelivr.net/npm/chart.js"

//get the canvas
var canvas = document.getElementById('point-diagram');

//create the chart
var chart = new Chart(canvas, {
    type: 'line',   
    data: {
        labels: [],
        datasets: [{
            label: 'points',
            data: [],
            backgroundColor: 'rgba(255, 99, 132, 0.2)',
            borderColor: 'rgba(255, 99, 132, 1)',
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }]
        }
    }
});



