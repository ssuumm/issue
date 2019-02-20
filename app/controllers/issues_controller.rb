class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :update, :destroy]

  # GET /issues
  def index
    params[:issue_customs]&.each do |issue_custom|
      issue_custom[:selected_values] = issue_custom[:selected_values].map { |v| v == '-1' ? nil : v } if issue_custom[:selected_values].present?
    end
    @issues = Issue.search(params)
    render 'issues/index.json.jbuilder'
  end

  # GET /issues/1
  def show
    render json: @issue
  end

  # POST /issues
  def create
    @issue = Issue.new(issue_params)

    if @issue.save
      render json: @issue, status: :created, location: @issue
    else
      render json: @issue.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /issues/1
  def update
    if @issue.update(issue_params)
      render json: @issue
    else
      render json: @issue.errors, status: :unprocessable_entity
    end
  end

  # DELETE /issues/1
  def destroy
    @issue.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def issue_params
      params.require(:issue).permit(:title, :content)
    end
end
