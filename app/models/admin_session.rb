# A signed-in browser. Destroying the row logs that browser out.
class AdminSession < ApplicationRecord
  belongs_to :admin
end
