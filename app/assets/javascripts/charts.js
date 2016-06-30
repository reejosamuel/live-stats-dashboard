$(function () {
    $(document).ready(function () {
        Highcharts.setOptions({
            global: {
                useUTC: false
            }
        });

        var saleChart = $('#container').highcharts({
            colors: ["#30d30c", "#55BF3B", "#DF5353", "#7798BF", "#aaeeee", "#ff0066", "#eeaaee",
                "#55BF3B", "#DF5353", "#7798BF", "#aaeeee"
            ],
            chart: {
                type: 'spline',
                animation: Highcharts.svg, // don't animate in old IE
                marginRight: 10,
                events: {
                    load: function () {

                        // set up the updating of the chart each second
                        // var series = this.series[0];
                        // var xxdata = Highcharts.charts[0].series[0]
                        // setInterval(function () {
                        //     var x = (new Date()).getTime(), // current time
                        //         y = Math.random() * 100;
                        //     xxdata.addPoint([x, y], true, true);
                        // }, 1000);
                    }
                },
                backgroundColor: {
                    linearGradient: [0, 0, 250, 500],
                    stops: [
                        [0, 'rgb(16, 18, 20)'],
                        [1, 'rgb(16, 18, 20)']
                    ]
                },
            },
            title: {
                style: {
                    color: '#C0C0C0',
                },
                text: 'Sale Transaction'
            },
            xAxis: {
                type: 'datetime',
                tickPixelInterval: 150
            },
            yAxis: {
                title: {
                    text: 'Value'
                },
                gridLineColor: '#333333',
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#000'
                }]
            },

            legend: {
                enabled: false
            },
            exporting: {
                enabled: false
            },
            series: [{
                name: 'Sale data',
                data: (function () {
                    // generate an array of random data
                    var data = [],
                        time = (new Date()).getTime(),
                        i;

                    for (i = -19; i <= 0; i += 1) {
                        data.push({
                            x: time + i * 1000,
                            y: 0,
                        });
                    }
                    return data;
                }())
            }]
        });
    });
});