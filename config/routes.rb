# du7f - a simple web app for simple polls
# Copyright (C) 2011  Adrian Friedli <adi@koalatux.ch>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.

# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


ActionController::Routing::Routes.draw do |map|

  map.new_poll           'new',                               :controller => :polls,        :action => :new,             :conditions => { :method => :get    }
  map.polls              '',                                  :controller => :polls,        :action => :index,           :conditions => { :method => :get    }
  map.polls              '',                                  :controller => :polls,        :action => :create,          :conditions => { :method => :post   }
  map.edit_poll_admin    ':token/admin/:admin_token/edit',    :controller => :polls,        :action => :edit,            :conditions => { :method => :get    }
  map.poll_admin         ':token/admin/:admin_token',         :controller => :polls,        :action => :update,          :conditions => { :method => :put    }
  map.destroy_poll_admin ':token/admin/:admin_token/destroy', :controller => :polls,        :action => :destroy_confirm, :conditions => { :method => :get    }
  map.poll_admin         ':token/admin/:admin_token',         :controller => :polls,        :action => :destroy,         :conditions => { :method => :delete }

  map.poll                ':token',                           :controller => :participants, :action => :index,           :conditions => { :method => :get    }
  map.participants        ':token',                           :controller => :participants, :action => :create,          :conditions => { :method => :post   }
  map.edit_participant    ':token/participant/:id/edit',      :controller => :participants, :action => :edit,            :conditions => { :method => :get    }
  map.participant         ':token/participant/:id',           :controller => :participants, :action => :update,          :conditions => { :method => :put    }
  map.destroy_participant ':token/participant/:id/destroy',   :controller => :participants, :action => :destroy_confirm, :conditions => { :method => :get    }
  map.participant         ':token/participant/:id',           :controller => :participants, :action => :destroy,         :conditions => { :method => :delete }

  map.comments            ':token/comment',                   :controller => :comments,     :action => :create,          :conditions => { :method => :post   }
 #map.edit_comment        ':token/comment/:id/edit',          :controller => :comments,     :action => :edit,            :conditions => { :method => :get    }
 #map.comment             ':token/comment/:id',               :controller => :comments,     :action => :update,          :conditions => { :method => :put    }
  map.destroy_comment     ':token/comment/:id/destroy',       :controller => :comments,     :action => :destroy_confirm, :conditions => { :method => :get    }
  map.comment             ':token/comment/:id',               :controller => :comments,     :action => :destroy,         :conditions => { :method => :delete }

end
