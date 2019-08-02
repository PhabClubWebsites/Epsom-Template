Rails.application.routes.draw do
  get 'contact/new'

  devise_for :admins, controllers: { registrations: 'admins/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  get 'what-is-phab', to: 'pages#about'
  get 'club-news', to: 'pages#news'
  get 'whats-on', to: 'pages#events'
  get 'shop', to: 'pages#shop'
  get 'contact-us', to: 'pages#contact_us'
  get 'about-us', to: 'pages#about_us'
  
  get 'dashboard', to: 'admins#dashboard'
  get 'admins', to: 'admins#index'
  
  get 'gallery_list', to: 'galleries#gallery_admin'
  get 'event_list', to: 'pages#event_list'
  get 'news_list', to: 'pages#news_list'
  get 'home_list', to: 'pages#home_list'
  get 'about_list', to: 'pages#about_list'
  get 'volunteer_list', to: 'pages#volunteer_list'
  
  get 'website/banners', to: 'clubs#website_banners'

  delete "delete_admin", to: "admins#delete_admin"
  
  resources :pages do
    member do
  		get :published
  		put :remove_image
  	end
  end
  
  resources :clubs do
    member do
  		put :remove_image
  	end
  end
  
  resources :galleries do 
    member do
  		get :published
  	end
    resources :pictures do
      member do
        post :make_default
      end
    end
  end
  
  
  resources :contacts, only: [:new, :create]
  
  
  
  
end
