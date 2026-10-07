class ColorsController < ApplicationController
  def index
    @colors =  {
      "dark-blue" => "#091C44",
      "alt-dark-blue" => "#212529",
      "base-blue" => "#082B73",
      "mid-blue" => "#004990",
      "bright-blue" => "#336BE6",
      "alt-bright-blue" => "#5387F7",
      "light-blue" => "#D0DEFD",
      "eagle-blue" => "#0C2340",
      "emory-blue" => "#002F6C",
      "candler-lake" => "#007DBA",
      "waterhub-blue" => "#0033A0",
      "emory-blue-10" => "#E4E7EF",
      "waterhub-blue-10" => "#E7E7F5"
    }
  end
end