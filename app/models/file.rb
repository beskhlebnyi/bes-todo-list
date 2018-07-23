class Document < ApplicationRecord
  belongs_to :list
  has_one_attached :file
end

##NOTE
## get the timezone offset in hours:
## Document.last.deadline.strftime('%z')[0..2].to_i 