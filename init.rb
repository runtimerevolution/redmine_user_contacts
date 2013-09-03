require 'redmine'
require 'redmine_user_contacts/user_patch'

Redmine::Plugin.register :redmine_user_contacts do
  name        'Redmine User Contacts'
  author      'Runtime Revolution, Ricardo Trindade'
  description 'A plugin for Redmine that adds a contact directory feature based on user custom fields'
  url         'https://github.com/runtimerevolution/redmine_user_contacts'
  version     '1.0'

  requires_redmine :version_or_higher => '2.3.0'
  
  settings :default => {
    'anonymous_access' => "0",
    'groups_shown' => "",
    'custom_fields_shown' => "",    
    'show_avatar' => "1",
    'avatar_size' => 32,
  }, :partial => 'settings/settings'

  #Global permissions
  project_module :contact_directory do
    permission :view_contact_directory, {
      :directory => :index,
    }
  end
  
  menu :top_menu, :contact_directory, { :controller => 'directory', :action => 'index' }, 
       :caption => :contact_directory_title, 
    	 :if =>  Proc.new {
    	 	 User.current.allowed_to?({ :controller => 'directory', :action => 'index' }, nil, :global => true) ||
    	   Setting['plugin_redmine_user_contacts']['anonymous_access'].to_i == 1
    	 }
	
end
