class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

end
