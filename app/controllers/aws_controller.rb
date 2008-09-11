class AwsController < ApplicationController
  include REXML
  
  def index
    url = 'http://webservices.amazon.fr/onca/xml?Service=AWSECommerceService&AWSAccessKeyId=040H7Z51K985VK9ETY02&Operation=ItemSearch&Keywords=cuisine%20menus&SearchIndex=Books&ResponseGroup=Medium'
    #url = 'http://webservices.amazon.fr/onca/xml?Service=AWSECommerceService&AWSAccessKeyId=040H7Z51K985VK9ETY02&Operation=ItemSearch&Keywords=cuisine%20menus&SearchIndex=Books'
    
    xml_data = Net::HTTP.get_response(URI.parse(url)).body
    @doc = Document.new(xml_data)
    
 
   
    render :partial => 'list'
  end
  
  def index2
   render :partial => 'carroussel'
  end
  
end
