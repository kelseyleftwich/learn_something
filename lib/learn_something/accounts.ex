defmodule LearnSomething.Accounts do
  alias LearnSomething.Accounts.User
  alias LearnSomething.Repo



  def authenticate(%{email: email}) do
    Repo.get_by(User, email: email)
  end

end
