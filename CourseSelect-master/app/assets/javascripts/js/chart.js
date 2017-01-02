$(document).ready(function () {

    var grade_course_id;
    var department_course_id;
    //设置成绩图表的课程id
    $(".grade_chart_btn").on('click', function () {
        grade_course_id = $(this).data('course');
    });
    //设置选课图标的课程id
    $(".department_chart_btn").on('click', function () {
        department_course_id = $(this).data('course');
    });

    //获取数据，加载图表
    $('#grade_chart').on("shown.bs.collapse", function () {
        if (grade_course_id != null) {
            //初始化饼图
            $.get("/grades/grade_chart_pie?course_id=" + grade_course_id, function (json) {
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
            $.get("/grades/grade_chart_bar?course_id=" + grade_course_id, function (json) {
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

    $('#department_chart').on('shown.bs.collapse', function () {
       if (department_course_id != null) {
           //初始化柱状图
           $.get("/grades/department_chart?course_id=" + department_course_id, function (json) {
               var option = {
                   title: {
                       text: "选课分布图"
                   },
                   tooltip: {
                       trigger: 'axis'
                   },
                   xAxis: {
                       name: '培养单位',
                       data: json.keys,
                       axisLabel: {
                           interval: 0,
                           rotate: 330
                       }
                   },
                   yAxis: {
                       name: '人数'
                   },
                   series: {
                       type: 'bar',
                       data: json.values
                   }
               };
               var department_bar = echarts.init($('#department_chart_bar').get(0));
               department_bar.setOption(option);
           });
       }
    });
});