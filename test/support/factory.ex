defmodule LearnSomething.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: LearnSomething.Repo

  def user_factory do
    %LearnSomething.Accounts.User{
      name: "Jane Smith",
      email: sequence(:email, &"email-#{&1}@example.com")
    }
  end

  def link_factory do
    %LearnSomething.Links.Link{
      title: "Google - a handy search engine",
      href: "http://google.com"
    }
  end
end
