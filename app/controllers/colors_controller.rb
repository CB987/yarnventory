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
      "emory-blue" => "#002F6C",
      "waterhub-blue" => "#0033A0",
      "eagle-blue" => "#0C2340",
      "candler-lake" => "#007DBA",
      "emory-blue-10" => "#E4E7EF",
      "waterhub-blue-10" => "#E7E7F5"
    }
  end
end