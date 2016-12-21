class CoursetableController < ApplicationController
  def index
      @tables = [[],[]];
      for i in 0..11
          for j in 0..6
              @tables[i][j] = 1
          end
      end
      

      
  end
end
