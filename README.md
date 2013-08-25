# Redmine Contact Directory

[![Build Status](https://travis-ci.org/runtimerevolution/survey.png?branch=master)](https://travis-ci.org/runtimerevolution/survey)
[![Code Climate](https://codeclimate.com/github/runtimerevolution/survey.png)](https://codeclimate.com/github/runtimerevolution/survey)
### About

Redmine Contact Directory allows you to see contact details (or other custom user attributes) for your Redmine users. Unlike other contact management plugins that separate contacts from users, this plugin focus on showing data about (some of) your users.

For example it's useful to make sure the Skype handle, mobile phone or some other needed data is readily available to team members.

The plugin takes advantage of existing Redmine infrastructure, such as custom fields, custom field privacy and visibility rules, and Redmine groups, permissions and roles. 

[screenshot]

## Main Features:
 - If you're already a Redmine user, you get a simple and effective team contact or customer list with little effort
 - Each user updates his own info, so effort is distributed
 - Custom fields shown are configurable
 - Doesn't try to reinvent the wheel, makes use of Redmine infrastructure, so should be simple to improve or adapt

## Documentation

For now this README is the only documentation available about the plugin.


## Installation

To install, do the following:

```ruby
  git clone git://github.com/runtimerevolution/redmine_contact_list.git plugins/redmine_contact_list
  bundle install
```

You can also use git submodules, if you prefer.

## Permissions

### Permissions - Who appears in the contact list
In the plugin settings, admins can specify what groups are visible in the contact list. Multiple groups can be specified.

### Permissions - Who can see the contact list
You can specify who has access to the contact list. The existing Redmine permissions infrastructure is used. A new permission called "Contact Directory => View contact directory" will be available in Redmine. 

Since Redmine doesn't (yet) have global permissions, it's enough for this permission to be added to any of the user's project for him to have access to the contact list. 

Until Redmine has global permissions, if more fine grained control is desired, a simple approach is to create a new Role, assign only this permission to the new role, create a group with the users that should have access, create a "Fake" project, add the group to the fake project with the new Role. This approach is not as complicated as it sounds, and does give you fine grained control if you need it.

## Configuration
There are several attributes configurable in the plugin settings:

* Allow anonymous access
* List of groups that are visible in the contact directory
* Custom fields visible in the contact directory
* Wether an avatar for the user should be shown, and if so, it's size


## Compability 

The plugin has been tested in Redmine 2.3 with Rails 3.2 and Ruby 2.0. However, the Redmine APIs used are pretty stable, so no major problems are expected on any recent version of Redmine.

## Roadmap

Some ideas that may be implemented:

- Provide API support
- PDF and other export formats
- Differentiated access levels to the contact directory

Suggestions for new features or patches are welcome.

# License
Copyright © 2013 [Runtime Revolution](http://www.runtime-revolution.com), released under the MIT license.

[![githalytics.com alpha](https://cruel-carlota.pagodabox.com/59be37fe81712a1a4dadc798325a30ee "githalytics.com")](http://githalytics.com/runtimerevolution/survey)
