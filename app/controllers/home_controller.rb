class HomeController < ApplicationController
  def about
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    readme_text = File.read(File.join(Rails.root, 'README.md'))
    @about = renderer.render(readme_text)
  end

  def login
    if request.post?
      user = User.find_by(:email => params[:email])

      if user.nil?
        alert('No user exists with that e-mail address.', :info)
        return redirect_to(login_path)
      end

      if !user.authenticate(params[:password])
        alert('That password is incorrect.', :error)
        return redirect_to(login_path)
      end

      login_user(user)
      alert("Welcome back, #{user.name}!", :success)
      redirect_to(root_path)
    end
  end

  def logout
    logout_user
    alert('See you next time.')
    redirect_to(root_path)
  end

  def register
    if request.post?
      user = User.create!({
        :name => params[:name],
        :email => params[:email],
        :password => params[:password],
        :password_confirmation => params[:password_confirmation]
      })

      login_user(user)
      alert("Thanks for registering, #{user.name}!", :success)
      redirect_to(root_path)
    end
  end
end
