#  forcing rails to look exactly where the file lives relative to this helper
require_relative '../../lib/cepar_feed/view_helper'

module ApplicationHelper
  include CeparFeed::ViewHelper
end
