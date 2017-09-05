# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
get 'fund_role_configs', :to => 'fund_role_configs#index'

get 'fund_role_configs(/:action(/:id))', controller: :fund_role_configs
post 'fund_role_configs(/:action(/:id))', controller: :fund_role_configs
patch 'fund_role_configs(/:action(/:id))', controller: :fund_role_configs
put 'fund_role_configs(/:action(/:id))', controller: :fund_role_configs


get 'fund_factor_configs', :to => 'fund_factor_configs#index'

get 'fund_factor_configs(/:action(/:id))', controller: :fund_factor_configs
post 'fund_factor_configs(/:action(/:id))', controller: :fund_factor_configs
patch 'fund_factor_configs(/:action(/:id))', controller: :fund_factor_configs
put 'fund_factor_configs(/:action(/:id))', controller: :fund_factor_configs

resources :funds, :only => [:index, :edit, :update]

get 'fund/frozen', :to => 'funds#frozen', :as => 'frozen'
get 'fund/unfrozen', :to => 'funds#unfrozen', :as => 'unfrozen'
get 'fund/update_frozen/:id', :to => 'funds#update_frozen'