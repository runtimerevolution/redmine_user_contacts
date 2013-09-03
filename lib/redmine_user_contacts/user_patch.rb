require_dependency 'principal'
require_dependency 'user'

module RedmineUserContacts
  module Patches
    module UserPatch
      def self.included(base)
        base.class_eval do        

          scope :in_groups, lambda {|groups|
            group_ids = groups.map {|group| group.is_a?(Group) ? group.id : group.to_i}   
            where("#{User.table_name}.id IN (SELECT gu.user_id FROM #{table_name_prefix}groups_users#{table_name_suffix} gu WHERE gu.group_id in (?))", group_ids)
          }
          end        

        base.class_eval do
          unloadable
        end
      end
    end
  end
end

ActionDispatch::Callbacks.to_prepare do
  User.send(:include, RedmineUserContacts::Patches::UserPatch)
end
