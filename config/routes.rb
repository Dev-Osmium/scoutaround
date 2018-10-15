Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  match '/payment_setup', to: 'stripe#payment_setup', as: 'payment_setup', via: [:get]

  namespace :api do
    resources :units, only: [:show, :update], default: { format: 'json' }
  end

  # resources :requirements
  resources :users,                                  only: [:edit, :update]
  # resources :event_submissions, path: 'submissions', only: [:show]
  # resources :magic_links,       path: 'retrieve',    only: [:show, :destroy]
  # resources :unit_positions,                         only: [:edit, :destroy]
  resources :units, path: '/' do
    get '/', to: 'announcements#index'
    get '/payments/setup', to: 'stripe#show' # return route for Stripe onboarding

    resources :events do
      resources :event_registrations,   path: 'registrations'
      resources :event_requirements,    path: 'requirements'
      resources :event_submissions,     path: 'submissions'
      resources :attendances,           path: 'attendance'
      resources :messages
      post :publish
    end

    # resources :achievements,            path: 'advancement'

    # scope module: 'memberships', path: 'members' do
    #   resources :achievements
    # end

    resources :messages,                path: 'announcements'
    resources :payments
    resources :membership_imports
    resources :event_requirements,      path: 'requirements' do
      resources :event_submissions,     path: 'submissions'
    end

    resources :event_submissions,       path: 'submissions'
    resources :memberships,             path: 'members' do
      resources :achievements,          path: 'advancement'
    end
    scope module: 'units' do
      resources :achievements, only: [:index, :update], path: 'advancement'
    end
    resources :document_library_items,  path: 'documents'
    resources :wiki_articles,           path: 'wiki'
    resources :magic_links,             path: 'shares'
    resources :unit_positions,          path: 'positions'

    resources :unit_settings,           path: 'settings'

    get 'subscription',     to: 'subscriptions#show'
    # get 'settings',         to: 'units#show'
    # get 'settings/info',    to: 'units#edit'
  end

  # resources :memberships, path: 'members', shallow: true do
  #   scope module: 'memberships' do
  #     resources :achievements, path: 'advancement'
  #   end
  # end

  # resources :events, shallow: true do
  #   scope module: 'events' do
  #     resources :messages
  #     resources :event_registrations, path: 'registrations'
  #     resources :event_submissions,   path: 'submissions'
  #     resources :event_requirements,  path: 'checklist'
  #   end
  # end

  # resources :event_requirements, path: 'checklist', shallow: true do
  #   scope module: 'event_requirements' do
  #     resources :magic_links, path: 'share'
  #     resources :event_submissions, path: 'submit'
  #   end
  # end

  # # resources :event_submissions, path: 'submit'
  # # resources :event_registrations

  # resources :members
  # resources :status
end
