$(document).ready(function () {

    var course_id = getParam('course_id');
    if (course_id != null) {
        //初始化饼图
        $.get("/grades/chart_pie?course_id=" + course_id, function (json) {
            var option = {
                title: {
                    text: "成绩分布图"
                },
                tooltip: {
                    trigger: 'item'
                },
                series: [
                    {
                        name: "成绩分布",
                        type: 'pie',
                        data: [
                            {value: json["60"], name: '0-60'},
                            {value: json['70'], name: '60-70'},
                            {value: json['80'], name: '70-80'},
                            {value: json['90'], name: '80-90'},
                            {value: json['100'], name: '90-100'}
                        ]
                    }
                ]
            };
            var chart_pie = echarts.init($('#grade_chart_pie').get(0));
            chart_pie.setOption(option);
        });

        //初始化柱状图
        $.get("/grades/chart_bar?course_id=" + course_id, function (json) {
            var option = {
                title: {
                    text: "成绩分布图"
                },
                tooltip: {
                    trigger: 'axis'
                },
                xAxis: {
                    name: '分数段',
                    data: ['0-10', '10-20', '20-30', '30-40', '40-50', '50-60', '60-70', '70-80', '80-90', '90-100'],
                    nameLocation: 'middle',
                    nameGap: 30
                }
                ,
                yAxis: {
                    name: '人数'
                },
                series: {
                    type: 'bar',
                    data: json
                }
            };
            var chart_bar = echarts.init($('#grade_chart_bar').get(0));
            chart_bar.setOption(option);
        });
    }

});

function getParam(key) {
    var reg = new RegExp(key + "=([^&]*)(&|$)", 'i');
    var r = location.search.substr(1).match(reg);
    if (r != null) {
        return unescape(r[1]);
    }else {
        return null;
    }
}