class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper
    before_action :set_header_links_color

    def set_header_links_color
        if controller_name == "documents"
            if ["open","assistant","read"].include?(action_name)
                @header_links_color=['','color:#ffed7a;','','','']
            else
                 @header_links_color=['color:#ffed7a;','','','','']
            end
        elsif controller_name == "templates"
            if ["index","show"].include?(action_name)
                @header_links_color=['','','color:#ffed7a;','','']
            else
                 @header_links_color=['','','','color:#ffed7a;','']
            end
        else
            @header_links_color=['','','','','']
        end
    end
end
