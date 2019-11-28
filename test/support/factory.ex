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
      title: sequence(:title, &"Resource Title #{&1}"),
      href: sequence(:href, &"http://website.com/#{&1}"),
      user: build(:user),
      tags: []
    }
  end

  def comment_factory do
    %LearnSomething.Links.Comment{
      text: "Cool!",
      user: build(:user),
      link: build(:link)
    }
  end

  def tag_factory do
    %LearnSomething.Links.Tag{
      text: sequence("Tag"),
      creator: build(:user)
    }
  end
end
