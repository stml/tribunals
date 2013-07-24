class Admin::DecisionsController < ApplicationController
  layout 'layouts/admin'
  before_filter :authenticate

  def index
    @decisions = self.class.scope.paginate(:page => params[:page], :per_page => 30).ordered
  end

  def create
    @decision = Decision.new(decision_params)
    if @decision.save
      @decision.process_doc
      redirect_to admin_decisions_path
    else
      render new_admin_decision_path
    end
  end

  def new
    @decision ||= Decision.new
  end

  def edit
    @decision = self.class.scope.find(params[:id])
  end

  def update
    @decision = self.class.scope.find(params[:id])
    @decision.update_attributes!(decision_params)
    redirect_to admin_decisions_path
  rescue
    redirect_to edit_admin_decision_path(@decision)
  end

  def self.scope
    Decision.all
  end

  private
  def authenticate
    request.env['warden'].authenticate!
  end

  def decision_params
    params.require(:decision).permit(:doc_file, :promulgated_on, :appeal_number, :reported, :starred, :panel,
                                     :anonymised, :country_guideline, :judges, :categories, :country, :claimant,
                                     :keywords, :case_notes)
  end
end
