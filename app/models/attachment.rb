#  class Attachment < ActiveRecord::Base
#    attr_accessible :post_id, :url, :image, :description
#    has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
#    belongs_to :post
#    
#    before_post_process :image?  # skip post_process if not image file
#    def image?
#      !(image_content_type =~ /^image.*/).nil?
#    end  
#  end



class Attachment < ActiveRecord::Base
  config = File.exist?('../../config.yml') ? YAML.load(File.read('../../config.yml')) : nil
  key =  ENV['S3_KEY']
  access_key =  ENV['S3_SECRET']
  if config
   key =  config['access_key_id'] 
   access_key =  config['secret_access_key']
  end
  attr_accessible :post_id, :url, :image, :description
  has_attached_file :image,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :storage => :s3 ,
                    :bucket => 'cetco' ,
                    :s3_credentials => {
                      :access_key_id =>  key ,  # WATCHOUT for THE COMMA
                      :secret_access_key =>  access_key
                    }
  belongs_to :post
  
  before_post_process :image?  # skip post_process if not image file
  def image?
    !(image_content_type =~ /^image.*/).nil?
  end
  
end
