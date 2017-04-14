class Education < ActiveRecord::Base

  enum school_type: [:day, :night]

end