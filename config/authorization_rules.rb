#########################################################
# Authorization rules for use with the
# Declarative Authorization gem.
#########################################################

authorization do
  role :admin do
    includes :user
    has_permission_on :admin_users, to: :manage
    has_permission_on :admin_users, to: :delete do
      if_attribute id: is_not {user.id}
    end
  end

  role :user do
    includes :guest
    has_permission_on :admin_users, to: [:create, :edit, :update] do
      if_attribute id: is {user.id}
    end
    has_permission_on :cvs, to: [:manage, :delete] do
      if_permitted_to :manage, :user
    end
  end

  role :guest do
    has_permission_on :cvs, to: :read
  end
end

privileges do
  privilege :manage, includes: [:create, :read, :update]
  privilege :read, includes: [:index, :show]
  privilege :create, includes: :new
  privilege :update, includes: :edit
  privilege :delete, includes: :destroy
end