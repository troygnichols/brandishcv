class UsersDatatable < AbstractDatatable

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: User.with_permissions_to(:read, context: :admin_users).count,
      iTotalDisplayRecords: users.total_count,
      aaData: data
    }
  end

  private

    COLUMNS = %w[username email]

    def data
      users.map do |user|
        [
          link_to(user.username, controller: 'users', action: 'show', id: user.id),
          link_to(user.email, controller: 'users', action: 'show', id: user.id)
        ]
      end
    end

    def users
      @users ||= fetch_users
    end

    def fetch_users
      users = User.with_permissions_to(:read, context: :admin_users)
      users = users.order("#{sort_column} #{sort_direction}")
      users = users.page(page).per(per_page)
      users = filter users
    end

    def sort_column
      COLUMNS[params[:iSortCol_0].to_i]
    end

    def filter(users)
      COLUMNS.each_with_index do |col, i|
        if params["sSearch_#{i}"].present?
          search_term = params["sSearch_#{i}"].strip
          users = users.where("#{col} like :search", search: "%#{search_term}%")
        end
      end
      users
    end
end
