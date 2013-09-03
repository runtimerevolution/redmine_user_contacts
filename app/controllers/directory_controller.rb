class DirectoryController < ApplicationController

  helper :sort
  include SortHelper
  helper :custom_fields
  include CustomFieldsHelper

  
  def index
    sort_init 'firstname'
    sort_update ['firstname', 'mail']

    @limit = per_page_option

    @custom_fields = custom_fields_to_show
    @show_avatar = should_show_avatar?
    @avatar_size = avatar_size
    @groups = groups_to_show

    scope = User.logged.active
    scope = scope.in_groups(@groups)
    
    scope = scope.like(params[:name]) if params[:name].present?
    scope = scope.in_group(params[:group_id]) if params[:group_id].present?

    @user_count = scope.count
    @user_pages = Paginator.new @user_count, @limit, params['page']
    @offset ||= @user_pages.offset
    @users =  scope.order(sort_clause).limit(@limit).offset(@offset).all

    respond_to do |format|
      format.html {
        render :layout => true
      }
    end
  end
  
  private
  
  # What groups should be shown in directory. Configured in plugin settings.
  # TODO can be reduced to a single query
  def groups_to_show
    begin
      group_names = plugin_setting('groups_shown').to_s
      group_names.split(',').map {|group_name|
        Group.named(group_name)
      }.flatten       
    rescue
      []
    end
  end
  
  # What custom fields should be shown in directory. Configured in plugin settings.
  # TODO can be reduced to a single query
  def custom_fields_to_show
    begin
      custom_field_names = plugin_setting('custom_fields_shown').to_s
      custom_field_names.split(',').map {|custom_field_name|
        UserCustomField.find_by_name(custom_field_name.strip)        
      }.flatten.compact
    rescue
      []
    end
  end
  
  def should_show_avatar?
    plugin_setting('show_avatar')
  end

  def avatar_size
    plugin_setting('avatar_size').to_i
  end
  
  def plugin_setting(setting_name)
    Setting['plugin_redmine_user_contacts'][setting_name]
  end
end
