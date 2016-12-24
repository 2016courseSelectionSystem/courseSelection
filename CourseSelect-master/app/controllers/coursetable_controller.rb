class CoursetableController < ApplicationController
  def index
      @tables = Array.new(12){Array.new(7,'0')}
      @course = current_user.courses  #获取学生课程
      @course.each_with_index do |wn_course , course_index|     #样例： 周五(5-6)&周三(5-6)
          course_times = wn_course.course_time.split('&') #将每个时间点切出
          course_times.each do |course_time|    #循环处理每个时间点
              course_time = course_time[0..-2] #去掉最后一个字符）
              time = course_time.split('(')
              weeknum = transformWeek(time[0])
              start_time = time[1].split('-')[0].to_i
              course_length = time[1].split('-')[1].to_i - start_time + 1 #计算课程长度
              @tables[start_time-1][weeknum] = course_index.to_s + "@" + course_length.to_s
          end
      end
  end
  
  #周次转数字
  def transformWeek(weekString)
      weeks = ['周一','周二','周三','周四','周五','周六','周日']
      weeks.each_with_index do |week , index|
          if week == weekString
              return index
          end
      end
  end
  
  
end
